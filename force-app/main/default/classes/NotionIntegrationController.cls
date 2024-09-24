global with sharing class NotionIntegrationController {
    @AuraEnabled
    public static String createDatabase(String dbName) {
      // Fetch the custom setting values
      NotionConfig__mdt notionConfig = [
        SELECT
          Notion_Key__c,
          Notion_Page_Id__c
        FROM NotionConfig__mdt
        WHERE DeveloperName = 'Test_Noton_Yuriy'
        LIMIT 1
      ];
      if (notionConfig == null) {
        throw new AuraHandledException('Notion configuration not found');
      }
      
      String notionKey = notionConfig.NOTION_KEY__c;
      String notionPageId = notionConfig.NOTION_PAGE_ID__c;
  
      HttpRequest req = new HttpRequest();
      Http http = new Http();
      req.setEndpoint('https://api.notion.com/v1/databases');
      req.setMethod('POST');
      req.setHeader('Authorization', 'Bearer ' + notionKey);
      req.setHeader('Notion-Version', '2022-06-28');
      req.setHeader('Content-Type', 'application/json');
  
      Map<String, Object> payload = new Map<String, Object>();
      Map<String, Object> parent = new Map<String, Object>();
      parent.put('type', 'page_id');
      parent.put('page_id', notionPageId);
  
      payload.put('parent', parent);
      payload.put('title', new List<Map<String, Object>>{
        new Map<String, Object>{
          'type' => 'text',
          'text' => new Map<String, Object>{
            'content' => dbName
          }
        }
      });
  
      payload.put('properties', new Map<String, Object>{
        'Name' => new Map<String, Object>{
          'title' => new Map<String, Object>()
        }
      });
  
      req.setBody(JSON.serialize(payload));
  
      HttpResponse res = http.send(req);
  
      if (res.getStatusCode() == 200) {
        return 'success';
      } else {
        throw new AuraHandledException('Failed to create database: ' + res.getBody());
      }
    }
}

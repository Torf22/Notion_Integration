global with sharing class NotionIntegrationController {

  @AuraEnabled(cacheable=true)
  public static List<String> getNotionContext() {
      String httpMethod = 'POST';
      String httpEndpointData = 'search';
      HttpResponse response = NotionHttpService.getResponse(httpMethod, httpEndpointData);
      return getContext(response);
  }

  public static List<String> getContext(HttpResponse res){
    List<String> listContext = new List<String>();
      Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
      List<Object> results = (List<Object>) responseMap.get('results');
      for (Object result : results) {
          Map<String, Object> databaseMap = (Map<String, Object>) result;
          String id = (String) databaseMap.get('id');
          if (databaseMap.containsKey('properties')) {
            // System.debug('databaseMap: ' + propertiesMap);
              Map<String, Object> propertiesMap = (Map<String, Object>) databaseMap.get('properties');
              System.debug('databaseMap: ' + propertiesMap);
              if (propertiesMap.containsKey('Title')) {
                System.debug('propertiesMap: ' + propertiesMap);
                  Map<String, Object> titleProperty = (Map<String, Object>) propertiesMap.get('Title');
                  if (titleProperty.containsKey('title')) {
                    System.debug('titleProperty: ' + titleProperty);
                      List<Object> titleList = (List<Object>) titleProperty.get('title');
                      if (!titleList.isEmpty()) {
                        System.debug('titleList: ' + titleList);
                        for (Object titleItem : titleList) {
                          Map<String, Object> titleMap = (Map<String, Object>) titleItem;
                          if (titleMap.containsKey('plain_text')) {
                              String plainText = (String) titleMap.get('plain_text');
                              listContext.add(plainText);
                              System.debug('plain_text: ' + plainText);
                          }
                        }
                      }
                  }
              }
          }
      }
    return listContext;
  }
}

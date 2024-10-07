public with sharing class NotionHttpService {
    public static HttpResponse getResponse(String httpMethod, String httpEndpointData) {
        
        HttpRequest req = new HttpRequest();
        Http http = new Http();

        req.setEndpoint('callout:Named_Test_Cred/v1/' + httpEndpointData);
        req.setMethod(httpMethod);
        req.setHeader('Notion-Version', '2022-06-28');
        req.setHeader('Content-Type', 'application/json');

        Map<String, Object> payload = new Map<String, Object>();
        Map<String, Object> filter = new Map<String, Object>();
        filter.put('value', 'page');
        filter.put('property', 'object');
        payload.put('filter', filter);
  
        req.setBody(JSON.serialize(payload));

        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200) {
            return res;
        } else {
            throw new AuraHandledException('Failed to retrieve pages from Notion: ' + res.getBody());
        }
    }
}
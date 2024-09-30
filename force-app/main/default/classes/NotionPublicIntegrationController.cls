public with sharing class NotionPublicIntegrationController {
    public String redirectUrl { get; set; }
    
    public NotionPublicIntegrationController() {
        String code = ApexPages.currentPage().getParameters().get('code');
        if (code != null) {
            System.debug('Received code: ' + code);
        }
    }


    @AuraEnabled
    public static String getAuthorizationUrl() {
        NotionConfig__mdt notionConfig = [
            SELECT
            OAUTH_CLIENT_ID__c, 
             OAUTH_CLIENT_SECRET__c
            FROM NotionConfig__mdt
            WHERE DeveloperName = 'Test_Public_Integration'
            LIMIT 1
        ];
        String clientId = notionConfig.OAUTH_CLIENT_ID__c;
        String redirectUri = 'https://freelance107-dev-ed.develop.lightning.force.com/apex/NotionRedirectPage';
        String authUrl = 'https://api.notion.com/v1/oauth/authorize?response_type=code&client_id=' + clientId + '&redirect_uri=' + redirectUri + '&owner=user';
        return authUrl;
    }

    // @AuraEnabled
    // public static String handleAuthRedirect(String code) {
    //     NotionConfig__mdt notionConfig = [
    //         SELECT
    //         OAUTH_CLIENT_ID__c, 
    //          OAUTH_CLIENT_SECRET__c
    //         FROM NotionConfig__mdt
    //         WHERE DeveloperName = 'Test_Public_Integration'
    //         LIMIT 1
    //     ];
    //     String clientId = notionConfig.OAUTH_CLIENT_ID__c;
    //     String clientSecret = notionConfig.OAUTH_CLIENT_SECRET__c;
    //     String redirectUri = 'https://freelance107-dev-ed.develop.my.salesforce.com/oauth2/callback';
        
    //     String credentials = clientId + ':' + clientSecret;
    //     String encodedCredentials = EncodingUtil.base64Encode(Blob.valueOf(credentials));
        
    //     HttpRequest req = new HttpRequest();
    //     req.setEndpoint('https://api.notion.com/v1/oauth/token');
    //     req.setMethod('POST');
    //     req.setHeader('Authorization', 'Basic ' + encodedCredentials);
    //     req.setHeader('Content-Type', 'application/json');
        
    //     String requestBody = '{"grant_type":"authorization_code","code":"' + code + '","redirect_uri":"' + redirectUri + '"}';
    //     req.setBody(requestBody);
        
    //     Http http = new Http();
    //     HttpResponse res;
    //     try {
    //         res = http.send(req);
    //     } catch (Exception e) {
    //         throw new AuraHandledException('HTTP request failed: ' + e.getMessage());
    //     }
        
    //     if (res.getStatusCode() == 200) {
    //         System.debug('response Bod --- ' + res.getBody());
    //         return res.getBody();
    //     } else {
    //         throw new AuraHandledException('Failed to exchange code for access token: ' + res.getBody());
    //     }
    // }
}
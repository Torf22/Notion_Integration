
import { LightningElement, track, wire } from 'lwc';
// import { CurrentPageReference } from 'lightning/navigation';
// import getAuthorizationUrl from '@salesforce/apex/NotionPublicIntegrationController.getAuthorizationUrl';
// import getIsHasCode from '@salesforce/apex/NotionPublicIntegrationController.getIsHasCode';
// import handleAuthRedirect from '@salesforce/apex/NotionPublicIntegrationController.handleAuthRedirect';

export default class NotionPublicIntegration extends LightningElement {
    @track isHasCode = false;
    @track authorizationCode;

    connectedCallback() {
        const urlParams = new URLSearchParams(window.location.search);
        this.authorizationCode = urlParams.get('code');
        this.isHasCode = urlParams.get('isHasCode') === 'true';
    }

    // authorizeWithNotion() {
    //     getAuthorizationUrl()
    //         .then((url) => {
    //             window.location.href = url;
    //         })
    //         .catch((error) => {
    //             console.error('Error getting authorization URL: ', error);
    //         });
    // }
    // @track code;
    // // @track authCode;
    // // @track accessToken;
    // // @track isHasCode = false;
    // @track authorizationCode;

    // // @wire (getAuthorizationCodeStatus) 
    // // wiredAuthorizationCodeStatus({ error, data }) {
    // //     if (data) {
    // //         this.isHasCode = data;
    // //         // Отримайте code з URL якщо потрібно
    // //         const urlParams = new URLSearchParams(window.location.search);
    // //         this.authorizationCode = urlParams.get('code');
    // //     } else if (error) {
    // //         console.error('Error fetching authorization code status:', error);
    // //     }
    // // }

    // exchangeCodeForToken() {
    //     // Логіка для обміну authorization code на token
    // }

    // connectedCallback() {
    //     console.log('window.location ---- ', window.location);


    //     const params = new URLSearchParams(window.location.search);
    //     console.log('isHasCode ---- ', isHasCode);
    //     this.code = params.get('code');
    //     this.isHasCode = params.get('isHasCode') === 'true';

    //     if (this.code) {
    //         sessionStorage.setItem('oauth_code', this.code);
    //         // Очистка URL
    //         const newUrl = window.location.origin + window.location.pathname;
    //         window.history.replaceState({}, document.title, newUrl);
    //     } else {
    //         // Спроба отримати код з sessionStorage
    //         this.code = sessionStorage.getItem('oauth_code');
    //     }
    // }

    // authorizeWithNotion() {
    //     getAuthorizationUrl()
    //         .then((url) => {
    //             window.location.href = url;
    //         })
    //         .catch((error) => {
    //             console.error('Error getting authorization URL: ', error);
    //         });
    // }

    // authorizeWithNotion() {
    //     const urlParams = new URLSearchParams(window.location.search);
    //     const code = urlParams.get('code');
    //     const redirectUri = window.location.href;
    //     getAuthorizationUrl({ code, redirectUri })
    //         .then((url) => {
    //             window.location.href = url;
    //             const urlParams = new URLSearchParams(window.location.search);
    //             const code = urlParams.get('code');
    //             console.log('code ---- ', code);
    //             console.log('href ---- ', window.location.href);
    //         })
    //         .catch((error) => {
    //             console.error('Error getting authorization URL: ', error);
    //         });
    // }

    // // connectedCallback() {
    // //     console.log('window.location ---- ', window.location.href);
    // //     const urlParams = new URLSearchParams(window.location.search);
    // //     const code = urlParams.get('code');
    // //     if (code) {
    // //         this.authCode = code;
    // //         const newUrl = window.location.origin + window.location.pathname;
    // //         window.history.replaceState({}, document.title, newUrl);
    // //     }
    // // }

    // exchangeCodeForToken() {
    //     handleAuthRedirect({ code: this.authCode })
    //         .then((response) => {
    //             this.accessToken = response;
    //         })
    //         .catch((error) => {
    //             console.error('Error exchanging code for token: ', error);
    //         });
    // }
}

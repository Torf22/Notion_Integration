
import { LightningElement, track } from 'lwc';
import getAuthorizationUrl from '@salesforce/apex/NotionPublicIntegrationController.getAuthorizationUrl';
// import handleAuthRedirect from '@salesforce/apex/NotionPublicIntegrationController.handleAuthRedirect';

export default class NotionPublicIntegration extends LightningElement {
    @track code;
    // @track authCode;
    // @track accessToken;

    connectedCallback() {
        const params = new URLSearchParams(window.location.search);
        this.code = params.get('code');

        if (this.code) {
            sessionStorage.setItem('oauth_code', this.code);
            // Очистка URL
            const newUrl = window.location.origin + window.location.pathname;
            window.history.replaceState({}, document.title, newUrl);
        } else {
            // Спроба отримати код з sessionStorage
            this.code = sessionStorage.getItem('oauth_code');
        }
    }

    authorizeWithNotion() {
        getAuthorizationUrl()
            .then((url) => {
                window.location.href = url;
                console.log('href ---- ', window.location.href);
            })
            .catch((error) => {
                console.error('Error getting authorization URL: ', error);
            });
    }

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

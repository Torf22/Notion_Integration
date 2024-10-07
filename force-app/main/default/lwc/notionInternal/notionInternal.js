import { LightningElement, track } from 'lwc';
import getNotionContext from '@salesforce/apex/NotionIntegrationController.getNotionContext';

export default class DatabaseForm extends LightningElement {
 
    @track context;
    @track error;

    connectedCallback() {
        this.fetchNotionContext();
    }

    fetchNotionContext() {
        getNotionContext()
            .then(result => {
                this.context = result;
                
                console.log('context ---- ', this.context);
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.context = undefined;
            });
    }
}
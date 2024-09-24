import { LightningElement, track } from 'lwc';
import createDatabase from '@salesforce/apex/NotionIntegrationController.createDatabase';

export default class DatabaseForm extends LightningElement {
  @track dbName = '';
  @track responseMessage = '';

  handleInputChange(event) {
    this.dbName = event.target.value;
  }

  async handleSubmit() {
    try {
      const response = await createDatabase({ dbName: this.dbName });
      this.responseMessage = 'Database created successfully!';
    } catch (error) {
      this.responseMessage = 'Error creating database: ' + error.body.message;
    }
  }
}
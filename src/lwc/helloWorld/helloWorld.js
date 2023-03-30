/**
 * Created by administrator on 10.09.20.
 */

import { LightningElement } from 'lwc';
export default class HelloWorld extends LightningElement {
    greeting = 'World';
    changeHandler(event) {
        this.greeting = event.target.value;
    }
}
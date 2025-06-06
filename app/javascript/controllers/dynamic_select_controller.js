import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['select', 'choice', 'long', 'number'];

  connect() {
    this.selected();
  }

  selected() {
    console.log('selected');
    console.log(this.selectTarget.value);
    console.log(this.choiceTarget.classList);
    this.hideFields();
    switch (this.selectTarget.value) {
      case 'single_choice':
        this.choiceTarget.classList.remove('hidden');
        break;
      case 'multiple_choice':
        this.choiceTarget.classList.remove('hidden');
        break;
      case 'long_answer':
        this.longTarget.classList.remove('hidden');
        break;
      case 'number_answer':
        this.longTarget.classList.remove('hidden');
        break;
    }
  }

  hideFields() {
    this.choiceTarget.classList.add('hidden');
    this.longTarget.classList.add('hidden');
  }
}

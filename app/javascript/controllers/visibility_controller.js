import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'deliveryModified',
    'contentModified',
    'notDelivered',
    'option',
  ];

  toggle({ target }) {
    if (target.dataset.visibilityAnswerNumberValue == '1') {
      this.deliveryModifiedTarget.style.display = 'none';
      this.contentModifiedTarget.style.display = 'none';
      this.notDeliveredTarget.style.display = 'none';
    } else if (target.dataset.visibilityAnswerNumberValue == '2') {
      this.deliveryModifiedTarget.style.display = 'block';
      this.contentModifiedTarget.style.display = 'none';
      this.notDeliveredTarget.style.display = 'none';
    } else if (target.dataset.visibilityAnswerNumberValue == '3') {
      this.deliveryModifiedTarget.style.display = 'none';
      this.contentModifiedTarget.style.display = 'block';
      this.notDeliveredTarget.style.display = 'none';
    } else if (target.dataset.visibilityAnswerNumberValue == '4') {
      this.deliveryModifiedTarget.style.display = 'none';
      this.contentModifiedTarget.style.display = 'none';
      this.notDeliveredTarget.style.display = 'block';
    }
  }
}

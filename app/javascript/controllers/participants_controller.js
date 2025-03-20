import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  add(event) {
    event.preventDefault();
    const template = document.getElementsByTagName('template')[0];
    let content = template.innerHTML;
    const participantsTarget =
      document.getElementsByClassName('participants')[0];
    participantsTarget.insertAdjacentHTML('beforebegin', content);
  }

  remove(event) {
    event.preventDefault();
    event.target.closest('.participant').remove();
  }
}

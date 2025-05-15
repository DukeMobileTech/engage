import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  add(event) {
    event.preventDefault();
    const template = document.getElementsByTagName('template')[0];
    let content = template.innerHTML;
    const sittingsTarget =
      document.getElementsByClassName('sittings')[0];
    sittingsTarget.insertAdjacentHTML('beforebegin', content);
  }

  remove(event) {
    event.preventDefault();
    event.target.closest('.sitting').remove();
  }
}

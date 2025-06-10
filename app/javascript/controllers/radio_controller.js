import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  clear(event) {
    event.preventDefault();
    // Find all radio buttons within this controller's element and uncheck them
    this.element.querySelectorAll('input[type="radio"]').forEach(radio => {
      radio.checked = false;
    });
  }
}

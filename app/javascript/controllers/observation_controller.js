import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['mainSelect', 'secondarySelect', 'tertiarySelect'];
  static values = {
    url: String,
    selected: String,
    url2: String,
    selected2: String,
  };

  connect() {
    if (this.selectValue().length > 0) {
      this.fetch();
    }
    if (this.select2Value().length > 0) {
      this.fetch2();
    }
  }

  change() {
    this.fetch();
  }

  change2() {
    this.fetch2();
  }

  selectValue() {
    return this.mainSelectTarget.selectedOptions[0].value;
  }

  select2Value() {
    return this.secondarySelectTarget.selectedOptions[0].value;
  }

  fetch() {
    fetch(`${this.urlValue}?${this.params()}`, {
      headers: {
        Accept: 'text/vnd.turbo-stream.html',
      },
    })
      .then((r) => r.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }

  fetch2() {
    fetch(`${this.url2Value}?${this.params2()}`, {
      headers: {
        Accept: 'text/vnd.turbo-stream.html',
      },
    })
      .then((r) => r.text())
      .then((html) => Turbo.renderStreamMessage(html));
  }

  params() {
    let params = new URLSearchParams();
    params.append('site_id', this.selectValue());
    params.append('select', this.secondarySelectTarget.id);
    params.append('selected', this.selectedValue);
    return params;
  }

  params2() {
    let params = new URLSearchParams();
    params.append('section_id', this.select2Value());
    params.append('select', this.tertiarySelectTarget.id);
    params.append('selected', this.selected2Value);
    return params;
  }
}

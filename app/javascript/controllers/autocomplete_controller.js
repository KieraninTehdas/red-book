import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "results"];
  static values = { url: String };

  initialize() {
    this.search = this.debounce(this.search);
  }

  debounce(func, delay = 500) {
    let timer;
    return (...args) => {
      clearTimeout(timer);
      timer = setTimeout(() => {
        func.apply(this, args);
      }, delay);
    };
  }

  async search() {
    const queryString = this.inputTarget.value;
    if (!queryString) {
      return;
    }

    // Well this is grim
    const url = new URL(`http://${window.location.host}${this.urlValue}`);
    url.searchParams.append("name", queryString);

    const results = await fetch(url.toString()).then((res) => res.json());

    const options = results.map(
      (book) =>
        `<option value=${book.id} label="${book.name}">${book.name}</option>`
    );

    console.log(this.resultsTarget);
    console.log(options);
    this.resultsTarget.innerHTML = options;
    console.log(this.resultsTarget);
  }
}

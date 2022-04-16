import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };
  static targets = ["input"];

  populateInput() {
    console.log(this.urlValue);
    this.inputTarget.value = "Some Stuff";
    this.inputTarget.style.display = "inline";
  }
}

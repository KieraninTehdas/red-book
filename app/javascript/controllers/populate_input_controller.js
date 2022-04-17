import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };
  static targets = ["input", "inputContainer"];

  populateInput() {
    fetch(this.urlValue, {
      headers: { "Content-Type": "application/json" },
    }).then((response) => {
      response.json().then((body) => {
        this.inputTarget.value = body;
        this.inputContainerTarget.style.display = "inline";
      });
    });
  }
}

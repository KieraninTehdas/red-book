import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String };
  static targets = ["value"];
  toggle(event) {
    event.preventDefault();
    const updatedCheckboxValue = this.valueTarget.checked;

    fetch(this.urlValue, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify({ updated_value: updatedCheckboxValue }),
    }).then((response) => console.log(response));
  }
}

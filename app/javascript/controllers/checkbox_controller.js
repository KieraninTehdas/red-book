import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["value"];
  toggle(event) {
    event.preventDefault();
    console.log(this.valueTarget);
    console.log(this.valueTarget.checked);
  }
}

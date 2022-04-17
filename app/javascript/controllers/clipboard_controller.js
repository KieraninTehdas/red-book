import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "alertPlaceholder"];

  copy() {
    navigator.clipboard.writeText(this.sourceTarget.value);

    if (!!this.alertPlaceholderTarget) {
      this.showAlert("List copied to clipboard!", "success");
    }
  }

  showAlert(message, type) {
    if (this.alertPlaceholderTarget.childElementCount > 0) {
      return;
    }

    const wrapper = document.createElement("div");
    wrapper.innerHTML = `<div class="alert alert-${type} alert-dismissible" role="alert">
        ${message}
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>`;
    this.alertPlaceholderTarget.append(wrapper);
  }
}

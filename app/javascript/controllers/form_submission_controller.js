import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submission"
export default class extends Controller {
  static targets = ["button"]

  submit(event) {
    // Desabilita o botão para impedir cliques duplos
    this.buttonTarget.disabled = true;

    // Muda o texto e adiciona um ícone de "spinner" do Bootstrap
    this.buttonTarget.innerHTML = `
      <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
      Gerando sua obra de arte...
    `;
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['form', 'content']
  connect() {
    this.element.addEventListener("turbo:submit-end", (event) => {
      console.log(event.detail)
      const [, , xhr] = event.detail;

      this.handleContent(xhr.response)
    });
  }

  handleContent(content) {
    console.log('kkkkkkkkkkkkkkkkkkkk')
    console.log(content)
    // this.contentTarget.innerHTML = content
  }
}

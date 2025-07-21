import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["totalPrice", "modalTotalPrice", "submitFormBtn"]

  // Add to cart logic
  addToCart(event) {
    const button = event.target
    const card = button.closest('.video-type-card')
    const id = card.dataset.id
    const price = parseFloat(card.dataset.price)
    const hiddenInput = document.getElementById(`video_type_input_${id}`)
    
    if (hiddenInput.disabled) {
      hiddenInput.disabled = false
      card.classList.add('border-success', 'shadow')
      button.textContent = "Remove from Cart"
      button.classList.remove('btn-primary')
      button.classList.add('btn-danger')
      this.updateTotalPrice(price)
    } else {
      hiddenInput.disabled = true
      card.classList.remove('border-success', 'shadow')
      button.textContent = "Add to Cart"
      button.classList.remove('btn-danger')
      button.classList.add('btn-primary')
      this.updateTotalPrice(-price)
    }
  }

  // Update the total price in the main view
  updateTotalPrice(priceChange) {
    const currentTotal = parseFloat(this.totalPriceTarget.textContent)
    this.totalPriceTarget.textContent = (currentTotal + priceChange).toFixed(2)

    // Also update the modal's total price
    const modalTotalPrice = document.getElementById("modalTotalPrice")
    if (modalTotalPrice) {
      modalTotalPrice.textContent = (currentTotal + priceChange).toFixed(2)
    }
  }

  // Handle Pay button logic (inside modal)
  pay(event) {
    // You can add validation logic here if necessary before submitting
    document.querySelector('#orderProjectForm').submit()
  }
}

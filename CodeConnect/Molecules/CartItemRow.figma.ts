// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=22-93
// source=Swappy/DesignSystem/Molecules/CartItemRow.swift
// component=CartItemRow
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");

const priceText = instance.findText("price", {
  traverseInstances: true,
  path: ["text-stack", "price"],
});
const price =
  priceText && priceText.type !== "ERROR"
    ? priceText.textContent.replace(/[^0-9.]/g, "")
    : "39.99";
const originalPriceText = instance.findText("original-price", {
  traverseInstances: true,
  path: ["text-stack", "price"],
});
const originalPrice =
  originalPriceText && originalPriceText.type !== "ERROR"
    ? originalPriceText.textContent.replace(/[^0-9.]/g, "")
    : "59.99";
const countText = instance.findText("count", {
  traverseInstances: true,
  path: ["text-stack", "bottom-row", "quantity-stepper"],
});
const quantity =
  countText && countText.type !== "ERROR" ? countText.textContent : "2";

const product = `Product(
            id: 1, title: "${title}", description: "", category: "", price: ${originalPrice}, discountPercentage: 20,
            rating: 4.8, stock: 10, tags: [], brand: nil, sku: "SKU-1", dimensions: nil, warrantyInformation: "",
            shippingInformation: "", availabilityStatus: "In Stock", reviews: [], returnPolicy: "",
            minimumOrderQuantity: 1, images: [], thumbnail: "https://example.com/image.jpg"
        )`;
const cartItem = `CartItem(product: ${product}, quantity: ${quantity})`;

export default {
  example: figma.code`CartItemRow(item: ${cartItem}, onQuantityChange: { _ in }, onRemove: {})`,
  id: "cart-item-row",
  metadata: { nestable: true },
};

// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=19-5
// source=Swappy/DesignSystem/Molecules/ProductRow.swift
// component=ProductRow
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");
const showQuantity = instance.getBoolean("Show Quantity");
const quantityLabel = instance.getString("Quantity Label");
const quantityMatch = quantityLabel.match(/\d+/);
const quantity = showQuantity && quantityMatch ? quantityMatch[0] : null;

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

const product = `Product(
            id: 1, title: "${title}", description: "", category: "", price: ${originalPrice}, discountPercentage: 20,
            rating: 4.8, stock: 10, tags: [], brand: nil, sku: "SKU-1", dimensions: nil, warrantyInformation: "",
            shippingInformation: "", availabilityStatus: "In Stock", reviews: [], returnPolicy: "",
            minimumOrderQuantity: 1, images: [], thumbnail: "https://example.com/image.jpg"
        )`;

const call = quantity
  ? `ProductRow(product: ${product}, quantity: ${quantity})`
  : `ProductRow(product: ${product})`;

export default {
  example: figma.code`${call}`,
  id: "product-row",
  metadata: { nestable: true },
};

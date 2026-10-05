// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=18-5
// source=Swappy/DesignSystem/Molecules/ProductCard.swift
// component=ProductCard
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");

// These display values aren't exposed as top-level component properties —
// they're derived internally from the `product` model, so read them off
// their nested text layers instead.
const priceText = instance.findText("price", {
  traverseInstances: true,
  path: ["price"],
});
const price =
  priceText && priceText.type !== "ERROR"
    ? priceText.textContent.replace(/[^0-9.]/g, "")
    : "39.99";
const originalPriceText = instance.findText("original-price", {
  traverseInstances: true,
  path: ["price"],
});
const originalPrice =
  originalPriceText && originalPriceText.type !== "ERROR"
    ? originalPriceText.textContent.replace(/[^0-9.]/g, "")
    : "59.99";
const badgeText = instance.findText("label", {
  traverseInstances: true,
  path: ["image-stack", "discount-badge"],
});
const discountPercentage =
  badgeText && badgeText.type !== "ERROR"
    ? badgeText.textContent.replace(/[^0-9.]/g, "")
    : "20";
const ratingText = instance.findText("rating", {
  traverseInstances: true,
  path: ["rating"],
});
const rating =
  ratingText && ratingText.type !== "ERROR" ? ratingText.textContent : "4.8";

const product = `Product(
            id: 1,
            title: "${title}",
            description: "",
            category: "",
            price: ${originalPrice},
            discountPercentage: ${discountPercentage},
            rating: ${rating},
            stock: 10,
            tags: [],
            brand: nil,
            sku: "SKU-1",
            dimensions: nil,
            warrantyInformation: "",
            shippingInformation: "",
            availabilityStatus: "In Stock",
            reviews: [],
            returnPolicy: "",
            minimumOrderQuantity: 1,
            images: [],
            thumbnail: "https://example.com/image.jpg"
        )`;

export default {
  example: figma.code`ProductCard(product: ${product}, isFavorite: false, onToggleFavorite: {})`,
  id: "product-card",
  metadata: { nestable: true },
};

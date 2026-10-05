// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=23-5
// source=Swappy/DesignSystem/Molecules/OrderCard.swift
// component=OrderCard
import figma from "figma";

const instance = figma.selectedInstance;
const orderNumber = instance.getString("Order Number");
const orderIdMatch = orderNumber.match(/\d+/);
const orderId = orderIdMatch ? orderIdMatch[0] : "1";
const meta = instance.getString("Meta");
const metaMatch = meta.match(/(\d+)\s*items?/);
const itemCount = metaMatch ? metaMatch[1] : "12";

const statusText = instance.findText("label", {
  traverseInstances: true,
  path: ["header-row", "status"],
});
const statusLabel =
  statusText && statusText.type !== "ERROR"
    ? statusText.textContent
    : "Shipped";
const STATUS_MAP = {
  Processing: ".processing",
  Shipped: ".shipped",
  "Out for delivery": ".outForDelivery",
  Delivered: ".delivered",
  Cancelled: ".cancelled",
};
const status = STATUS_MAP[statusLabel] || ".shipped";

const priceText = instance.findText("price", {
  traverseInstances: true,
  path: ["footer-row", "price"],
});
const price =
  priceText && priceText.type !== "ERROR"
    ? priceText.textContent.replace(/[^0-9.]/g, "")
    : "39.99";

const items = Array.from({ length: Math.min(parseInt(itemCount, 10) || 1, 4) })
  .map(
    (_, i) =>
      `OrderItem(productId: ${i + 1}, title: "Item ${
        i + 1
      }", thumbnail: "https://example.com/image.jpg", price: ${price}, quantity: 1)`,
  )
  .join(", ");

const order = `Order(
            id: ${orderId},
            items: [${items}],
            status: ${status},
            placedDate: Date(),
            total: ${price},
            discountedTotal: ${price},
            sellerIds: [1]
        )`;

export default {
  example: figma.code`OrderCard(order: ${order}) {}`,
  id: "order-card",
  metadata: { nestable: true },
};

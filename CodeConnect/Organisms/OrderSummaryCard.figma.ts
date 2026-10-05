// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=32-25
// source=Swappy/DesignSystem/Organisms/OrderSummaryCard.swift
// component=OrderSummaryCard
import figma from "figma";

const parseMoney = (s) => {
  const m = s.replace(/[^0-9.]/g, "");
  return m || "0";
};

const instance = figma.selectedInstance;
const subtotalText = instance.findText("value", {
  traverseInstances: true,
  path: ["subtotal-row"],
});
const subtotal =
  subtotalText && subtotalText.type !== "ERROR"
    ? parseMoney(subtotalText.textContent)
    : "588.98";
const discountText = instance.findText("value", {
  traverseInstances: true,
  path: ["discount-row"],
});
const discount =
  discountText && discountText.type !== "ERROR"
    ? parseMoney(discountText.textContent)
    : "75.56";
const shippingText = instance.findText("value", {
  traverseInstances: true,
  path: ["shipping-row"],
});
const shipping =
  shippingText && shippingText.type !== "ERROR"
    ? parseMoney(shippingText.textContent)
    : "0";

export default {
  example: figma.code`OrderSummaryCard(subtotal: ${subtotal}, discount: ${discount}, shipping: ${shipping})`,
  id: "order-summary-card",
  metadata: { nestable: true },
};

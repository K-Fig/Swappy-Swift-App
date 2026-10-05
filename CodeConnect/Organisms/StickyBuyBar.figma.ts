// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=35-5
// source=Swappy/DesignSystem/Organisms/StickyBuyBar.swift
// component=StickyBuyBar
import figma from "figma";

const parseMoney = (s) => {
  const m = s.match(/[\d.]+/);
  return m ? m[0] : "0";
};

const instance = figma.selectedInstance;
const priceText = instance.findText("price", {
  traverseInstances: true,
  path: ["price-stack", "price"],
});
const price =
  priceText && priceText.type !== "ERROR"
    ? parseMoney(priceText.textContent)
    : "39.99";
const originalPriceText = instance.findText("original-price", {
  traverseInstances: true,
  path: ["price-stack", "price"],
});
const originalPrice =
  originalPriceText && originalPriceText.type !== "ERROR"
    ? parseMoney(originalPriceText.textContent)
    : null;

const call = originalPrice
  ? `StickyBuyBar(price: ${price}, originalPrice: ${originalPrice}, onMessageSeller: {}, onAddToCart: {})`
  : `StickyBuyBar(price: ${price}, onMessageSeller: {}, onAddToCart: {})`;

export default {
  example: figma.code`${call}`,
  id: "sticky-buy-bar",
  metadata: { nestable: true },
};

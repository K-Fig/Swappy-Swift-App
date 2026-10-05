// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=12-11
// source=Swappy/DesignSystem/Atoms/PriceTag.swift
// component=PriceTag
import figma from "figma";

const parseMoney = (s) => {
  const m = s.match(/[\d.]+/);
  return m ? m[0] : "0";
};

const instance = figma.selectedInstance;
const price = parseMoney(instance.getString("Price"));
const state = instance.getEnum("State", {
  Default: "default",
  Discounted: "discounted",
});
const originalPrice =
  state === "discounted"
    ? parseMoney(instance.getString("Original Price"))
    : null;

const call = originalPrice
  ? `PriceTag(price: ${price}, originalPrice: ${originalPrice})`
  : `PriceTag(price: ${price})`;

export default {
  example: figma.code`${call}`,
  id: "price-tag",
  metadata: { nestable: true },
};

// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=29-5
// source=Swappy/DesignSystem/Molecules/PromoBanner.swift
// component=PromoBanner
import figma from "figma";

const ICON_MAP = {
  "Chevron Right": "chevron.right",
  Heart: "heart",
  Plus: "plus",
  Minus: "minus",
  Search: "magnifyingglass",
  Cart: "cart",
  Trash: "trash",
  Checkmark: "checkmark",
  Bubble: "bubble.left.fill",
  "Arrow Up": "arrow.up",
  Box: "shippingbox",
  Xmark: "xmark",
  Photo: "photo",
  "Warning Triangle": "exclamationmark.triangle.fill",
};

const instance = figma.selectedInstance;
const title = instance.getString("Title");
const subtitle = instance.getString("Subtitle");

const iconInstance = instance.getInstanceSwap("Icon");
const iconName = iconInstance ? iconInstance.name.replace("Icon/", "") : "Box";
const icon = ICON_MAP[iconName] || "sparkles";

export default {
  example: figma.code`PromoBanner(title: "${title}", subtitle: "${subtitle}", icon: "${icon}") {}`,
  id: "promo-banner",
  metadata: { nestable: true },
};

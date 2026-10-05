// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=26-104
// source=Swappy/DesignSystem/Molecules/MenuRow.swift
// component=MenuRow
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
const showTrailingText = instance.getBoolean("Show Trailing Text");
const trailingText = instance.getString("Trailing Text");

const iconInstance = instance.getInstanceSwap("Icon");
const iconName = iconInstance ? iconInstance.name.replace("Icon/", "") : "Box";
const icon = ICON_MAP[iconName] || "questionmark";

const call = showTrailingText
  ? `MenuRow(title: "${title}", icon: "${icon}", trailingText: "${trailingText}") {}`
  : `MenuRow(title: "${title}", icon: "${icon}") {}`;

export default {
  example: figma.code`${call}`,
  id: "menu-row",
  metadata: { nestable: true },
};

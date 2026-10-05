// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=9-27
// source=Swappy/DesignSystem/Atoms/SWIconButton.swift
// component=SWIconButton
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
const isActive = instance.getEnum("Active", { False: false, True: true });
const iconInstance = instance.getInstanceSwap("Icon");
const iconName = iconInstance
  ? iconInstance.name.replace("Icon/", "")
  : "Heart";
const icon = ICON_MAP[iconName] || "questionmark";

export default {
  example: figma.code`SWIconButton(icon: "${icon}", isActive: ${isActive}) {}`,
  id: "sw-icon-button",
  metadata: { nestable: true },
};

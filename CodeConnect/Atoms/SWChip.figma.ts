// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=9-13
// source=Swappy/DesignSystem/Atoms/SWChip.swift
// component=SWChip
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
const title = instance.getString("Label");
const hasIcon = instance.getBoolean("Has Icon");
const isSelected = instance.getEnum("Selected", { False: false, True: true });

let iconCode = "nil";
if (hasIcon) {
  const iconInstance = instance.getInstanceSwap("Icon");
  const iconName = iconInstance
    ? iconInstance.name.replace("Icon/", "")
    : "Chevron Right";
  iconCode = `"${ICON_MAP[iconName] || "questionmark"}"`;
}

export default {
  example: figma.code`SWChip(title: "${title}", icon: ${iconCode}, isSelected: ${isSelected}) {}`,
  id: "sw-chip",
  metadata: { nestable: true },
};

// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=11-5
// source=Swappy/DesignSystem/Atoms/SWTextField.swift
// component=SWTextField
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
const placeholder = instance.getString("Placeholder");
const hasIcon = instance.getBoolean("Has Icon");

let iconCode = "nil";
if (hasIcon) {
  const iconInstance = instance.getInstanceSwap("Icon");
  const iconName = iconInstance
    ? iconInstance.name.replace("Icon/", "")
    : "Search";
  iconCode = `"${ICON_MAP[iconName] || "questionmark"}"`;
}

export default {
  example: figma.code`SWTextField(placeholder: "${placeholder}", text: .constant(""), icon: ${iconCode})`,
  id: "sw-text-field",
  metadata: { nestable: true },
};

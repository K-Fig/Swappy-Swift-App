// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=10-57
// source=Swappy/DesignSystem/Atoms/SWButton.swift
// component=SWButton
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
const style = instance.getEnum("Style", {
  Primary: ".primary",
  Secondary: ".secondary",
  Outline: ".outline",
  Destructive: ".destructive",
});
const isLoading = instance.getEnum("Loading", { False: false, True: true });

let iconCode = "nil";
if (hasIcon) {
  const iconInstance = instance.getInstanceSwap("Icon");
  const iconName = iconInstance
    ? iconInstance.name.replace("Icon/", "")
    : "Cart";
  iconCode = `"${ICON_MAP[iconName] || "questionmark"}"`;
}

export default {
  example: figma.code`SWButton(title: "${title}", icon: ${iconCode}, style: ${style}, isLoading: ${isLoading}) {}`,
  id: "sw-button",
  metadata: { nestable: true },
};

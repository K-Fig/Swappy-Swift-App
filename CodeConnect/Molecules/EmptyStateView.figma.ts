// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=29-118
// source=Swappy/DesignSystem/Molecules/EmptyStateView.swift
// component=EmptyStateView
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");
const message = instance.getString("Message");
const showAction = instance.getBoolean("Show Action");

const actionLabelText = instance.findText("label", {
  traverseInstances: true,
  path: ["action-button"],
});
const actionTitle =
  actionLabelText && actionLabelText.type !== "ERROR"
    ? actionLabelText.textContent
    : "Start shopping";

const call = showAction
  ? `EmptyStateView(icon: "cart", title: "${title}", message: "${message}", actionTitle: "${actionTitle}") {}`
  : `EmptyStateView(icon: "cart", title: "${title}", message: "${message}")`;

export default {
  example: figma.code`${call}`,
  id: "empty-state-view",
  metadata: { nestable: true },
};

// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=29-136
// source=Swappy/DesignSystem/Molecules/ErrorStateView.swift
// component=ErrorStateView
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");
const message = instance.getString("Message");

const retryLabelText = instance.findText("label", {
  traverseInstances: true,
  path: ["action-button"],
});
const retryTitle =
  retryLabelText && retryLabelText.type !== "ERROR"
    ? retryLabelText.textContent
    : "Try again";

export default {
  example: figma.code`ErrorStateView(title: "${title}", message: "${message}", retryTitle: "${retryTitle}") {}`,
  id: "error-state-view",
  metadata: { nestable: true },
};

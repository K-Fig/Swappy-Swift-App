// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=12-27
// source=Swappy/DesignSystem/Atoms/StatusPill.swift
// component=StatusPill
import figma from "figma";

const instance = figma.selectedInstance;
const text = instance.getString("Label");
const tone = instance.getEnum("Tone", {
  Info: ".info",
  Shipped: ".shipped",
  Progress: ".progress",
  Success: ".success",
  Neutral: ".neutral",
  Danger: ".danger",
});

export default {
  example: figma.code`StatusPill(text: "${text}", tone: ${tone})`,
  id: "status-pill",
  metadata: { nestable: true },
};

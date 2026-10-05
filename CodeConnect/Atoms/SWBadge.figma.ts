// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=8-15
// source=Swappy/DesignSystem/Atoms/SWBadge.swift
// component=SWBadge
import figma from "figma";

const instance = figma.selectedInstance;
const text = instance.getString("Label");
const style = instance.getEnum("Style", {
  Discount: ".discount",
  New: ".new",
  Success: ".success",
  Warning: ".warning",
  Neutral: ".neutral",
});

export default {
  example: figma.code`SWBadge(text: "${text}", style: ${style})`,
  id: "sw-badge",
  metadata: { nestable: true },
};

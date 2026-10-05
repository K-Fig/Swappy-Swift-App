// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=33-5
// source=Swappy/DesignSystem/Organisms/OrderTimeline.swift
// component=OrderTimeline
import figma from "figma";

// The design has no property exposing which step is current — the 4 step
// labels are always present and their "complete" styling isn't readable as
// text content, so there's no Figma-side signal to drive `status` from.
export default {
  example: figma.code`OrderTimeline(status: .shipped, placedDate: Date())`,
  id: "order-timeline",
  metadata: { nestable: true },
};

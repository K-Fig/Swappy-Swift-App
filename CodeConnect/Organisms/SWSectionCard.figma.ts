// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=38-5
// source=Swappy/DesignSystem/Organisms/SWSectionCard.swift
// component=SWSectionCard
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");
const subtitle = instance.getString("Subtitle");
const actionLabel = instance.getString("Action Label");

// The icon isn't an INSTANCE_SWAP property on this instance (it's fixed to
// Icon/Box in this design), so it's reflected as a literal rather than a
// dynamic lookup.
const contentSlot = instance.findInstance("content-slot", {
  traverseInstances: true,
});
let contentCode;
if (contentSlot && contentSlot.type === "INSTANCE") {
  contentCode = contentSlot.executeTemplate().example;
}

export default {
  example: figma.code`SWSectionCard(title: "${title}", subtitle: "${subtitle}", icon: "shippingbox", tint: .swPrimary, actionTitle: "${actionLabel}", action: {}) {
        ${contentCode}
    }`,
  id: "sw-section-card",
  metadata: { nestable: true },
};

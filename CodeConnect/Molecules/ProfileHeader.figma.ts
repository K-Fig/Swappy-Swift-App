// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=28-123
// source=Swappy/DesignSystem/Molecules/ProfileHeader.swift
// component=ProfileHeader
import figma from "figma";

const instance = figma.selectedInstance;
const name = instance.getString("Name");
const subtitle = instance.getString("Subtitle");

const statValueText = instance.findText("value", {
  traverseInstances: true,
  path: ["stats-row", "stat"],
});
const statValue =
  statValueText && statValueText.type !== "ERROR"
    ? statValueText.textContent
    : "18";
const statLabelText = instance.findText("label", {
  traverseInstances: true,
  path: ["stats-row", "stat"],
});
const statLabel =
  statLabelText && statLabelText.type !== "ERROR"
    ? statLabelText.textContent
    : "Listings";

export default {
  example: figma.code`ProfileHeader(
        name: "${name}",
        subtitle: "${subtitle}",
        avatarURL: nil,
        initials: "JS",
        stats: [("${statValue}", "${statLabel}")],
        trailingAction: ("square.and.arrow.up", {})
    )`,
  id: "profile-header",
  metadata: { nestable: true },
};

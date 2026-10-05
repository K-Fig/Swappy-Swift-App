// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=13-69
// source=Swappy/DesignSystem/Atoms/SectionHeader.swift
// component=SectionHeader
import figma from "figma";

const instance = figma.selectedInstance;
const title = instance.getString("Title");
const hasAction = instance.getEnum("Has Action", { False: false, True: true });
const actionTitle = instance.getString("Action Label");

const call = hasAction
  ? `SectionHeader(title: "${title}", actionTitle: "${actionTitle}") {}`
  : `SectionHeader(title: "${title}")`;

export default {
  example: figma.code`${call}`,
  id: "section-header",
  metadata: { nestable: true },
};

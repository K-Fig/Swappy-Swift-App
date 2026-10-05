// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=13-12
// source=Swappy/DesignSystem/Atoms/AvatarView.swift
// component=AvatarView
import figma from "figma";

const instance = figma.selectedInstance;
const type = instance.getEnum("Type", { Image: "image", Initials: "initials" });
const initials = instance.getString("Initials");
const urlCode =
  type === "image" ? 'URL(string: "https://example.com/avatar.jpg")' : "nil";

export default {
  example: figma.code`AvatarView(url: ${urlCode}, initials: "${initials}")`,
  id: "avatar-view",
  metadata: { nestable: true },
};

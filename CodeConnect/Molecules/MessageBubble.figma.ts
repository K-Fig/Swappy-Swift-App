// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=25-13
// source=Swappy/DesignSystem/Molecules/MessageBubble.swift
// component=MessageBubble
import figma from "figma";

const instance = figma.selectedInstance;
const text = instance.getString("Text");
const isFromUser = instance.getEnum("From User", { False: false, True: true });

export default {
  example: figma.code`MessageBubble(message: Message(text: "${text}", isFromUser: ${isFromUser}))`,
  id: "message-bubble",
  metadata: { nestable: true },
};

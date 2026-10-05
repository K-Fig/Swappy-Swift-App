// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=34-5
// source=Swappy/DesignSystem/Organisms/ChatInputBar.swift
// component=ChatInputBar
import figma from "figma";

// ChatInputBar hardcodes its placeholder ("Message") internally — there's no
// code prop for it, so the only representable values are `text` and `onSend`.
export default {
  example: figma.code`ChatInputBar(text: .constant(""), onSend: {})`,
  id: "chat-input-bar",
  metadata: { nestable: true },
};

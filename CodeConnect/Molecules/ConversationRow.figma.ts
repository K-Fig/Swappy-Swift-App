// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=25-17
// source=Swappy/DesignSystem/Molecules/ConversationRow.swift
// component=ConversationRow
import figma from "figma";

const instance = figma.selectedInstance;
const sellerName = instance.getString("Seller Name");
const preview = instance.getString("Preview");

const conversation = `Conversation(
            sellerId: 1,
            sellerName: "${sellerName}",
            sellerAvatarURL: nil,
            messages: [Message(text: "${preview}", isFromUser: false)]
        )`;

export default {
  example: figma.code`ConversationRow(conversation: ${conversation}) {}`,
  id: "conversation-row",
  metadata: { nestable: true },
};

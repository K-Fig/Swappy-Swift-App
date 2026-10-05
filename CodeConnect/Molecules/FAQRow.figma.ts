// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=26-5
// source=Swappy/DesignSystem/Molecules/FAQRow.swift
// component=FAQRow
import figma from "figma";

const instance = figma.selectedInstance;
const question = instance.getString("Question");

const faq = `FAQ(id: 1, category: .buying, question: "${question}", answer: "")`;

export default {
  example: figma.code`FAQRow(faq: ${faq}) {}`,
  id: "faq-row",
  metadata: { nestable: true },
};

// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=20-66
// source=Swappy/DesignSystem/Molecules/SearchBar.swift
// component=SearchBar
import figma from "figma";

const instance = figma.selectedInstance;
const placeholderText = instance.findText("placeholder", {
  traverseInstances: true,
  path: ["text-field"],
});
const placeholder =
  placeholderText && placeholderText.type !== "ERROR"
    ? placeholderText.textContent
    : "Search Swappy";

export default {
  example: figma.code`SearchBar(text: .constant(""), placeholder: "${placeholder}")`,
  id: "search-bar",
  metadata: { nestable: true },
};

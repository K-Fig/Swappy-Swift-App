// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=37-5
// source=Swappy/DesignSystem/Organisms/FilterSheet.swift
// component=FilterSheet
import figma from "figma";

// Only init parameter is the filterState binding — every visible label
// (Reset/Apply/section headers) is static copy in the view, not a prop.
export default {
  example: figma.code`FilterSheet(filterState: .constant(ProductFilterState()))`,
  id: "filter-sheet",
  metadata: { nestable: true },
};

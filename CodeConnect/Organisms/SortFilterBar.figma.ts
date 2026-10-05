// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=36-5
// source=Swappy/DesignSystem/Organisms/SortFilterBar.swift
// component=SortFilterBar
import figma from "figma";

// Both params are bindings with no defaults and no Figma-side properties
// (the chip labels are internal computed state, not settable inputs).
export default {
  example: figma.code`SortFilterBar(sortOption: .constant(.relevance), filterState: .constant(ProductFilterState()))`,
  id: "sort-filter-bar",
  metadata: { nestable: true },
};

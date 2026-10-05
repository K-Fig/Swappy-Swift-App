// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=20-5
// source=Swappy/DesignSystem/Molecules/CategoryTile.swift
// component=CategoryTile
import figma from "figma";

const instance = figma.selectedInstance;
const label = instance.getString("Label");
const slug = label.toLowerCase().replace(/\s+/g, "-");

export default {
  example: figma.code`CategoryTile(category: ProductCategory(slug: "${slug}", name: "${label}", url: "")) {}`,
  id: "category-tile",
  metadata: { nestable: true },
};

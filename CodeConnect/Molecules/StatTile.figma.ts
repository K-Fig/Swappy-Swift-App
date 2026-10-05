// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=28-5
// source=Swappy/DesignSystem/Molecules/StatTile.swift
// component=StatTile
import figma from "figma";

const instance = figma.selectedInstance;
const value = instance.getString("Value");
const label = instance.getString("Label");

export default {
  example: figma.code`StatTile(value: "${value}", label: "${label}")`,
  id: "stat-tile",
  metadata: { nestable: true },
};

// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=11-50
// source=Swappy/DesignSystem/Atoms/RatingStars.swift
// component=RatingStars
import figma from "figma";

const instance = figma.selectedInstance;
const rating = instance.getString("Rating");
const showCount = instance.getBoolean("Show Count");
const countRaw = instance.getString("Count");
const countMatch = countRaw.match(/\d+/);
const reviewCount = showCount && countMatch ? countMatch[0] : null;

const call = reviewCount
  ? `RatingStars(rating: ${rating}, reviewCount: ${reviewCount})`
  : `RatingStars(rating: ${rating})`;

export default {
  example: figma.code`${call}`,
  id: "rating-stars",
  metadata: { nestable: true },
};

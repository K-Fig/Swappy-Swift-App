// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=22-5
// source=Swappy/DesignSystem/Molecules/ReviewCard.swift
// component=ReviewCard
import figma from "figma";

const instance = figma.selectedInstance;
const reviewerName = instance.getString("Reviewer Name");
const comment = instance.getString("Comment");

const ratingText = instance.findText("rating", {
  traverseInstances: true,
  path: ["header-row", "name-stack", "rating"],
});
const ratingValue =
  ratingText && ratingText.type !== "ERROR"
    ? Math.round(parseFloat(ratingText.textContent))
    : 5;

const review = `Review(
            rating: ${ratingValue}, comment: "${comment}", date: "2026-01-01", reviewerName: "${reviewerName}", reviewerEmail: "reviewer@example.com"
        )`;

export default {
  example: figma.code`ReviewCard(review: ${review})`,
  id: "review-card",
  metadata: { nestable: true },
};

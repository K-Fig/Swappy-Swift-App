// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=21-5
// source=Swappy/DesignSystem/Molecules/SellerCard.swift
// component=SellerCard
import figma from "figma";

const instance = figma.selectedInstance;
const name = instance.getString("Name");
const stats = instance.getString("Stats");
// "Stats" renders as "<listings> listings · <city>" — split it back into fields.
const statsMatch = stats.match(/(\d+)\s*listings\s*·\s*(.+)/);
const listingsCount = statsMatch ? statsMatch[1] : "18";
const city = statsMatch ? statsMatch[2] : "Austin";

const ratingText = instance.findText("rating", {
  traverseInstances: true,
  path: ["text-stack", "rating"],
});
const rating =
  ratingText && ratingText.type !== "ERROR" ? ratingText.textContent : "4.8";

const seller = `Seller(
            id: 1, name: "${name}", avatarURL: nil, initials: "JS", city: "${city}", country: "United States",
            rating: ${rating}, listingsCount: ${listingsCount}
        )`;

export default {
  example: figma.code`SellerCard(seller: ${seller}, onMessage: {}, onTap: {})`,
  id: "seller-card",
  metadata: { nestable: true },
};

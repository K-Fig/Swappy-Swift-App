// url=https://www.figma.com/design/y3J7vt9JC9r3C9qEx03maK/Untitled?node-id=11-39
// source=Swappy/DesignSystem/Atoms/QuantityStepper.swift
// component=QuantityStepper
import figma from "figma";

const instance = figma.selectedInstance;
const quantity = instance.getString("Quantity");

export default {
  example: figma.code`QuantityStepper(quantity: .constant(${quantity}))`,
  id: "quantity-stepper",
  metadata: { nestable: true },
};

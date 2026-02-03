import React from "react";

export const SummaryCard = ({ title, value, note }) => {
  return (
    <article className="summary-card">
      <p className="summary-card__title">{title}</p>
      <p className="summary-card__value">{value}</p>
      <p className="summary-card__note">{note}</p>
    </article>
  );
};

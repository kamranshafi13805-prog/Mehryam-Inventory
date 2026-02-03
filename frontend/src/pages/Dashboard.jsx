import React from "react";
import { SummaryCard } from "../components/SummaryCard";
import "../styles/dashboard.css";

export const Dashboard = () => {
  return (
    <div className="dashboard">
      <section className="dashboard__summary">
        <SummaryCard title="Total Articles" value="1,245" note="Across all collections" />
        <SummaryCard title="Low Stock" value="32" note="Below minimum threshold" />
        <SummaryCard title="Open Orders" value="58" note="Pending & packed" />
        <SummaryCard title="Fabric Remaining" value="12,400 m" note="Across all rolls" />
      </section>

      <section className="dashboard__grid">
        <div className="panel">
          <h2>Recent Stock Movement</h2>
          <ul>
            <li>OUT: Blue Lawn Suit - M (Walk-in) - 5 pcs</li>
            <li>IN: Khaddar Roll #K-92 (Supplier) - 520 m</li>
            <li>OUT: Emerald Suit - L (Online) - 2 pcs</li>
          </ul>
        </div>
        <div className="panel">
          <h2>Pending Approvals</h2>
          <ul>
            <li>Return #R-2043 (3 items)</li>
            <li>Stock Adjustment #SA-145 (Outlet)</li>
            <li>Transfer #TR-088 (Warehouse → Outlet)</li>
          </ul>
        </div>
        <div className="panel">
          <h2>Top Selling Articles</h2>
          <ul>
            <li>Zephyr Collection - SKU ZC-144 (122 units)</li>
            <li>Nova Embroidery - SKU NE-210 (97 units)</li>
            <li>Lush Lawn - SKU LL-310 (84 units)</li>
          </ul>
        </div>
      </section>
    </div>
  );
};

import React from "react";
import { Dashboard } from "./pages/Dashboard";

export const App = () => {
  return (
    <div className="app-shell">
      <header className="app-header">
        <h1>Mehryam Inventory System</h1>
        <span className="role-pill">Admin</span>
      </header>
      <main className="app-content">
        <Dashboard />
      </main>
    </div>
  );
};

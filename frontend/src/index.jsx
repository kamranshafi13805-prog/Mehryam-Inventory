import React from "react";
import { createRoot } from "react-dom/client";
import { App } from "./App";
import "./styles/dashboard.css";

const root = createRoot(document.getElementById("root"));
root.render(<App />);

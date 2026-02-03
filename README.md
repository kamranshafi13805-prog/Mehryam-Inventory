# Mehryam Clothing Inventory & Production Management System

Production-ready blueprint for a **web-based** clothing inventory & production management system built with **Laravel + MySQL** (backend) and **React** (frontend). It focuses on **traceability**, **role-based access**, and **audit-friendly data flows**.

## Core Goals
- Track fabric, accessories, and finished goods from inbound to sale.
- Ensure **every action is logged** and **no data is permanently deleted** (soft-delete / archive only).
- Provide clear roles: **Admin** and **Store Manager**.

## Repository Structure
```
backend/   Laravel-style API skeleton (routes/controllers/models)
frontend/  React UI skeleton (pages/components)
docs/      Database schema & API documentation
```

## Quick Start (Planned)
1. Configure backend env and DB.
2. Run migrations and seed roles/users.
3. Start API and frontend dev servers.

> This repo contains the schema + API contract and starter code to implement the full system.

## Key Modules
- Articles & variants (size + color)
- Stock IN/OUT ledger with reasons
- Orders, returns, and cancellations
- Fabric (meter-wise) inventory with consumption tracking
- Accessories inventory with usage history
- Production workflow (cutting, stitching, vendor tracking)
- Multi-location stock & transfers
- Reports & alerts
- Activity logs and approvals

See `docs/schema.sql` and `docs/api.md` for details.

# API Contract (Laravel REST)

Base URL: `/api/v1`

## Auth
- `POST /auth/login`
- `POST /auth/logout`
- `GET /auth/me`

## Users & Roles (Admin)
- `GET /roles`
- `GET /users`
- `POST /users`
- `PATCH /users/{id}`
- `POST /users/{id}/archive`

## Articles & Variants
- `GET /articles`
- `POST /articles`
- `GET /articles/{id}`
- `PATCH /articles/{id}`
- `POST /articles/{id}/archive`
- `POST /articles/{id}/images`
- `GET /variants`
- `POST /variants`

## Stock & Ledger
- `GET /stock/balances`
- `POST /stock/movements` (IN/OUT ledger entry)
- `GET /stock/ledger`

## Orders & Returns
- `GET /orders`
- `POST /orders`
- `PATCH /orders/{id}`
- `POST /orders/{id}/cancel`
- `POST /returns`
- `POST /returns/{id}/approve`

## Fabrics
- `GET /fabrics`
- `POST /fabrics`
- `POST /fabrics/{id}/consume`

## Accessories
- `GET /accessories`
- `POST /accessories`
- `POST /accessories/{id}/use`

## Production
- `GET /productions`
- `POST /productions`
- `PATCH /productions/{id}`

## Locations & Transfers
- `GET /locations`
- `POST /locations`
- `GET /transfers`
- `POST /transfers`
- `POST /transfers/{id}/receive`

## Reports
- `GET /reports/fast-moving`
- `GET /reports/dead-stock`
- `GET /reports/size-shortage`
- `GET /reports/fabric-consumption`
- `GET /reports/profit-per-article`
- `GET /reports/season-sales`

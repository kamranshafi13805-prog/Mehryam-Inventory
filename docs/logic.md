# Stock, Order, and Return Logic

## Stock Movement
- Every stock change is a **ledger entry** (`stock_ledgers`).
- Balances are **aggregated** into `stock_balances` per location + item.
- No ledger entries are deleted; corrections use **reversal entries**.

## Orders
1. Create order → insert order + items.
2. Create stock OUT ledger entries per item.
3. Update balances.

## Cancel / Return
- Cancel: add stock IN ledger entries to reverse quantities.
- Return: create return entry + items, then **Admin approves** return which posts stock IN.

## Fabric Consumption
- When fabric is consumed, decrement `fabrics.remaining_meters`.
- Also post ledger entry for traceability.

## Transfer
- Transfer creates OUT ledger at source and IN ledger at destination when received.

## Approvals
- Admin approves stock adjustments, returns, and transfer receipts.

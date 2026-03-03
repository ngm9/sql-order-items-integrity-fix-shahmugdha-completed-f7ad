# Task Overview
Utkrusht operates a proof-of-skills marketplace and maintains a small demo e-commerce database to generate realistic analytics tasks. This PostgreSQL database is fully deployed and populated for you, but it was intentionally created with missing integrity constraints on the `order_items` table, which has allowed invalid quantities and references to non-existent orders/products to slip in. Your job is to work only at the SQL level to clean up this data and add basic relational safeguards so future inserts cannot recreate these issues, all within a time-bounded exercise.

The existing schema and data load successfully and the environment is ready to use; you do not need to fix deployment or initialization. Instead, focus on identifying the bad rows, correcting them with careful DML, and then adding appropriate keys and constraints so that basic-level SQL integrity and reporting needs are met.

## Objectives
- Identify existing `order_items` rows that either reference non-existent `orders` or `products` or have non-positive quantities.
- Use SQL DML (UPDATE/DELETE) to fix or remove only the problematic rows so that the remaining data is consistent and reasonable.
- Add a PRIMARY KEY to the `order_items` table and appropriate FOREIGN KEY constraints to link it to the `orders` and `products` tables.
- Add a CHECK constraint on `order_items` to ensure that all future `quantity` values are strictly greater than zero.
- Create at least one verification query using JOINs across 2–3 tables that confirms:
  - There are no `order_items` referencing missing `orders` or `products`.
  - All `quantity` values in `order_items` are positive.

## Database Access
- Host: `<DROPLET_IP>` (or `localhost` if running Docker locally)
- Port: `5432`
- Database name: `utkrusht_store`
- Username: `utkrusht_user`
- Password: `utkrusht_pass`

You can connect using any PostgreSQL client you prefer, such as `psql`, pgAdmin, DBeaver, DataGrip, or another SQL tool. Once connected, ensure you are using the `utkrusht_store` database before running analysis or changes.

## How to Verify
- Run the queries from `sample_queries.sql` before making changes to observe the current issues:
  - Queries that use LEFT JOINs to `orders` and `products` will show `order_items` rows with missing parent records.
  - Aggregation across `order_items` may include zero or negative quantities, affecting totals.
- After you perform your data cleanup and add constraints:
  - Re-run the orphan-detection queries; they should now return zero rows, indicating there are no `order_items` pointing to non-existent `orders` or `products`.
  - Check that all `quantity` values are strictly positive using a simple SELECT with a WHERE clause; this should return no rows for invalid quantities.
  - Attempt to insert an `order_items` row with a non-existent `order_id` or `product_id`, or with `quantity <= 0`; this should fail due to your FOREIGN KEY and CHECK constraints.
  - Use `EXPLAIN` on your verification JOIN query to ensure it still runs reasonably and uses the keys/constraints appropriately for basic integrity and lookup behavior.

## Helpful Tips
- Consider which tables represent parent entities (`orders`, `products`) and which table (`order_items`) should depend on them.
- Think about how to detect orphan rows using JOINs, especially using LEFT JOIN combined with a filter on NULLs in the parent side.
- Review how CHECK constraints work in PostgreSQL and how they can enforce simple column rules such as positive numeric values.
- Explore how PRIMARY KEY and FOREIGN KEY constraints help guarantee uniqueness and referential integrity between related tables.
- Review the sample queries to understand the existing problems before deciding whether each bad row should be fixed (e.g. corrected quantity) or removed.
- Consider running your verification queries both before and after your changes to clearly see the impact of your fixes and constraints.

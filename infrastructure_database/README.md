# Infrastructure Database (PostgreSQL)

This folder contains the PostgreSQL database setup scripts, Flyway-compatible SQL migrations, and helper scripts for the UP Tourism Infrastructure Management System.

## Contents

- db/migration/V1__init.sql — Initial schema for all modules and relationships
- db/migration/V2__seed.sql — Seed data for roles and initial admin user
- startup.sh — Local bootstrap for a Postgres instance (for dev use only)
- backup_db.sh, restore_db.sh — Generic backup/restore helpers
- db_visualizer/ — Lightweight DB viewer server and env examples

## Environment Variables

Standardize on the following environment variables (do not hardcode credentials in code):

- POSTGRES_HOST: Database host (default: localhost)
- POSTGRES_PORT: Database port (default: 5001)
- POSTGRES_DB: Database name (default: myapp)
- POSTGRES_USER: Database user (default: appuser)
- POSTGRES_PASSWORD: Database password (default: dbuser123)
- POSTGRES_URL: Optional full connection URL (e.g. postgresql://host:port/dbname)

These env vars should be defined via your deployment environment (.env) and consumed by backend services.

## Flyway Integration

Point Flyway to `db/migration` for migrations. For example:

- Locations: filesystem:infrastructure_database/db/migration
- SQL migrations follow the naming convention: `V<version>__<description>.sql`

Flyway command example (conceptual):

flyway -url=jdbc:postgresql://$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -user=$POSTGRES_USER -password=$POSTGRES_PASSWORD migrate

## Schema Highlights

- UUID primary keys for most domain tables; SERIAL PK for roles.
- Unique constraints on usernames, emails, contractor names, project codes, tender reference numbers, and invoice numbers.
- Foreign keys use ON DELETE CASCADE/SET NULL where appropriate.
- Audit columns `created_at` and/or `updated_at` maintained by triggers for key tables.
- Soft-delete-ready `status` columns exist on several entities (users, projects, tenders, payments, invoices, inspections, support_tickets, etc.).

## Seeding

- Default roles: ADMIN, PM, ENGINEER, AUDITOR
- Initial admin user: username `admin`, email `admin@example.com`
  - Uses a placeholder password hash. Backend must replace on first login/reset.

## Local Development Notes

- Default port standardized to 5001 for consistency with the running container metadata.
- Update the `db_visualizer/postgres.env` if needed, or source env vars from your own `.env`.

## Security

- Never commit real passwords. Use environment variables.
- Rotate the initial admin password immediately on first run.

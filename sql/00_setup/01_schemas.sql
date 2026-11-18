CREATE SCHEMA IF NOT EXISTS raw;       -- untouched source data (PaySim, generated dims)
CREATE SCHEMA IF NOT EXISTS staging;   -- cleaned, typed, deduplicated
CREATE SCHEMA IF NOT EXISTS core;      -- dimensions, facts, ledger
CREATE SCHEMA IF NOT EXISTS marts;     -- feature tables and business aggregates
CREATE SCHEMA IF NOT EXISTS audit;     -- DQ failures, predictions, model versions

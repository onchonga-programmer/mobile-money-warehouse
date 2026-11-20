CREATE TABLE IF NOT EXISTS core.dim_customer (
    customer_key bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id text NOT NULL,
    kyc_tier text NOT NULL
    CHECK (kyc_tier IN ('tier1', 'tier2', 'tier3')),
    region_id integer,
    valid_from timestamptz NOT NULL,
    valid_to timestamptz NOT NULL DEFAULT 'infinity',
    is_current boolean NOT NULL DEFAULT true,
    CHECK (valid_from < valid_to),
    UNIQUE (customer_id, valid_from)
);

-- At most one current row per customer (partial index: PostgreSQL-specific syntax)
CREATE UNIQUE INDEX IF NOT EXISTS uq_dim_customer_current
ON core.dim_customer (customer_id) WHERE is_current;

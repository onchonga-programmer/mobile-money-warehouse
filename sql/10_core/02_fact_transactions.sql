CREATE TABLE IF NOT EXISTS core.fact_transactions (
    transaction_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    source_row_id bigint NOT NULL UNIQUE, -- row number in the PaySim file
    step integer NOT NULL CHECK (step BETWEEN 1 AND 743),
    txn_ts timestamptz NOT NULL, -- base date + step hours
    txn_type text NOT NULL
    CHECK (txn_type IN ('CASH_IN', 'CASH_OUT', 'DEBIT', 'PAYMENT', 'TRANSFER')),
    amount numeric(14, 2) NOT NULL CHECK (amount >= 0),
    orig_customer_key bigint NOT NULL REFERENCES core.dim_customer (customer_key),
    dest_customer_key bigint REFERENCES core.dim_customer (customer_key),
    dest_merchant_key bigint, -- FK added when dim_merchant exists
    orig_balance_before numeric(14, 2),
    orig_balance_after numeric(14, 2),
    dest_balance_before numeric(14, 2),
    dest_balance_after numeric(14, 2),
    is_fraud boolean NOT NULL, -- the LABEL, never a feature
    is_flagged_fraud boolean NOT NULL,
    CHECK (num_nonnulls(dest_customer_key, dest_merchant_key) = 1) -- PostgreSQL function
);

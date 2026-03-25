-- Staging model: cleaned customers from raw schema

with source as (
    select * from raw.customers
),

cleaned as (
    select
        id as customer_id,
        trim(first_name) as first_name,
        trim(last_name) as last_name,
        trim(first_name) || ' ' || trim(last_name) as full_name,
        lower(trim(email)) as email,
        trim(country) as country,
        created_at
    from source
)

select * from cleaned

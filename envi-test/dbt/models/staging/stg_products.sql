-- Staging model: active products with price range classification

with source as (
    select * from raw.products
    where is_active = true
),

classified as (
    select
        id as product_id,
        name as product_name,
        category,
        price::numeric(10, 2) as price,
        stock_quantity,
        case
            when price < 25.00 then 'cheap'
            when price < 200.00 then 'medium'
            else 'premium'
        end as price_range,
        is_active
    from source
)

select * from classified

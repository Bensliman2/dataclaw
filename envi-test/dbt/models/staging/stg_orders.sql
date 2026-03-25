-- Staging model: orders enriched with product name

with orders as (
    select * from raw.orders
),

products as (
    select * from raw.products
),

joined as (
    select
        o.id as order_id,
        o.customer_id,
        o.product_id,
        p.name as product_name,
        p.category as product_category,
        o.quantity,
        o.total_amount::numeric(10, 2) as total_amount,
        o.status,
        o.ordered_at
    from orders o
    left join products p on o.product_id = p.id
)

select * from joined

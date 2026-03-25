-- Mart model: product dimension with sales aggregates

with products as (
    select * from {{ ref('stg_products') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

product_metrics as (
    select
        product_id,
        coalesce(sum(quantity), 0) as total_sold,
        coalesce(sum(total_amount), 0) as total_revenue
    from orders
    group by product_id
),

final as (
    select
        p.product_id,
        p.product_name,
        p.category,
        p.price,
        p.price_range,
        p.stock_quantity,
        coalesce(m.total_sold, 0) as total_sold,
        coalesce(m.total_revenue, 0) as total_revenue
    from products p
    left join product_metrics m on p.product_id = m.product_id
)

select * from final

-- Mart model: fact orders with denormalized dimensions

with orders as (
    select * from {{ ref('stg_orders') }}
),

customers as (
    select * from {{ ref('dim_customers') }}
),

products as (
    select * from {{ ref('dim_products') }}
),

final as (
    select
        o.order_id,
        o.customer_id,
        c.full_name as customer_full_name,
        c.country as customer_country,
        o.product_id,
        o.product_name,
        p.category as product_category,
        p.price_range,
        o.quantity,
        o.total_amount,
        o.status,
        o.ordered_at,
        case
            when o.total_amount > 100 then true
            else false
        end as is_high_value
    from orders o
    left join customers c on o.customer_id = c.customer_id
    left join products p on o.product_id = p.product_id
)

select * from final

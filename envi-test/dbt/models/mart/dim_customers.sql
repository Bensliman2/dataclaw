-- Mart model: customer dimension with order aggregates

with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

customer_metrics as (
    select
        customer_id,
        count(*) as total_orders,
        coalesce(sum(total_amount), 0) as total_spent,
        min(ordered_at) as first_order_date,
        max(ordered_at) as last_order_date
    from orders
    group by customer_id
),

final as (
    select
        c.customer_id,
        c.first_name,
        c.last_name,
        c.full_name,
        c.email,
        c.country,
        c.created_at,
        coalesce(m.total_orders, 0) as total_orders,
        coalesce(m.total_spent, 0) as total_spent,
        m.first_order_date,
        m.last_order_date
    from customers c
    left join customer_metrics m on c.customer_id = m.customer_id
)

select * from final

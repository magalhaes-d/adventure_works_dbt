with
    sales_order_reason as (
        select
            sales_order_fk
            , sales_reason_fk
        from {{ ref('stg_sales_order_header_sales_reason') }}
    )

    , sales_reason as (
        select
            sales_reason_pk
            , reason_name
            , reason_type
        from {{ ref('stg_sales_reason') }}
    )

    , joining as (
        select
            sales_order_reason.sales_order_fk as sales_order_id
            , sales_reason.reason_name
            , sales_reason.reason_type
        from sales_order_reason
        left join sales_reason
            on sales_order_reason.sales_reason_fk = sales_reason.sales_reason_pk
    )

select *
from joining

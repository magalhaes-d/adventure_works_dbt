with
    sales_order as (
        select
            sales_order_sk
            , customer_fk
        from {{ ref('fct_sales_order') }}
    )

    , sales_detail as (
        select
            sales_order_detail_sk
            , sales_order_fk
            , product_fk
        from {{ ref('dim_sales_order_detail') }}
    )

    , sales_reason as (
        select
            sales_reason_sk
            , sales_order_fk
        from {{ ref('dim_sales_reason') }}
    )

    , bdg_order_detail as (
        select
            sales_order.customer_fk
            , sales_order.sales_order_sk as sales_order_fk
            , sales_detail.sales_order_detail_sk as sales_order_detail_fk
            , sales_detail.product_fk
        from sales_order
        full outer join sales_detail
            on sales_order.sales_order_sk = sales_detail.sales_order_fk
    )

    , bdg_order_detail_reason as (
        select
            bdg_order_detail.*
            , sales_reason.sales_reason_sk as sales_reason_fk
        from bdg_order_detail
        full outer join sales_reason
            on bdg_order_detail.sales_order_fk = sales_reason.sales_order_fk

    )

select *
from bdg_order_detail_reason

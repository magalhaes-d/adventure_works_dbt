with
    sales_order as (
        select
            sales_order_sk
            , customer_fk
            , ship_to_address_id
        from {{ ref('fct_sales_order') }}
    )

    , entity_address_tb as (
        select
            entity_address_sk
            , customer_fk
            , business_entity_fk
            , address_fk
        from {{ ref('fct_entity_address') }}
    )

    , sales_detail as (
        select
            sales_order_detail_sk
            , sales_order_fk
            , product_fk
        from {{ ref('fct_sales_order_detail') }}
    )

    , sales_reason as (
        select
            sales_reason_sk
            , sales_order_fk
        from {{ ref('fct_sales_reason') }}
    )

    , order_to_address as (
        select
            sales_order.sales_order_sk as sales_order_fk
            , sales_order.customer_fk
            , sales_order.ship_to_address_id as ship_address_fk
            , entity_address_tb.address_fk
        from sales_order
        full outer join entity_address_tb
            on sales_order.customer_fk = entity_address_tb.customer_fk
    )

    , order_to_product as (
        select
            order_to_address.sales_order_fk
            , order_to_address.customer_fk
            , order_to_address.ship_address_fk
            , order_to_address.address_fk
            , sales_detail.sales_order_detail_sk as sales_order_detail_fk
            , sales_detail.product_fk
        from order_to_address
        full outer join sales_detail
            on order_to_address.sales_order_fk = sales_detail.sales_order_fk
    )

    , order_to_reason as (
        select
            order_to_product.sales_order_fk
            , order_to_product.customer_fk
            , order_to_product.ship_address_fk
            , order_to_product.address_fk
            , order_to_product.sales_order_detail_fk
            , order_to_product.product_fk
            , sales_reason.sales_reason_sk as sales_reason_fk
        from order_to_product
        full outer join sales_reason
            on order_to_product.sales_order_fk = sales_reason.sales_order_fk
        where order_to_product.sales_order_fk is not null
    )

select *
from order_to_reason

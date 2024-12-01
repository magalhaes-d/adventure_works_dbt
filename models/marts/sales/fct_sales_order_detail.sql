with
    sales_order_detail_tb as (
        select
            sales_order_detail_pk
            , sales_order_fk
            , product_fk
            , carrier_tracking_number
            , order_quantity
            , unit_price
            , unit_price_discount
            , discount_type
            , discount_description
        from {{ ref('int_sales_order_detail') }}
    )

    , product_tb as (
        select
            product_sk
            , product_id
        from {{ ref('dim_product') }}
    )

    , sales_order_tb as (
        select
            sales_order_sk
            , sales_order_id
        from {{ ref('fct_sales_order') }}
    )

    , fact as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'sales_order_tb.sales_order_sk'
                    , 'product_tb.product_sk'
                    , 'sales_order_detail_tb.sales_order_fk'
                    , 'sales_order_detail_tb.order_quantity'
                    , 'sales_order_detail_tb.unit_price'
                ])
            }} as sales_order_detail_sk
            , sales_order_tb.sales_order_sk as sales_order_fk
            , product_tb.product_sk as product_fk
            , sales_order_detail_tb.sales_order_fk as sales_order_id
            , sales_order_detail_tb.carrier_tracking_number
            , sales_order_detail_tb.order_quantity
            , sales_order_detail_tb.unit_price
            , sales_order_detail_tb.unit_price_discount
            , sales_order_detail_tb.discount_type
            , sales_order_detail_tb.discount_description
        from sales_order_detail_tb
        left join product_tb
            on sales_order_detail_tb.product_fk = product_tb.product_id
        left join sales_order_tb
            on sales_order_detail_tb.sales_order_fk = sales_order_tb.sales_order_id
    )

select *
from fact

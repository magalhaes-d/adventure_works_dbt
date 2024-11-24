with
    sales_order_detail_tb as (
        select *
        from {{ ref('int_sales_order_detail') }}
    )

    , product_tb as (
        select
            product_sk
            , product_id
        from {{ ref('dim_product') }}
    )

    , fact as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'sales_order_detail_tb.sales_order_fk'
                    , 'product_tb.product_sk'
                    , 'sales_order_detail_tb.order_quantity'
                    , 'sales_order_detail_tb.unit_price'
                ])
            }} as sales_order_detail_sk
            , sales_order_detail_tb.sales_order_fk as sales_order_id
            , product_tb.product_sk as product_fk
            , sales_order_detail_tb.carrier_tracking_number
            , sales_order_detail_tb.order_quantity
            , sales_order_detail_tb.unit_price
            , sales_order_detail_tb.unit_price_discount
            , sales_order_detail_tb.discount_type
            , sales_order_detail_tb.discount_description
        from sales_order_detail_tb
        left join product_tb
            on sales_order_detail_tb.product_fk = product_tb.product_id
    )

select *
from fact

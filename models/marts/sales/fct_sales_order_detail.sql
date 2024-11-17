with
    fact as (
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

select *
from fact

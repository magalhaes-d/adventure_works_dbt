with
    sales_order_detail as (
        select
            sales_order_detail_pk
            , sales_order_fk
            , product_fk
            , special_offer_fk
            , carrier_tracking_number
            , order_quantity
            , unit_price
            , unit_price_discount
        from {{ ref('stg_sales_order_detail') }}
    )

    , special_offer as (
        select
            special_offer_pk
            , offer_description as discount_description
            , offer_type as discount_type
        from {{ ref('stg_special_offer') }}
    )

    , joining as (
        select
            sales_order_detail.sales_order_detail_pk
            , sales_order_detail.sales_order_fk
            , sales_order_detail.product_fk
            , sales_order_detail.carrier_tracking_number
            , sales_order_detail.order_quantity
            , sales_order_detail.unit_price
            , sales_order_detail.unit_price_discount
            , case
                when sales_order_detail.special_offer_fk != 1 and sales_order_detail.unit_price_discount = 0
                then 'No discount'
                else special_offer.discount_type
            end as discount_type
            , case
                when sales_order_detail.special_offer_fk != 1 and sales_order_detail.unit_price_discount = 0
                then 'No discount'
                else special_offer.discount_description
            end as discount_description
        from sales_order_detail
        left join special_offer
            on sales_order_detail.special_offer_fk = special_offer.special_offer_pk
    )

select *
from joining

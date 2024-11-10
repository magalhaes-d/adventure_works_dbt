with
    stg_tb as (
        select
            salesorderdetailid as sales_order_detail_pk
            , salesorderid as sales_order_fk
            , productid as product_fk
            , specialofferid as special_offer_fk
            , carriertrackingnumber as carrier_tracking_number
            , orderqty as order_quantity
            , unitprice as unit_price
            , unitpricediscount as unit_price_discount
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'salesorderdetail') }}
    )

select *
from stg_tb

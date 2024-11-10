with
    stg_tb as (
        select
            specialofferid as special_offer_pk
            , description as offer_description
            , discountpct as discount_pct
            , type as offer_type
            , category as offer_category
            , startdate as start_date
            , enddate as end_date
            , minqty as min_qty
            , maxqty as max_qty
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'specialoffer') }}
    )

select *
from stg_tb

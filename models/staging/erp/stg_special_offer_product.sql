with
    stg_tb as (
        select
            specialofferid as special_offer_fk
            , productid as product_fk
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'specialofferproduct') }}
    )

select *
from stg_tb

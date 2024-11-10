with
    stg_tb as (
        select
            salesorderid as sales_order_fk
            , salesreasonid as sales_reason_fk
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'salesorderheadersalesreason') }}
    )

select *
from stg_tb

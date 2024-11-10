with
    stg_tb as (
        select
            salesreasonid as sales_reason_pk
            , name as reason_name
            , reasontype as reason_type
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'salesreason') }}
    )

select *
from stg_tb

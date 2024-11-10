with
    stg_tb as (
        select
            creditcardid as credit_card_pk
            , cardtype as card_type
            , cardnumber as card_number
            , expmonth as exp_month
            , expyear as exp_year
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'creditcard') }}
    )

select *
from stg_tb

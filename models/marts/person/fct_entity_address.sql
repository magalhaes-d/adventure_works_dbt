with
    business_entity_address_tb as (
        select
            business_entity_fk
            , address_fk
        from {{ ref('stg_business_entity_address') }}
    )

    , address_tb as (
        select
            address_sk
            , address_id
        from {{ ref('dim_address') }}
    )

    , customer_tb as (
        select
            customer_sk
            , business_entity_fk
        from {{ ref('dim_customer') }}
    )

    , joining as (
        select
            customer_tb.customer_sk as customer_fk
            , business_entity_address_tb.business_entity_fk
            , address_tb.address_sk as address_fk
            , business_entity_address_tb.address_fk as address_id
        from business_entity_address_tb
        left join address_tb
            on business_entity_address_tb.address_fk = address_tb.address_id
        left join customer_tb
            on business_entity_address_tb.business_entity_fk = customer_tb.business_entity_fk

    )

    , fact as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'customer_fk'
                    , 'business_entity_fk'
                    , 'address_fk'
                    , 'address_id'
                ])
            }} as entity_address_sk
            , customer_fk
            , business_entity_fk
            , address_fk
            , address_id
        from joining
    )

select *
from fact

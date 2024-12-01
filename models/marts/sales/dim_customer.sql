with
    customer_tb as (
        select
            customer_pk
            , business_entity_fk
            , territory_fk
            , customer_name
            , customer_type
        from {{ ref('int_customer') }}
    )

    , dimension as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'customer_pk'
                    , 'business_entity_fk'
                    , 'customer_name'
                ])
            }} as customer_sk
            , customer_pk as customer_id
            , business_entity_fk
            , territory_fk
            , customer_name
            , customer_type
        from customer_tb
    )

select *
from dimension

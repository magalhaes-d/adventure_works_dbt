with
    address_tb as (
        select *
        from {{ ref('int_address') }}
    )

    , customer_tb as (
        select
            customer_sk
            , person_id
        from {{ ref('dim_customer') }}
    )

    , dimension as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'address_tb.address_pk'
                    , 'customer_tb.customer_sk'
                    , 'address_tb.address_line_1'
                ])
            }} as address_sk
            , address_tb.address_pk as address_id
            , customer_tb.customer_sk as customer_fk
            , address_tb.address_type_name
            , address_tb.address_line_1
            , address_tb.address_line_2
            , address_tb.city
            , address_tb.spatial_location
            , address_tb.state_province_code
            , address_tb.state_province_name
            , address_tb.country_region_code
            , address_tb.country_name
        from address_tb
        left join customer_tb
            on address_tb.business_entity_fk = customer_tb.person_id
    )

select *
from dimension

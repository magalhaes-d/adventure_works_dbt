with
    dimension as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'customer_pk'
                    , 'person_fk'
                    , 'first_name'
                    , 'last_name'
                ])
            }} as customer_sk
            , customer_pk as customer_id
            , person_fk as person_id
            , territory_fk as territory_id
            , person_type
            , name_style
            , title
            , first_name
            , middle_name
            , last_name
            , case
                when person_type in ('IN', 'SC')
                then first_name || ' ' || last_name
                else store_name
            end as entity_name
            , suffix
            , email_promotion
            , additional_contact_info
            , demographics
        from {{ ref('int_customer') }}
    )

select *
from dimension

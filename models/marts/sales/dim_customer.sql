with
    dimension as (
        select
            customer_pk
            , person_fk
            , territory_fk
            , person_type
            , name_style
            , title
            , first_name
            , middle_name
            , last_name
            , suffix
            , email_promotion
            , additional_contact_info
            , demographics
            , store_name
        from {{ ref('int_customer') }}
    )

select *
from dimension

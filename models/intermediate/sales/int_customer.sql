with
    customer as (
        select
            customer_pk
            , person_fk
            , store_fk
            , territory_fk
        from {{ ref('stg_customer') }}
    )

    , person as (
        select
            business_entity_pk
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
        from {{ ref('stg_person') }}
    )

    , store as (
        select
            business_entity_fk
            , store_name
        from {{ ref('stg_store') }}
    )

    , joinings as (
        select
            customer.customer_pk
            , customer.person_fk
            , customer.territory_fk
            , person.person_type
            , person.name_style
            , person.title
            , person.first_name
            , person.middle_name
            , person.last_name
            , person.suffix
            , person.email_promotion
            , person.additional_contact_info
            , person.demographics
            , store.store_name
        from customer
        left join person
            on customer.person_fk = person.business_entity_pk
        left join store
            on customer.store_fk = store.business_entity_fk
    )

select *
from joinings

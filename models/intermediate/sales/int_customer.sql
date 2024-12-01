with
    customer as (
        select
            customer_pk
            , person_fk
            , store_fk
            , territory_fk
        from {{ ref('stg_customer') }}
    )

    , store as (
        select
            business_entity_fk
            , store_name
        from {{ ref('stg_store') }}
    )

    , person as (
        select
            business_entity_fk
            , first_name
            , last_name
        from {{ ref('stg_person') }}
    )

    , joinings as (
        select
            customer.customer_pk
            , case
                when store.business_entity_fk is not null
                then store.business_entity_fk
                else customer.person_fk
            end as business_entity_fk
            , customer.territory_fk
            , case
                when store.business_entity_fk is not null
                then store.store_name
                else person.first_name || ' ' || person.last_name
            end as customer_name, case
                when store.business_entity_fk is not null
                then 'Store'
                else 'Person'
            end as customer_type
        from customer
        left join store
            on customer.store_fk = store.business_entity_fk
        left join person
            on customer.person_fk = person.business_entity_fk
    )

select *
from joinings

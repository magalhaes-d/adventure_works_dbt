with
    fact as (
        select
            sales_order_fk
            , reason_name
            , reason_type
        from {{ ref('int_sales_reason') }}
    )

select *
from fact

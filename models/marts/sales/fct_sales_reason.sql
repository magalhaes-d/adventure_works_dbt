with
    sales_reason_tb as (
        select
            sales_order_id
            , reason_name
            , reason_type
        from {{ ref('int_sales_reason') }}
    )

    , sales_order_tb as (
        select
            sales_order_sk
            , sales_order_id
        from {{ ref('fct_sales_order') }}
    )

    , fact as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'sales_order_tb.sales_order_sk'
                    , 'sales_reason_tb.sales_order_id'
                    , 'sales_reason_tb.reason_name'
                    , 'sales_reason_tb.reason_type'
                ])
            }} as sales_reason_sk
            , sales_order_tb.sales_order_sk as sales_order_fk
            , sales_reason_tb.sales_order_id
            , sales_reason_tb.reason_name
            , sales_reason_tb.reason_type
        from sales_reason_tb
        left join sales_order_tb
            on sales_reason_tb.sales_order_id = sales_order_tb.sales_order_id
    )

select *
from fact

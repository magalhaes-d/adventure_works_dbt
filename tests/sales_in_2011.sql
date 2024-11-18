with
    fct_sales as (
        select *
        from {{ ref('fct_sales_order') }}
    )

    , dim_sales as (
        select *
        from {{ ref('fct_sales_order_detail') }}
    )

    , joining as (
        select
            dim_sales.order_quantity
            , dim_sales.unit_price
        from fct_sales
        left join dim_sales
            on fct_sales.sales_order_pk = dim_sales.sales_order_fk
        where fct_sales.order_date between '2011-01-01' and '2011-12-31'
    )

    , metric as (
        select
            sum(order_quantity * unit_price) as total
        from joining
    )

select *
from metric
where total not between 12646112.15 and 12646112.17

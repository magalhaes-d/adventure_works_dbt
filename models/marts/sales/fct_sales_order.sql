with
    fact as (
        select
            sales_order_pk
            , customer_fk
            , salesperson_fk
            , territory_fk
            , bill_to_address_fk
            , ship_to_address_fk
            , ship_method_fk
            , currency_rate_fk
            , revision_number
            , order_date
            , due_date
            , ship_date
            , order_status
            , online_order_flag
            , purchase_order_number
            , account_number
            , credit_card_approval_code
            , subtotal
            , tax_amount
            , freight
            , total_due
            , comment
            , card_type
        from {{ ref('int_sales_order_header') }}
    )

select *
from fact

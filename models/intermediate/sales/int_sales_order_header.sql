with
    sales_order_header as (
        select
            sales_order_pk
            , customer_fk
            , salesperson_fk
            , territory_fk
            , bill_to_address_fk
            , ship_to_address_fk
            , ship_method_fk
            , credit_card_fk
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
        from {{ ref('stg_sales_order_header') }}
    )

    , order_detail as (
        select
            sales_order_fk
            , sum(round(order_quantity * unit_price, 2)) as gross_total
        from {{ ref('stg_sales_order_detail') }}
        group by
            sales_order_fk
    )

    , credit_card as (
        select
            credit_card_pk
            , card_type
        from {{ ref('stg_credit_card') }}
    )

    , joining as (
        select
            sales_order_header.sales_order_pk
            , sales_order_header.customer_fk
            , sales_order_header.salesperson_fk
            , sales_order_header.territory_fk
            , sales_order_header.bill_to_address_fk
            , sales_order_header.ship_to_address_fk
            , sales_order_header.ship_method_fk
            , sales_order_header.currency_rate_fk
            , sales_order_header.revision_number
            , sales_order_header.order_date
            , sales_order_header.due_date
            , sales_order_header.ship_date
            , sales_order_header.order_status
            , sales_order_header.online_order_flag
            , sales_order_header.purchase_order_number
            , sales_order_header.account_number
            , sales_order_header.credit_card_approval_code
            , order_detail.gross_total
            , sales_order_header.subtotal
            , sales_order_header.tax_amount
            , sales_order_header.freight
            , sales_order_header.total_due
            , sales_order_header.comment
            , credit_card.card_type
        from sales_order_header
        left join order_detail
            on sales_order_header.sales_order_pk = order_detail.sales_order_fk
        left join credit_card
            on sales_order_header.credit_card_fk = credit_card.credit_card_pk
    )

select *
from joining

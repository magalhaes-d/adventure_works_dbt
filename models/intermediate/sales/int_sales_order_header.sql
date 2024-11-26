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

    , credit_card as (
        select
            credit_card_pk
            , card_type
        from {{ ref('stg_credit_card') }}
    )

    , sales_detail as (
        select
            sales_order_detail_pk
            , sales_order_fk
            , order_quantity
            , unit_price
            , unit_price_discount
            , round(order_quantity * unit_price, 2) as gross_total
            , (round(order_quantity * unit_price, 2)) * (1 - unit_price_discount) as net_total
        from {{ ref('stg_sales_order_detail') }}
    )

    , subtotal_sales_detail as (
        select
            sales_order_fk
            , sum(gross_total) as gross_total
            , sum(net_total) as net_total
        from sales_detail
        group by sales_order_fk
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
            , sales_order_header.subtotal as subtotal_from_fct
            , subtotal_sales_detail.gross_total as subtotal_from_dim
            , subtotal_sales_detail.net_total as discounted_subtotal_from_dim
            , sales_order_header.tax_amount
            , sales_order_header.freight
            , sales_order_header.total_due
            , sales_order_header.comment
            , credit_card.card_type
        from sales_order_header
        left join credit_card
            on sales_order_header.credit_card_fk = credit_card.credit_card_pk
        left join subtotal_sales_detail
            on sales_order_header.sales_order_pk = subtotal_sales_detail.sales_order_fk
    )

select *
from joining

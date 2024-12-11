with
    sales_order_header_tb as (
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
            , gross_total
            , subtotal
            , tax_amount
            , freight
            , total_due
            , comment
            , card_type
        from {{ ref('int_sales_order_header') }}
    )

    , customer_tb as (
        select
            customer_sk
            , customer_id
        from {{ ref('dim_customer') }}
    )

    , fact as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'sales_order_header_tb.sales_order_pk'
                    , 'customer_tb.customer_sk'
                    , 'sales_order_header_tb.ship_to_address_fk'
                    , 'sales_order_header_tb.order_date'
                    , 'sales_order_header_tb.subtotal'
                ])
            }} as sales_order_sk
            , sales_order_header_tb.sales_order_pk as sales_order_id
            , customer_tb.customer_sk as customer_fk
            , sales_order_header_tb.salesperson_fk as salesperson_id
            , sales_order_header_tb.territory_fk as territory_id
            , sales_order_header_tb.bill_to_address_fk as bill_to_address_id
            , sales_order_header_tb.ship_to_address_fk as ship_to_address_id
            , sales_order_header_tb.ship_method_fk as ship_method_id
            , sales_order_header_tb.currency_rate_fk as currency_rate_id
            , sales_order_header_tb.revision_number
            , sales_order_header_tb.order_date
            , sales_order_header_tb.due_date
            , sales_order_header_tb.ship_date
            , sales_order_header_tb.order_status
            , sales_order_header_tb.online_order_flag
            , sales_order_header_tb.purchase_order_number
            , sales_order_header_tb.account_number
            , sales_order_header_tb.credit_card_approval_code
            , sales_order_header_tb.gross_total
            , sales_order_header_tb.subtotal
            , sales_order_header_tb.tax_amount
            , sales_order_header_tb.freight
            , sales_order_header_tb.total_due
            , sales_order_header_tb.comment
            , sales_order_header_tb.card_type
            , current_timestamp() as updated_at
        from sales_order_header_tb
        left join customer_tb
            on sales_order_header_tb.customer_fk = customer_tb.customer_id
    )

select *
from fact

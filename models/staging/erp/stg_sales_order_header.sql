with
    stg_tb as (
        select
            salesorderid as sales_order_pk
            , customerid as customer_fk
            , salespersonid as salesperson_fk
            , territoryid as territory_fk
            , billtoaddressid as bill_to_address_fk
            , shiptoaddressid as ship_to_address_fk
            , shipmethodid as ship_method_fk
            , creditcardid as credit_card_fk
            , currencyrateid as currency_rate_fk
            , revisionnumber as revision_number
            , cast(orderdate as date) as order_date
            , cast(duedate as date) as due_date
            , cast(shipdate as date) as ship_date
            , status as order_status
            , onlineorderflag as online_order_flag
            , purchaseordernumber as purchase_order_number
            , accountnumber as account_number
            , creditcardapprovalcode as credit_card_approval_code
            , subtotal as subtotal
            , taxamt as tax_amount
            , freight as freight
            , totaldue as total_due
            , comment as comment
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'salesorderheader') }}
    )

select *
from stg_tb

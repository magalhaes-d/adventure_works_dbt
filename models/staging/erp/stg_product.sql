with
    stg_tb as (
        select
            productid as product_pk
            , sizeunitmeasurecode as size_unit_measure_fk
            , weightunitmeasurecode as weight_unit_measure_fk
            , productsubcategoryid as product_subcategory_fk
            , productmodelid as product_model_fk
            , name as product_name
            , productnumber as product_number
            , makeflag as make_flag
            , finishedgoodsflag as finished_goods_flag
            , color as product_color
            , safetystocklevel as safety_stock_level
            , reorderpoint as reorder_point
            , standardcost as standard_cost
            , listprice as list_price
            , size as product_size
            , weight as product_weight
            , daystomanufacture as days_to_manufacture
            , productline as product_line
            , class as product_class
            , style as product_style
            , sellstartdate as sell_start_date
            , sellenddate as sell_end_date
            , discontinueddate as discontinued_date
            , rowguid as row_guid
            , modifieddate as modified_date
        from {{ source('adventure_works_erp', 'product') }}
    )

select *
from stg_tb

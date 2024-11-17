with
    dimension as (
        select
            product_pk
            , size_unit_measure_fk
            , weight_unit_measure_fk
            , product_subcategory_fk
            , product_model_fk
            , product_name
            , product_number
            , make_flag
            , finished_goods_flag
            , product_color
            , safety_stock_level
            , reorder_point
            , standard_cost
            , list_price
            , product_size
            , product_weight
            , days_to_manufacture
            , product_line
            , product_class
            , product_style
            , sell_start_date
            , sell_end_date
            , discontinued_date
        from {{ ref('stg_product') }}
    )

select *
from dimension

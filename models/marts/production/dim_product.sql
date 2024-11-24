with
    dimension as (
        select
            {{
                dbt_utils.generate_surrogate_key([
                    'product_pk'
                    , 'product_model_fk'
                    , 'product_name'
                ])
            }} as product_sk
            , product_pk as product_id
            , size_unit_measure_fk as size_unit_measure_id
            , weight_unit_measure_fk as weight_unit_measure_id
            , product_subcategory_fk as product_subcategory_id
            , product_model_fk as product_model_id
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

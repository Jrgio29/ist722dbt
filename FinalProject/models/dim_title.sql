with staged as (
    select * from {{ ref('stg_titles') }}
),

final as (
    select
        {{ dbt_utils.generate_surrogate_key(['title_id']) }} as title_sk,
        title_id,
        title_name,
        media_type,
        parental_rating,
        title_release_year,
        title_runtime,
        title_synopsis,
        title_bluray_available,
        title_dvd_available,
        title_instant_available,
        date_modified
    from staged
)

select * from final
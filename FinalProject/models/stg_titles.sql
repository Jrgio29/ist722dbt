with source as (
    select * from raw.fudgeflix_v3.ff_titles
),

renamed as (
    select
        title_id::string as title_id,
        title_name,
        title_type as media_type,
        title_rating as parental_rating,
        title_release_year,
        title_runtime,
        title_synopsis,
        title_bluray_available,
        title_dvd_available,
        title_instant_available,
        to_timestamp_ntz(cast(title_date_modified / 1000000 as bigint)) as date_modified
    from source
)

select * from renamed
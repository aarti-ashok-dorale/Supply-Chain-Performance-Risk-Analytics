use supply_chain;

-- 1. business question: how many total records are available in the supply chain dataset?
select count(*) as total_records
from supply_chain_data;


-- 2. business question: how many unique suppliers are involved in the supply chain?
select count(distinct supplier_id) as total_suppliers
from supply_chain_data;


-- 3. business question: how many unique products are handled in the supply chain?
select count(distinct product_id) as total_products
from supply_chain_data;


-- 4. business question: what is the distribution of supply chain risk classes?
select
    risk_class,
    count(*) as total_records
from supply_chain_data
group by risk_class
order by total_records desc;


-- 5. business question: which suppliers have the highest average delay probability?
select
    supplier_id,
    round(avg(delay_probability), 2) as avg_delay
from supply_chain_data
group by supplier_id
order by avg_delay desc;


-- 6. business question: who are the top 10 riskiest suppliers?
select
    supplier_id,
    round(avg(delay_probability), 2) as avg_delay
from supply_chain_data
group by supplier_id
order by avg_delay desc
limit 10;


-- 7. business question: which supplier countries have the highest delay probability?
select
    supplier_country,
    round(avg(delay_probability), 2) as avg_delay
from supply_chain_data
group by supplier_country
order by avg_delay desc;


-- 8. business question: which route risk levels are associated with higher delays?
select
    route_risk,
    round(avg(delay_probability), 2) as avg_delay
from supply_chain_data
group by route_risk
order by avg_delay desc;


-- 9. business question: what are the overall inventory level statistics?
select
    round(avg(inventory_level), 2) as avg_inventory,
    min(inventory_level) as min_inventory,
    max(inventory_level) as max_inventory
from supply_chain_data;


-- 10. business question: does equipment availability have an impact on delay probability?
select
    equipment_availability,
    round(avg(delay_probability), 2) as avg_delay
from supply_chain_data
group by equipment_availability
order by avg_delay desc;


-- 11. business question: how are suppliers ranked based on their delay probability?
select
    supplier_id,
    round(avg(delay_probability), 2) as avg_delay,
    dense_rank() over(order by avg(delay_probability) desc) as supplier_rank
from supply_chain_data
group by supplier_id;


-- 12. business question: which suppliers have a high average delay probability?
select
    supplier_id,
    round(avg(delay_probability), 2) as avg_delay
from supply_chain_data
group by supplier_id
having avg(delay_probability) > 0.5
order by avg_delay desc;


-- 13. business question: how can suppliers be classified into low, medium, and high risk?
select
    supplier_id,
    round(avg(delay_probability), 2) as avg_delay,
    case
        when avg(delay_probability) > 0.7 then 'high'
        when avg(delay_probability) > 0.4 then 'medium'
        else 'low'
    end as risk
from supply_chain_data
group by supplier_id;


-- 14. business question: how many records have both high delay and high disruption risk?
select
    count(*) as high_risk_records
from supply_chain_data
where delay_probability > 0.5
and disruption_likelihood > 0.5;


-- 15. business question: which products have the highest average delay probability?
SELECT 
    product_id, ROUND(AVG(delay_probability), 2) AS avg_delay
FROM
    supply_chain_data
GROUP BY product_id
ORDER BY avg_delay DESC
LIMIT 10;  
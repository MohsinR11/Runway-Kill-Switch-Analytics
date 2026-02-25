-- ======================================================================
-- RUNWAY KILL-SWITCH ANALYTICS - SQL ANALYSIS QUERIES
-- ======================================================================

-- ======================================================================
-- QUERY 1: CURRENT COMPANY HEALTH (EXECUTIVE SUMMARY)
-- ======================================================================

SELECT 
    month,
    cash_balance,
    runway_months,
    total_burn,
    total_revenue,
    net_burn,
    ROUND((total_revenue / NULLIF(total_burn, 0) * 100), 2) as burn_coverage_percent
FROM company_monthly_financials
ORDER BY month DESC
LIMIT 1;

-- ======================================================================
-- QUERY 2: RUNWAY TREND (LAST 6 MONTHS)
-- ======================================================================

SELECT 
    month,
    cash_balance,
    runway_months,
    net_burn,
    LAG(runway_months) OVER (ORDER BY month) as prev_month_runway,
    runway_months - LAG(runway_months) OVER (ORDER BY month) as runway_change_months
FROM company_monthly_financials
ORDER BY month DESC
LIMIT 6;

-- ======================================================================
-- QUERY 3: INITIATIVE PERFORMANCE SCORECARD
-- ======================================================================

WITH latest_metrics AS (
    SELECT 
        initiative_id,
        initiative_name,
        monthly_burn,
        monthly_revenue,
        monthly_burn - monthly_revenue as net_burn,
        CASE 
            WHEN monthly_burn > 0 THEN 
                ROUND(((monthly_revenue - monthly_burn) / monthly_burn * 100), 2)
            ELSE 0 
        END as roi_percent,
        CASE 
            WHEN monthly_revenue > monthly_burn THEN 0
            WHEN monthly_revenue > 0 THEN 
                ROUND(monthly_burn / (monthly_revenue - monthly_burn), 1)
            ELSE 999
        END as months_to_breakeven
    FROM initiative_monthly_metrics
    WHERE month = (SELECT MAX(month) FROM initiative_monthly_metrics)
)
SELECT 
    lm.*,
    i.success_probability,
    i.team_size,
    CASE 
        WHEN lm.roi_percent < -50 THEN '🔴 KILL'
        WHEN lm.roi_percent < -20 THEN '🟡 PAUSE'
        WHEN lm.roi_percent < 10 THEN '🟢 CONTINUE'
        WHEN lm.roi_percent < 40 THEN '🟢 CONTINUE'
        ELSE '🚀 SCALE'
    END as recommendation
FROM latest_metrics lm
JOIN initiatives i ON lm.initiative_id = i.initiative_id
ORDER BY lm.roi_percent ASC;

-- ======================================================================
-- QUERY 4: BURN WATERFALL (WHERE IS MONEY GOING?)
-- ======================================================================

SELECT 
    initiative_name,
    ROUND(SUM(monthly_burn), 0) as total_burn,
    ROUND(SUM(monthly_revenue), 0) as total_revenue,
    ROUND(SUM(monthly_burn - monthly_revenue), 0) as net_burn,
    ROUND(SUM(monthly_burn) / (
        SELECT SUM(total_burn) 
        FROM company_monthly_financials
    ) * 100, 1) as percent_of_total_burn
FROM initiative_monthly_metrics
WHERE month >= (SELECT MAX(month) FROM initiative_monthly_metrics) - INTERVAL '90 days'
GROUP BY initiative_name
ORDER BY total_burn DESC;

-- ======================================================================
-- QUERY 5: RUNWAY IMPACT ANALYSIS (WHAT IF WE KILL EACH INITIATIVE?)
-- ======================================================================

WITH current_state AS (
    SELECT 
        cash_balance,
        net_burn,
        runway_months
    FROM company_monthly_financials
    ORDER BY month DESC
    LIMIT 1
),
initiative_impact AS (
    SELECT 
        initiative_id,
        initiative_name,
        monthly_burn,
        monthly_revenue,
        monthly_burn - monthly_revenue as net_contribution
    FROM initiative_monthly_metrics
    WHERE month = (SELECT MAX(month) FROM initiative_monthly_metrics)
)
SELECT 
    ii.initiative_id,
    ii.initiative_name,
    ii.monthly_burn,
    ii.monthly_revenue,
    cs.net_burn as current_net_burn,
    cs.net_burn - ii.net_contribution as new_net_burn_if_killed,
    cs.runway_months as current_runway,
    CASE 
        WHEN (cs.net_burn - ii.net_contribution) > 0 THEN
            ROUND(cs.cash_balance / (cs.net_burn - ii.net_contribution), 1)
        ELSE 999
    END as new_runway_if_killed,
    CASE 
        WHEN (cs.net_burn - ii.net_contribution) > 0 THEN
            ROUND(cs.cash_balance / (cs.net_burn - ii.net_contribution) - cs.runway_months, 1)
        ELSE 999
    END as runway_extension_months
FROM initiative_impact ii
CROSS JOIN current_state cs
ORDER BY runway_extension_months DESC;

-- ======================================================================
-- QUERY 6: MONTHLY BURN TREND BY INITIATIVE
-- ======================================================================

SELECT 
    month,
    initiative_name,
    monthly_burn,
    monthly_revenue,
    monthly_burn - monthly_revenue as net_burn,
    AVG(monthly_burn - monthly_revenue) OVER (
        PARTITION BY initiative_id 
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as three_month_avg_net_burn
FROM initiative_monthly_metrics
WHERE month >= (SELECT MAX(month) FROM initiative_monthly_metrics) - INTERVAL '180 days'
ORDER BY month DESC, net_burn DESC;

-- ======================================================================
-- QUERY 7: KILL-SWITCH DECISION MATRIX
-- ======================================================================

SELECT 
    r.initiative_id,
    r.roi_percent,
    r.runway_impact_if_killed,
    r.recommendation,
    r.confidence_level,
    i.team_size,
    i.success_probability,
    CASE 
        WHEN r.roi_percent < -50 AND r.runway_impact_if_killed > 6 THEN 'URGENT KILL'
        WHEN r.roi_percent < -20 AND r.runway_impact_if_killed > 3 THEN 'STRONG KILL'
        WHEN r.roi_percent < 0 THEN 'CONSIDER KILL'
        WHEN r.roi_percent > 40 THEN 'SCALE IMMEDIATELY'
        WHEN r.roi_percent > 20 THEN 'SCALE GRADUALLY'
        ELSE 'MONITOR'
    END as action_priority
FROM kill_switch_recommendations r
JOIN initiatives i ON r.initiative_id = i.initiative_id
WHERE r.evaluation_date = (SELECT MAX(evaluation_date) FROM kill_switch_recommendations)
ORDER BY r.runway_impact_if_killed DESC;

-- ======================================================================
-- QUERY 8: SCENARIO COMPARISON (ALL OPTIONS)
-- ======================================================================

SELECT 
    scenario_name,
    scenario_type,
    initiative_ids,
    baseline_runway_months,
    projected_runway_months,
    runway_extension_months,
    cash_saved,
    revenue_impact,
    ROUND(cash_saved + revenue_impact, 0) as net_monthly_impact
FROM scenario_analysis
ORDER BY runway_extension_months DESC;

-- ======================================================================
-- QUERY 9: CUMULATIVE CASH BURN BY INITIATIVE
-- ======================================================================

WITH initiative_cumulative AS (
    SELECT 
        initiative_id,
        initiative_name,
        month,
        monthly_burn,
        monthly_revenue,
        SUM(monthly_burn - monthly_revenue) OVER (
            PARTITION BY initiative_id 
            ORDER BY month
        ) as cumulative_net_burn
    FROM initiative_monthly_metrics
)
SELECT 
    initiative_id,
    initiative_name,
    MAX(cumulative_net_burn) as total_cumulative_burn,
    COUNT(*) as months_active,
    ROUND(MAX(cumulative_net_burn) / COUNT(*), 0) as avg_monthly_net_burn
FROM initiative_cumulative
GROUP BY initiative_id, initiative_name
ORDER BY total_cumulative_burn DESC;

-- ======================================================================
-- QUERY 10: PROFITABILITY FORECAST (CURRENT TRAJECTORY)
-- ======================================================================

WITH recent_trends AS (
    SELECT 
        AVG(total_revenue) as avg_revenue,
        AVG(total_burn) as avg_burn,
        STDDEV(total_revenue) as revenue_volatility,
        STDDEV(total_burn) as burn_volatility
    FROM company_monthly_financials
    WHERE month >= (SELECT MAX(month) FROM company_monthly_financials) - INTERVAL '90 days'
)
SELECT 
    avg_revenue,
    avg_burn,
    avg_burn - avg_revenue as avg_net_burn,
    revenue_volatility,
    burn_volatility,
    CASE 
        WHEN avg_revenue > avg_burn THEN 'Already Profitable'
        WHEN avg_revenue / NULLIF(avg_burn, 0) > 0.8 THEN 'Near Profitability (80%+ coverage)'
        WHEN avg_revenue / NULLIF(avg_burn, 0) > 0.5 THEN 'Moderate Progress (50-80% coverage)'
        ELSE 'Far from Profitability (<50% coverage)'
    END as profitability_status
FROM recent_trends;

-- ======================================================================
-- QUERY 11: TEAM EFFICIENCY ANALYSIS
-- ======================================================================

WITH latest_data AS (
    SELECT 
        imm.initiative_id,
        imm.initiative_name,
        imm.monthly_revenue,
        i.team_size
    FROM initiative_monthly_metrics imm
    JOIN initiatives i ON imm.initiative_id = i.initiative_id
    WHERE imm.month = (SELECT MAX(month) FROM initiative_monthly_metrics)
    AND i.team_size > 0
)
SELECT 
    initiative_id,
    initiative_name,
    team_size,
    monthly_revenue,
    ROUND(monthly_revenue / team_size, 0) as revenue_per_employee,
    CASE 
        WHEN monthly_revenue / team_size > 15000 THEN 'High Efficiency'
        WHEN monthly_revenue / team_size > 8000 THEN 'Moderate Efficiency'
        ELSE 'Low Efficiency'
    END as efficiency_rating
FROM latest_data
ORDER BY revenue_per_employee DESC;

-- ======================================================================
-- QUERY 12: KILL SIMULATION - COMBINED IMPACT
-- ======================================================================

WITH kill_candidates AS (
    SELECT initiative_id
    FROM kill_switch_recommendations
    WHERE recommendation = 'KILL'
    AND evaluation_date = (SELECT MAX(evaluation_date) FROM kill_switch_recommendations)
),
current_state AS (
    SELECT cash_balance, net_burn, runway_months
    FROM company_monthly_financials
    ORDER BY month DESC
    LIMIT 1
),
kill_impact AS (
    SELECT 
        SUM(monthly_burn) as total_burn_eliminated,
        SUM(monthly_revenue) as total_revenue_lost
    FROM initiative_monthly_metrics
    WHERE initiative_id IN (SELECT initiative_id FROM kill_candidates)
    AND month = (SELECT MAX(month) FROM initiative_monthly_metrics)
)
SELECT 
    (SELECT COUNT(*) FROM kill_candidates) as initiatives_to_kill,
    cs.cash_balance,
    cs.net_burn as current_net_burn,
    cs.runway_months as current_runway,
    ki.total_burn_eliminated,
    ki.total_revenue_lost,
    cs.net_burn - ki.total_burn_eliminated + ki.total_revenue_lost as new_net_burn,
    CASE 
        WHEN (cs.net_burn - ki.total_burn_eliminated + ki.total_revenue_lost) > 0 THEN
            ROUND(cs.cash_balance / (cs.net_burn - ki.total_burn_eliminated + ki.total_revenue_lost), 1)
        ELSE 999
    END as new_runway,
    CASE 
        WHEN (cs.net_burn - ki.total_burn_eliminated + ki.total_revenue_lost) > 0 THEN
            ROUND(cs.cash_balance / (cs.net_burn - ki.total_burn_eliminated + ki.total_revenue_lost) - cs.runway_months, 1)
        ELSE 999
    END as runway_extension
FROM current_state cs
CROSS JOIN kill_impact ki;

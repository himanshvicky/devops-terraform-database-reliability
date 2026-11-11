
INSERT INTO hotel_bookings (
    id, org_id, hotel_id, city,
    checkin_date, checkout_date,
    amount, status, created_at
)
SELECT
    md5('booking-' || g)::uuid,
    md5('org-' || ((g % 4) + 1))::uuid,
    'HOTEL-' || LPAD(((g % 25) + 1)::text, 3, '0'),
    (ARRAY['delhi', 'mumbai', 'bengaluru',
           'hyderabad', 'pune'])[((g - 1) % 5) + 1],
    CURRENT_DATE + (g % 30),
    CURRENT_DATE + (g % 30) + 3,
    2500 + (g * 125),
    (ARRAY['confirmed', 'cancelled',
           'pending', 'completed'])[((g - 1) % 4) + 1],
    NOW() - ((g % 56) || ' days')::interval
FROM generate_series(1, 120) AS g;

INSERT INTO booking_events (
    booking_id, event_type, payload, created_at
)
SELECT
    id,
    'booking_' || status,
    jsonb_build_object(
        'source', 'seed',
        'hotel_id', hotel_id,
        'status', status
    ),
    created_at + INTERVAL '5 minutes'
FROM hotel_bookings
WHERE RIGHT(hotel_id, 3)::integer % 3 = 0;

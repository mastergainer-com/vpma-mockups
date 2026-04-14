-- VP MA Mockup Voting Schema
-- Supabase Projekt: mctbuvwcupeovtdqeoru

-- Tabelle für Abstimmungen
CREATE TABLE IF NOT EXISTS mockup_votes (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    voter_name TEXT NOT NULL,
    mockup_1_rating INTEGER,
    mockup_2_rating INTEGER,
    mockup_3_rating INTEGER,
    mockup_4_rating INTEGER,
    mockup_5_rating INTEGER,
    mockup_6_rating INTEGER,
    comments TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Index für schnellere Abfragen
CREATE INDEX IF NOT EXISTS idx_mockup_votes_created_at ON mockup_votes(created_at DESC);

-- Row Level Security (RLS) Policies
ALTER TABLE mockup_votes ENABLE ROW LEVEL SECURITY;

-- Jeder darf lesen (für Top 3 Anzeige)
CREATE POLICY "Allow public read" ON mockup_votes
    FOR SELECT USING (true);

-- Jeder darf einfügen (für Abstimmungen)
CREATE POLICY "Allow public insert" ON mockup_votes
    FOR INSERT WITH CHECK (true);

-- Kommentar: Updates/Deletes nur für authentifizierte User (Admin)
-- Falls Admin-Funktionen benötigt werden, zusätzliche Policies erstellen

-- View für Top 3 (optional, kann auch in Application Code berechnet werden)
CREATE OR REPLACE VIEW mockup_stats AS
SELECT 
    'Mockup 1' as name,
    AVG(mockup_1_rating) as avg_rating,
    COUNT(mockup_1_rating) as vote_count
FROM mockup_votes
UNION ALL
SELECT 
    'Mockup 2',
    AVG(mockup_2_rating),
    COUNT(mockup_2_rating)
FROM mockup_votes
UNION ALL
SELECT 
    'Mockup 3',
    AVG(mockup_3_rating),
    COUNT(mockup_3_rating)
FROM mockup_votes
UNION ALL
SELECT 
    'Mockup 4',
    AVG(mockup_4_rating),
    COUNT(mockup_4_rating)
FROM mockup_votes
UNION ALL
SELECT 
    'Mockup 5',
    AVG(mockup_5_rating),
    COUNT(mockup_5_rating)
FROM mockup_votes
UNION ALL
SELECT 
    'Mockup 6',
    AVG(mockup_6_rating),
    COUNT(mockup_6_rating)
FROM mockup_votes
ORDER BY avg_rating DESC;

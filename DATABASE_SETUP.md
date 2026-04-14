# VP MA Mockup - Datenbank Setup

## Supabase Konfiguration

### 1. Tabelle erstellen (SQL Editor)

Gehe zu: https://supabase.com/dashboard/project/mctbuvwcupeovtdqeoru/sql/new

Führe folgendes SQL aus:

```sql
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
```

### 2. RLS aktivieren

Im Supabase Dashboard:
1. Gehe zu "Database" → "Tables"
2. Wähle "mockup_votes"
3. Klicke auf "Enable RLS"

### 3. Test-Abstimmung

Nach dem Setup kannst du eine Test-Abstimmung durchführen:
1. Öffne `index.html` im Browser
2. Gib einen Namen ein
3. Bewerte mindestens ein Mockup
4. Klicke "Abstimmung absenden"

### 4. Admin-Bereich

Alle Abstimmungen siehst du unter:
- `admin.html` - Übersicht mit Top 3 und Tabelle
- CSV Export verfügbar

## Dateien

- `index.html` - Hauptseite mit Abstimmung
- `admin.html` - Admin-Bereich mit Statistiken
- `supabase-schema.sql` - SQL-Schema

## Resend Email API

- API Key: `re_j9G4zb3j_7gdY9FEchoYHGsMi8Ex1NHwB`
- Absender: `noreply@zeitsparen.at`
- Empfänger: `jochen@jasch.cc`

**Wichtig:** Domain `zeitsparen.at` muss in Resend verifiziert sein!

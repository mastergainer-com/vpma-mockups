# VP Maria Anzbach - Mockup Abstimmung

Interaktive Abstimmung für 6 Website-Designs mit automatischer Speicherung in Supabase.

## 🚀 Features

- ⭐ Sterne-Bewertung für 6 Mockups
- 💾 Automatische Speicherung in Supabase
- 📧 Email-Benachrichtigung via Resend API
- 🏆 Live Top 3 Anzeige
- 📊 Admin-Bereich mit Statistiken
- 📥 CSV Export

## 📁 Dateien

| Datei | Beschreibung |
|-------|--------------|
| `index.html` | Hauptseite mit Abstimmung |
| `admin.html` | Admin-Bereich mit Statistiken |
| `supabase-schema.sql` | SQL-Schema für die Datenbank |
| `DATABASE_SETUP.md` | Detaillierte Setup-Anleitung |

## 🗄️ Datenbank-Setup

### 1. Supabase Tabelle erstellen

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

## 📧 Email-Konfiguration

- **API:** Resend
- **API Key:** `re_j9G4zb3j_7gdY9FEchoYHGsMi8Ex1NHwB`
- **Absender:** `noreply@zeitsparen.at`
- **Empfänger:** `jochen@jasch.cc`

⚠️ **Wichtig:** Domain `zeitsparen.at` muss in Resend verifiziert sein!

## 🧪 Testen

1. Öffne `index.html` im Browser
2. Gib einen Namen ein
3. Bewerte mindestens ein Mockup (1-5 Sterne)
4. Optional: Kommentare hinzufügen
5. Klicke "🗳️ Abstimmung absenden"
6. Nach erfolgreicher Speicherung: Top 3 wird angezeigt

## 📊 Admin-Bereich

Zugriff über: `admin.html`

- Gesamtstatistiken
- Live Top 3
- Tabelle aller Abstimmungen
- CSV Export

## 💾 Lokale Backup-Datei

CSV-Export wird gespeichert in:
```
/Users/gibor/Library/Mobile Documents/com~apple~CloudDocs/Gibor/Mark/vpma-abstimmungen.csv
```

## 🔧 Technische Details

- **Supabase Projekt:** `mctbuvwcupeovtdqeoru`
- **Frontend:** Vanilla HTML/CSS/JS
- **Database:** PostgreSQL (Supabase)
- **Email:** Resend API
- **Auth:** Keine (öffentliche Lesen/Schreiben via RLS)

## 📝 Mockup-Namen

1. **Klassisch NÖ** - Traditionelles Design
2. **Modern Lokal** - Zeitgemäß mit lokalem Bezug
3. **Premium Gemeinde** - Hochwertiges Erscheinungsbild
4. **Magazin-Style** - Editorial/News-Layout
5. **Split-Screen** - Geteilte Ansicht
6. **Kachel-Grid** - Kachel-basiertes Layout

---

Erstellt: 2026-04-14

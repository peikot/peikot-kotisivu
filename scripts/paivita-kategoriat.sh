#!/bin/bash
# Hakee ilmoittautumiskategoriat Apps Script API:sta ja päivittää config.json
# Käyttö: ./scripts/paivita-kategoriat.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG="$SCRIPT_DIR/../config.json"
API_URL="https://script.google.com/macros/s/AKfycbyFtReOP5raDe9vXMRy0sQnbXiGIrlGiRlxDY0Kt_yVgHNRTplqWqo2gYWaGQ9fXRUXiw/exec?action=kategoriat"

echo "Haetaan kategoriat API:sta..."
RESPONSE=$(curl -sL "$API_URL")

if ! echo "$RESPONSE" | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
  echo "Virhe: API palautti virheellistä dataa"
  exit 1
fi

# Päivitä config.json pythonilla
python3 -c "
import json, sys

with open('$CONFIG', 'r') as f:
    config = json.load(f)

response = json.loads('''$RESPONSE''')
config['ilmoittautumisKategoriat'] = response.get('kategoriat', [])

with open('$CONFIG', 'w') as f:
    json.dump(config, f, indent=2, ensure_ascii=False)
    f.write('\n')

n = len(config['ilmoittautumisKategoriat'])
print(f'Päivitetty {n} kategoriaa config.json:iin')
"

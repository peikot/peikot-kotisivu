# Vuoreksen Peikot ry – kotisivu

Staattinen sivusto osoitteessa [vuoreksenpeikot.fi](https://vuoreksenpeikot.fi).

## Hosting ja deployment

- **Hosting:** GitHub Pages (`peikot/peikot-kotisivu`)
- **Custom domain:** `vuoreksenpeikot.fi` (asetettu `CNAME`-tiedostossa)
- **Deployment:** automaattinen — jokainen push `main`-branchiin julkaistaan välittömästi

## Rakenne

```
.
├── index.html, liity.html, ota-yhteytta.html, yhteistyo.html, tietosuoja.html, 404.html
├── partials/        # nav.html ja footer.html, ladataan client-side fetchillä (js/main.js)
├── css/style.css    # kaikki tyylit
├── js/main.js       # partials-lataus, lomakkeet, kalenteri, modaalit
├── js/count.js      # GoatCounter analytics
├── img/             # kuvat (logot, banneri, aktiviteettikuvat)
├── fonts/           # Bebas Neue
├── config.json      # jäsenmäärä, Apps Script -URL:t, ilmoittautumiskategoriat
└── site.webmanifest, robots.txt, sitemap.xml
```

## Dynaaminen data

Jäsenmäärä, kalenteri, höntsymittari ja ilmoittautumiskategoriat haetaan selaimessa runtime-tilassa Google Apps Script -endpointeista (URL:t `config.json`:ssa). Endpointit ovat webappeja, jotka lukevat dataa Peikkojen Google Sheetsistä.

`config.json`:n arvot toimivat fallbackina, jos Apps Script ei vastaa. Jos fallback-arvot vanhentuvat liikaa, päivitä ne käsin.

## Paikallinen kehitys

```sh
python3 -m http.server 8000
```

Avaa `http://localhost:8000`. Partials-fetch vaatii HTTP-serverin (ei toimi `file://`-protokollalla).

## Skriptit

`scripts/paivita-kategoriat.sh` — hakee ilmoittautumiskategoriat Apps Scriptista ja päivittää `config.json`:n manuaalisesti. Sama tehdään automaattisesti GitHub Actionsissa.

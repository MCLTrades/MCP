#!/usr/bin/env bash
#
# Lädt die Bongard-Maschinenfotos herunter und legt sie unter den Dateinamen ab,
# die die Website (bongard/index.html) erwartet.
#
# HINWEIS: Funktioniert nur, wenn die Netzwerkrichtlinie der Session den Host
# www.bongard.de erlaubt. In einer Session mit Allowlist-Policy schlägt der
# Proxy mit HTTP 403 (CONNECT tunnel failed) fehl -> dann Policy freigeben und
# eine neue Session starten.
#
# Aufruf:  bash bongard/images/fetch-images.sh
#
set -uo pipefail
cd "$(dirname "$0")"

UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36"
mkdir -p src

# Format: "zieldatei|url"
# Primärbilder (werden direkt von der Website verwendet):
PRIMARY=(
  "hero-line.jpg|https://www.bongard.de/media/d6c5184c-6ae4-4877-b0a2-91245f355630/SUtcYA/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Stahldrahtziehanlage/Stahldrahtziehanlage%201.JPEG?mw=1200&action=crop&dpi=72"
  "drahtziehmaschine.jpg|https://www.bongard.de/media/b3e703a4-24e6-4b83-aca0-feda6c240002/habV-A/Galerie/Retrofit/Cu-Grobdrahtziehanlage/01-Bongard-rod-breakdown-MM85-Cu-second-hand-retrofit.jpg?mw=1200&action=crop&dpi=72"
  "verseilmaschine.jpg|https://www.bongard.de/media/92658891-38f6-41f5-8a95-249faa02a4a5/Ps0Gcw/import/14221-01.JPG?mw=1200"
  "haspler.jpg|https://www.bongard.de/media/be4a52ce-746c-42d0-a064-e76587c4d0de/6JMYAA/import/14226-01.JPG?mw=1200"
  "gluehanlage.jpg|https://www.bongard.de/media/c159e51f-548c-44ca-9102-b0bfa2081983/YAAM8g/import/14246-01.JPG?mw=1200"
  "walzanlage.jpg|https://www.bongard.de/media/622cff75-68de-44ed-b27a-06a76832b982/f5gmqg/Galerie/Retrofit/Walzanlage/Bongard-rolling-mill-second-hand-retrofit-3.jpg?mw=1200&action=crop&dpi=72"
  "isolierlinie.jpg|https://www.bongard.de/media/6763ed25-344b-4cec-9aa6-8b039ef04b46/Wb9oYA/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Bandschleifanlage/Bandschleifanlage%20(1).JPEG?mw=1200&action=crop&dpi=72"
)

# Weitere Fotos (Archiv in src/, für zusätzliche Galerien / alternative Motive):
EXTRA=(
  "src/14226-02.jpg|https://www.bongard.de/media/cf04770f-8d8e-4716-83fb-7f5142a94462/OOMKAA/import/14226-02.JPG?mw=1200"
  "src/14226-03.jpg|https://www.bongard.de/media/f36045cb-069f-4c69-9f2c-dc57aa69d2af/WJo7AA/import/14226-03.JPG?mw=1200"
  "src/14226-04.jpg|https://www.bongard.de/media/913566d0-1424-4871-a215-bc31403a4a94/eFErAA/import/14226-04.JPG?mw=1200"
  "src/14226-05.jpg|https://www.bongard.de/media/cf9f2d68-b45a-4514-8019-8f3bd25c0f3a/mPnaAQ/import/14226-05.JPG?mw=1200"
  "src/14226-06.jpg|https://www.bongard.de/media/1a1da3c4-de2d-4be2-b1c5-21b5f5ea3232/iK_EAQ/import/14226-06.JPG?mw=1200"
  "src/14246-03.jpg|https://www.bongard.de/media/b38bd429-db15-4a75-9213-c9feec983aea/IATS8w/import/14246-03.JPG?mw=1200"
  "src/14246-04.jpg|https://www.bongard.de/media/8ef902e8-0cc5-4bf5-97e9-d38b5513e290/wD3D8w/import/14246-04.JPG?mw=1200"
  "src/14246-05.jpg|https://www.bongard.de/media/6a7d7f88-c070-4a84-9b03-466e2e2289f8/8A718w/import/14246-05.JPG?mw=1200"
  "src/14246-06.jpg|https://www.bongard.de/media/c5017bbb-73a2-4d88-89c8-946757c3d79d/gPSV8w/import/14246-06.JPG?mw=1200"
  "src/14246-08.jpg|https://www.bongard.de/media/31442a16-116c-4e97-b9a3-c98c448660f3/QP9b8w/import/14246-08.JPG?mw=1200"
  "src/14246-09.jpg|https://www.bongard.de/media/16ea5b7f-3ae4-4db1-8280-f9b7857d4b9e/IIhB8w/import/14246-09.JPG?mw=1200"
  "src/14221-02.jpg|https://www.bongard.de/media/aa4db041-502a-4351-9f9c-a83e1bec9059/HoQ3cw/import/14221-02.JPG?mw=1200"
  "src/14221-03.jpg|https://www.bongard.de/media/1a81dc5f-c0f9-443a-bc3b-8b60249cc101/bkQqcw/import/14221-03.JPG?mw=1200"
  "src/14221-04.jpg|https://www.bongard.de/media/7e3c09bb-8b74-4cc3-a017-ef4bead039ed/fnfddA/import/14221-04.JPG?mw=1200"
  "src/14221-05.jpg|https://www.bongard.de/media/586e18f5-30b3-4560-a558-74c96ddc9b04/ngbDdA/import/14221-05.JPG?mw=1200"
  "src/14221-06.jpg|https://www.bongard.de/media/e88e4b78-a362-4e7d-9c37-206e7891f0e9/nkn3dA/import/14221-06.JPG?mw=1200"
  "src/14221-07.jpg|https://www.bongard.de/media/b18f49ed-9f66-489e-9f5c-15320b31fbed/7pjmdA/import/14221-07.JPG?mw=1200"
  "src/14221-08.jpg|https://www.bongard.de/media/6139a479-1963-4530-a8db-6052f87b156e/7jaOdA/import/14221-08.JPG?mw=1200"
  "src/stahldraht-2.jpg|https://www.bongard.de/media/cfe6c593-ca2a-4b37-9978-610e49d1a77b/6Xkkbw/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Stahldrahtziehanlage/Stahldrahtziehanlage%202.JPEG?mw=1200&action=crop&dpi=72"
  "src/stahldraht-3.jpg|https://www.bongard.de/media/9b3124b9-1454-4141-a562-3a0ca7d33779/qesHbw/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Stahldrahtziehanlage/Stahldrahtziehanlage%203.JPEG?mw=1200&action=crop&dpi=72"
  "src/stahldraht-5.jpg|https://www.bongard.de/media/5df7cc88-b14a-4a6a-b292-d2650ed4258b/eQvAYA/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Stahldrahtziehanlage/Stahldrahtziehanlage%205.JPEG?mw=1200&action=crop&dpi=72"
  "src/cu-grobdraht-02.jpg|https://www.bongard.de/media/75b8aa82-ebcf-46dc-acce-e1265dc38ed1/lSaG_g/Galerie/Retrofit/Cu-Grobdrahtziehanlage/02-Bongard-rod-breakdown-MM85-Cu-second-hand-retrofit.jpg?mw=1200&action=crop&dpi=72"
  "src/cu-grobdraht-03.jpg|https://www.bongard.de/media/bcbb9d83-aa74-4d1c-b6b9-40bdc7eeb40e/pW0n9A/Galerie/Retrofit/Cu-Grobdrahtziehanlage/03-Bongard-rod-breakdown-MM85-Cu-second-hand-retrofit.jpg?mw=1200&action=crop&dpi=72"
  "src/cu-grobdraht-04.jpg|https://www.bongard.de/media/334ad484-2b41-4be9-80b4-e14b4b0fe414/hpPIDA/Galerie/Retrofit/Cu-Grobdrahtziehanlage/04-Bongard-rod-breakdown-MM85-Cu-second-hand-retrofit.jpg?mw=1200&action=crop&dpi=72"
  "src/cu-grobdraht-05.jpg|https://www.bongard.de/media/e058e498-3167-49e2-8764-610a500e63e3/NulkAw/Galerie/Retrofit/Cu-Grobdrahtziehanlage/05-Bongard-rod-breakdown-MM85-Cu-second-hand-retrofit.jpg?mw=1200&action=crop&dpi=72"
  "src/bandschleif-2.jpg|https://www.bongard.de/media/af2df9dd-9b10-4e80-8694-cccc57d1dd3b/uYv2YQ/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Bandschleifanlage/Bandschleifanlage%20(2).JPEG?mw=1200&action=crop&dpi=72"
  "src/bandschleif-3.jpg|https://www.bongard.de/media/ccb42f9d-b858-4fbe-8f81-8d60eb09a8a2/mRMsYA/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Bandschleifanlage/Bandschleifanlage%20(3).JPEG?mw=1200&action=crop&dpi=72"
  "src/schaltschrank-1.jpg|https://www.bongard.de/media/479ec71f-2686-48f5-a802-b72926cd1609/6TzmYg/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Schaltschrank/Schaltschrank%20(1).JPEG?mw=1200&action=crop&dpi=72"
  "src/schaltschrank-2.jpg|https://www.bongard.de/media/64d8abd9-b24b-4b28-82e3-d7b07446c818/6bE9YQ/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Schaltschrank/Schaltschrank%20(2).JPEG?mw=1200&action=crop&dpi=72"
  "src/schaltschrank-3.jpg|https://www.bongard.de/media/d6a30e99-f123-430a-bccf-de45035d0803/yTOGYg/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Schaltschrank/Schaltschrank%20(3).JPEG?mw=1200&action=crop&dpi=72"
  "src/schaltschrank-4.jpg|https://www.bongard.de/media/4b658a2a-e6c5-4cdb-962c-57d1bcfc29ee/eYzNYg/Galerie/Retrofit/Retrofit%20Fotos%20Homepage/Schaltschrank/Schaltschrank%20(4).JPEG?mw=1200&action=crop&dpi=72"
  "src/walzanlage-6.jpg|https://www.bongard.de/media/b9283eef-6273-4ddc-877b-cc0f780b4be4/n0Npqg/Galerie/Retrofit/Walzanlage/Bongard-rolling-mill-second-hand-retrofit-6.jpg?mw=1200&action=crop&dpi=72"
  "src/walzanlage-8.jpg|https://www.bongard.de/media/a3cee47e-f7a8-461f-aad5-2e009199a4a8/jyVScw/Galerie/Retrofit/Walzanlage/Bongard-rolling-mill-second-hand-retrofit-8.jpg?mw=1200&action=crop&dpi=72"
)

ok=0; fail=0
download() {
  local target="${1%%|*}" url="${1#*|}"
  local code
  code=$(curl -sSL -A "$UA" --max-time 60 -o "$target" -w "%{http_code}" "$url" 2>/dev/null)
  if [[ "$code" == "200" ]] && head -c2 "$target" 2>/dev/null | grep -q $'\xff\xd8'; then
    printf '  ok   %-26s %s\n' "$target" "($(du -h "$target" | cut -f1))"; ok=$((ok+1))
  else
    printf '  FAIL %-26s HTTP %s\n' "$target" "$code"; rm -f "$target"; fail=$((fail+1))
  fi
}

echo "== Primärbilder =="
for e in "${PRIMARY[@]}"; do download "$e"; done
echo "== Weitere Fotos =="
for e in "${EXTRA[@]}"; do download "$e"; done
echo "-----------------------------------------"
echo "Fertig: $ok geladen, $fail fehlgeschlagen."
[[ $fail -eq 0 ]]

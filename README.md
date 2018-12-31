# SmartDashboard

## Compte dev Twitter

1. Créer son compte dev Twitter

2. Trouver ses token consumer et secret consumer

3. Concatener API_KEY:API_SECRET_KEY (faire attention a bien séparer par `:` )

4. Faire un base64 du résultat

5. Faire un POST sur l’url: `https://api.twitter.com/oauth2/token`

Avec comme header:`Authorization: Basic _ETAPE_4`

Avec comme body:`grant_type: client_credentials`

6. Stocker l’access token bearer dans le ficher `Constants.swift`

7. Faire un GET sur `https://api.twitter.com/1.1/trends/place.json?id=23424819`

Avec comme header:  `Bearer : _ACCESS_TOKEN_`

## Compte API news

1. Créer son compte dev API news sur [https://newsapi.org/](https://newsapi.org/)

2. Stocker le token dans `Constants.swift`

## Partie HomeKit

Pour que la partie HomeKit fonctionne sur AppleTV il vous faut connecter votre compte iCloud sur votre AppleTV. Les simulateurs ne fonctionnent pas.
Une fois le compte iCloud lié sur l'AppleTV vous devriez voir vos ampoules et vos prises connectées.

### Si pas d'ampoules et/ou prises

Télécharger les Additional Tools for Xcode 10.1 sur [le Site Apple Developpeur](https://download.developer.apple.com/Developer_Tools/Additional_Tools_for_Xcode_10.1/Additional_Tools_for_Xcode_10.1.dmg) (compte Apple Developpeur requis)

1. Lancer le simulateur HomeKit Accessory Simulator.app

2. Créer une fake ampoule en ajoutant un device:

⋅⋅⋅1. Appuyer sur `+` en bas à gauche

⋅⋅⋅2. Ajouter un service LightBulb à votre device

⋅⋅⋅3. Bien sélectionner la Catégory LightBulb

⋅⋅⋅4. Scanner le code HomeKit depuis votre iPhone et ajoutez la dans votre maison principale

⋅⋅⋅5. Poursuivez l'installation en acceptant la configuration sur votre iPhone

⋅⋅⋅6. Vous devriez voir l'ampoule sur le SmartDashboard

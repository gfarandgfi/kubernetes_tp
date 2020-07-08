# Travaux pratiques pour formation kubernetes

## TP-04

### Mon site a du succès, je veux plusieurs pods

Actuellement, nous avons donc un pod (plutôt robuste) qui offre un serveur web au travers d'un Service de type LoadBalancer.

Puisque tout fonctionne bien, il gagne en notoriété et il a du mal seul à gérer la charge.

Nous souhaitons augmenter le nombre de container de façon simple (eviter de lancer manuellement x pod via kubectl).

Pour cela, il existe une resource prévue pour gérer autant de réplique de notre pod : le replicaset

Le TP contient un fichier web-replicaset.yaml qui décrit un replicaset
* apiVersion est positionné à apps/v1
* metadata est propre à cette ressource de type ReplicaSet
* spec contient :
  * replica qui permet de fixer le nombre de pod souhaité
  * selector qui permet de choisir les pods considérés
  * template qui précise le modèle pour les pods à créer (reprend exactement les metadata et spec d'une resource de type Pod)

```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: 
  labels:
    truc: un_truc
    label: rouge
spec:
  replicas: 3
  selector:
    matchLabels:
      app: 
  template:
    metadata:
      labels:
        app: 
    spec:
      containers:
      - name: 
        image: nginx:1.18
```

Créez cette ressource :
```
kubectl apply -f web-replicaset.yaml
```

Observez les pods créés :
```
kubectl get all
```
Avec la commande 'get all', vous voyez le replicaset ainsi que le service.

Concernant les pods, si vous avez suivi le TP, vous pouvez vérifier qu'il y en a bien 3.
Cependant, il y a votre ancien pod webserver et deux nouveaux nommés à partir du nom du replicaset web-rs-xxxxx

Effectivement, puisque votre pod webserver était présent précédemment et qu'il vérifie la condition de label, il est pris en compte.
Le replicaset n'a créé que 2 pod à partir du template.
Gardez ce phénomène à l'esprit. En effet, il se trouve que notre pod webserver est identique en tout point, mais ça aurait pu être un pod tout autre, venant parasiter notre service.

Détruisons ce pod (et éventuellement un ou plusieurs autres) :
```
kubectl delete pod <pod>
```

Observez qu'il y a bien toujours 3 pods (des **nouveaux** venant remplacer ceux qui viennent à disparaître) :
```
kubectl get pods
```

Maintenant observez à nouveau le service, et en particulier la liste des Endpoints:
```
kubectl describe service webserver-service
```

Les 3 pods font bien partie du service.

Mon site connait une période creuse d'un point de vue du traffic  
Je decide donc de modifier la capacité du replicaset

Je peux le faire en ligne de commande:
```
kubectl scale --replicas=1 replicaset <replicaset>
```
Mais nous avons vu les inconvenients de cette approche.  
Pas des moindres: mon code ne représentera plus la réalité de mon cluster

Respectons donc les bonnes pratiques et modifions le bon paramètre dans notre code puis :
```
kubectl apply -f web-replicaset.yaml
```

Encore un TP de terminé !  :star:


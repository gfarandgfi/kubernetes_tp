# Travaux pratiques pour formation kubernetes

## TP-01

Premier contact avec kubernetes, faire sa place

### Découvrir les namespaces

Dans le TP précédents, nous n'avions décourvert qu'une unique resource : le service kubernetes (celui qui représente l'API server)

Voyons désormais l'envers du décor : il existe des resources cachées...

```bash
kubectl get all --all-namespaces
```

Vous découvrez qu'il existe en effet d'autres resources que nous préciserons plus tard (pods, services, daemonsets, deployements, replicasets)

Note : l'option -A est la version courte de --all-namespaces

Observons la première colonne NAMESPACE.
Il s'agit comme son nom l'indique d'un espace de nommage, pour regrouper les resources.
Le service kubernetes est placé dans un namespace default
Les autres ressources (interne à kubernetes) sont placées dans un namespace kube-system.

Mais combien y en a-t-il au final ?

```bash
kubectl get namespaces
```

Nous en découvrons 4 :
* default => le namespace par défaut. Il porte bien son nom, si on ne précise pas le namespace (sur un get, sur un create,...), c'est lui qui sera choisi
* kube-node-lease => namespace récent (passé stable en version 1.17) sert pour gérer des node status. Peu utilisé, on est actuellement autorisé à l'effacer
* kube-public => namespace dédié aux ressources "publiques". Vous pouvez l'investir. Peu utilisé.
* kube-system => namespace réservé pour l'usage interne de kubernetes.

Afin d'éviter d'éviter d'avoir un tas de ressources mélangées sous peine de ne plus vous y retrouver, la bonne pratique consiste à créer des namespaces dédiés.
(Par application, par business unit, pour la supervision, ...)

### Créons notre propre namespace

Voici donc le moment de créer notre première ressource !

J'ai besoin d'un espace dans mon cluster pour y déployer mes pods. Je dois donc créer un namespace qui porte mon nom (ou en réalité celui que vous voulez)

#### En ligne de commande

Rien de plus simple !!

```bash
kubectl create namespace <mon_nom>
```

Vérifions la bonne création par 2 commandes :

```bash
kubectl describe namespace <mon_nom>
kubectl get namespaces
```

Note : le résultat de la commande describe nous montre qu'il est possible d'ajouter des labels et des annotations à un namespace (ici, il n'y en a pas).
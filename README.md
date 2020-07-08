# Travaux pratiques pour formation kubernetes

## TP-02

### Les formats de sortie

On m'informe que ce que je déploie dans mon cluster doit être documenté dans un git. Je dois donc posséder un copie du code.
Malheureusement, j'ai créé mon namespace avec la cli. Vais-je devoir coder du départ ce que j'ai déja fait ?


Pas du tout !
```
kubectl get namespace <mon_nom> -o yaml
```
La sortie de cette commande est la représentation de mon namespace en format YAML. 
J'aurais pu avoir une sortie dans d'autres formats. 

```
kubectl get namespace <mon_nom> -o json
```
```
kubectl get namespace <mon_nom> -o wide
```
Le format json est aussi disponible, ainsi que le format wide qui se veut exhaustif, 'name' qui se veut minimal, et un format custom permettant de choisir les colonnes à afficher.

Je dispose maintenant d'une pratique pour voir les manifestes et ensuite les éditer.


### Lancement rapide d'un serveur web

J'ai besoin dans ce namespace d'un ~~container~~ pod avec un serveur web
```
# Ne lancez pas cette commande
kubectl run nginx --image=nginx:latest --namespace=<mon_nom>
```
Avec cette commande j'aurai rapidement un serveur web qui tourne dans mon cluster. Il sera dans le bon namespace. 
Tout ira bien, sauf... qu'il ne sera pas configuré. 

Si je commence par écrire du code, je pourrai ensuite le modifier pour le configurer. Mais par où commencer ?  
Pas de panique !
```
kubectl run nginx --image=nginx:latest --dry-run=client -o yaml
```
J'ai maintenant un squelette de code, et je peux respecter les bonnes pratiques.
Comparons ce résultat à la version minimale fournie dans ce TP. Que remarque-t-on ?


### Création et lancement d'un premier pod

Maintenant que j'ai le code pour mon serveur web, je suis prêt à le construire et le lancer.
```
kubectl apply -f monfichier.yml
```

Je peux vérifier que mon pod se lance et tourne correctement. Est-il dans le bon namespace ?
```
kubectl get pods -a
```

Je dois toujours créer ce serveur web dans ce namespace. N'y a-t-il pas une solution plus pratique ?


### Et si j'ai un problème ? Le debug.

Notre pod tourne correctement dans kubernetes. C'est déjà un bel objectif atteint.
Si ca vient à ne plus être le cas, kubernetes met à disposition certains outils pour en diagnostiquer la cause.

Analyser les évenements du cluster:
```
kubectl get events -n <namespace>
```

Obtenir les logs du container:
```
kubectl logs <pod> -n <namespace>
```

Si cela ne suffit pas, on executer une commande maintenant familière pour entrer dans le container et appliquer des méthodes de diagnostic classiques:
```
kubectl exec -it <pod> -n <namespace> -- bash
```
Pour quitter le container, utilisez 'exit' ou 'Ctrl-D'


### J'en ai marre de préciser le namespace à chaque commande !

Afin de pouvoir travailler chacun dans son propre espace, je vous ai imposé l'utilisation d'un namespace.
Dans chacun des YAML à venir, vous pourrez (devrez) ajouter la ligne "namespace: <namespace>" dans la partie metadata.
De même, sur toutes les lignes de commandes kubectl, vous devrez préciser "--namespace=<namespace>" ou "-n <namespace>"

C'est impératif et c'est à conserver en mémoire en permanence, sous peine de ne pas voir les bons objets ou de créer les objets au mauvais endroit.

Cependant, vous simplifier la vie et que vous puissiez vous focaliser sur le cours, nous allons ajouter un paramétrage de kubectl.
Ceci nous permet de découvrir une nouvelle fonctionnalité : la configuration de la CLI.

Je vous ai déjà présenté le fichier de configuration de kubectl : ~/.kube/config

C'est un fichier au format yaml :

```yaml
apiVersion: v1
kind: Config
preferences: {}
clusters: {}
users: {}
contexts: {}
```

Il possède donc un type de ressource (kind) du nom de Config et une version d'API à v1.
Comme on peut le voir, il contient :
* les informations de un ou plusieurs clusters (chez nous 1)
* les informations sur un ou plusieurs utilisateurs (chez nous 1)
* les informations sur un ou plusieurs contexts

C'est la notion de context qui nous intéresse.
Elle permet de regrouper sous un seul nom :
* le cluster sur lequel on travaille
* avec quelle identité on travaille
* dans quel namespace on travaille par défaut

C'est cette dernière notion qui nous intéresse  :wink:

Observons tout d'abord combien de contextes existent sur notre environnement.
Pour cela utilisons la commande 'config' de kubectl.
La particularité de cette commande est qu'elle ne travaille qu'en local, sur le fichier de config, et il n'y a aucun lien avec un quelconque cluster kubernetes.

```bash
kubectl config get-contexts
```

Parmi la liste des contexts existants, une astérisque nous indique le context courant.
Cette commande nous donne toutes les informations : cluster, user, namespace.
On constate que le namespace est vide.

Note : pour connaître le context courant (sans toutes les infos), il y a la commande suivante :

```bash
kubectl config current-context
```

Nous pouvons forcer notre namespace personnel via la commande suivante :

```bash
kubectl config set-context aks-00 --namespace=<namespace>
```

A partir de maintenant, le namespace par défaut sera le votre.
Mais souvenez-vous que certaines ressources sont globales et non liées à un namespace !

Il existe aussi des outils tiers pour faciliter la navigation entre les contextes
kubectx pour naviguer entre les clusters (https://github.com/ahmetb/kubectx)
kubens [https://github.com/ahmetb/kubectx/blob/master/kubens] pour naviguer entre les namespaces 

C'est tout pour ce TP. Félicitations !  :ok_hand:


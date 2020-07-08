# Travaux pratiques pour formation docker

## TP-03

Assurer le service !

### Nous voulons rendre notre serveur web accessible

Pour l'instant, mon pod existe dans l'orchestrateur. Il fonctionne, mais n'est pas accessible.  
Il dispose d'une adresse IP privée affectée de façon aléatoire et est démarré sur un noeud quelconque.

Pour le rendre accessible à l'éxterieur, je dois donc l'exposer avec un service.  

Comme nous l'avons vu, un service se base sur un selector pour choisir ses pods. Oh wait...


#### Ajout d'un label

On commence à comprendre l'utilité de tout décrire avec du code :wink:

Récuperez le code de votre pod si vous ne l'avez pas conservé, et ajoutez un (ou plusieurs) label(s) de votre choix dans les metadata de votre pod :
```yaml
metadata:
  labels:
    app: web
    label: bleue
```
Et **appliquez** la modification directement sur votre pod:
```bash
kubectl apply -f webserver-pod.yaml
```
 Je modifie un pod dans lequel un container s'éxecute. La commande apply fait que mon pod ne sera pas détruit/recréé si cela est possible (un changement d'image, par exemple, forcerait une déstruction/recréation)

Vous devriez obtenir le message "pod/webserver configured"
Vérifions avec la bonne commande


#### Création du service 

Nous allons gagner du temps, voici le squelette du service que nous allons créer :
* Service de type LoadBalancer (géré par le cloud, ici AWS)
* Selectionne tous les pods ayant le label app: web
* Ecoute sur le port 80, redirige sur le port 80 des containers ciblés (containerPort)

```yaml
apiVersion: v1
kind: Service
metadata:
  name: 
  labels:
    a_label:
    another_label:
spec:
  type: LoadBalancer
  ports:
    - port: 80
      protocol: TCP
      targetPort: 80
  selector:
    app: web
```

Le fichier existe dans le répertoire de ce TP (webserver-service.yaml)
Vous pourriez ajouter "namespace: <namespace>" dans la partie metadata, mais l'apiserver le fera pour vous.
```bash
kubectl apply -f webserver-service.yaml
```

Le service est créé. Observons ses propriétés :
```bash
kubectl describe service webserver-service
```

* On note que le Namespace est bien renseigné.
* On note que le Selector correspond à notre demande.
* On vérifie via Endpoints qu'il a bien ciblé un seul pod
  * Ce qui permet de préciser qu'il se restreint au namespace dans sa recherche, sinon il aurait trouvé les pods des collègues (sic!)
  * On pourrait (devrait) vérifier que l'adresse IP est bien celle de notre pod. N'hésitez pas à le faire.
* On trouve une adresse IP privée de service, qui ne nous intéresse pas, mais attibuée sur le service_cidr
* On trouve de façon plus intéressante l'adresse publique du loadbalancer avec **LoadBalancer Ingress**

Tentez d'accéder à votre service (le provisionnement de l'ELB peut prendre un peu de temps)

C'est tout pour ce TP !  :clap:


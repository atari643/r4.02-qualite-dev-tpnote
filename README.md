# Template CI

Epreuve R4.02 sur machine en temps limité et en binôme. **Merci de lire très attentivement l'intégralité du sujet avant de commencer et de respecter l'ensemble des consignes.**

> **Note**
> Si votre classe est composée d'un nombre impair d'étudiants lors de cette épreuve, l'une des équipes pourra être un groupe de trois étudiants.

L'objectif de cette épreuve est de montrer votre capacité à maîtriser le 'workflow' **GitLab** avec des *Merge-Requests* (*MR*) et des *Issues*, ainsi que la mise en place d'une *Intégration Continue* (*CI*) dans **GitLab**.

## Barème indicatif

- [+2pt] pour le *fork* du dépôt initial et respect des consignes associées.
- [+5pt] pour mise en place d'une *Issue* et de la *MR* associée pour chacune des fonctionnalités.
- [+5pt] le graphe des commits devra refléter un workflow **GitLab** propre.
- [+5pt] pour une séquence de pipelines d'intégration continue qui montre que vous avez bien respecté les étapes avec la fusion des *MR*.
- [+5pt] pour l'état d'avancement du projet.
- [-2pt] par commit direct dans la branche `main` ou par *pipeline* effacé manuellement, ou en cas de non-respect des consignes du *fork* !

## Contexte

Maintenant que vous avez découvert les bases de l'intégration continue dans **GitLab**, vous avez pour objectif de construire un dépôt "générique" pour vos projets futurs. Vous avez déjà une idée de la structure de votre *CI* et des *jobs* que vous allez mettre en place (`build`, `test`, ...). Ces étapes sont clairement dépendantes du langage de programmation que vous allez utiliser, mais un *certain nombre de règles sont communes* à tous les projets. En particulier, **avant même de commencer à écrire du code, vous souhaitez que la CI puisse "stopper" le pipeline si certaines propriétés ne sont pas respectées**. Vous économiserez ainsi du temps de calcul et des ressources pour les *runners* **GitLab** (`S4A_DOCKER`, `S4B_DOCKER`, `S4C_DOCKER`).

Vous allez donc, **à tour de rôle avec votre binôme (ou trinôme)**, préparer une *MR* pour mettre l'une des règles de votre *CI*. Cette *MR* sera associée à une *Issue* que vous aurez créée au préalable dans votre tableau de bord **GitLab**. Une fois la fonctionnalité implémentée, vous ferez relire votre *MR* par votre binôme (ou trinôme) avant de la fusionner dans la branche `main`.

> En particulier, pour chacune des règles, vous devrez vous assurer que la *CI* doit passer (resp. échouer) si la règle est respectée (resp. n'est pas respectée). Deux pipelines devront mettre en évidence le bon fonctionnement de la règle.

Comme ce sujet ne dépend pas d'un langage de programmation spécifique et que les règles de votre *CI* seront réalisées en *shell* (`bash`), on vous demande d'utiliser une image *Docker* minimale : `registry.u-bordeaux.fr/tthor/alpine-git`.

> **Note**
> Si vous deviez utiliser des outils non disponibles dans l'image `alpine-git`, vous êtes autorisé à ajouter l'installation de paquets supplémentaires dans une section `before_script` de votre fichier `.gitlab-ci.yml`. Pour information : `apk add --no-cache <package>`, voir le [Dockerfile](./docker/Dockerfile) ayant servi à construire l'image `alpine-git`.

> **Warning**
> Vous devez impérativement utiliser l'image *Docker* `pregistry.u-bordeaux.fr/vhub/alpine-git` ! De plus, la durée du *pipeline* pour ce projet étant normalement inférieure à **10 secondes**, vous ne devriez donc pas attendre plus d'**1 minute** pour que votre *CI* s'exécute. Ainsi, l'activité des runners est enregistrée, et vous êtes responsable du contrôle des ressources allouées à vos tests d'intégration continue. Vous serez sanctionné dans la notation en cas d'abus !

**Tout au long de cette épreuve, vous n'aurez pas besoin d'échanger entre vous 'oralement'. Vous devez juste choisir qui sera le développeur qui mettra en place la première fonctionnalité** (puis la seconde en cas de trinôme).

Des morceaux de script *shell* (`bash`) seront donnés tout au long du sujet pour vous aider à mettre en place votre *CI*.

## Organisation

- Constituer un groupe de 2 (ou 3) participants.
> **Warning**
> Vous serez disposés dans la salle de contrôle de manière à ne pas pouvoir communiquer oralement !
- Le premier développeur *fork* ce dépôt (en mode `private` !) et donne les droits `maintainer` aux autres membres de l'équipe.
- Le premier développeur invite l'enseignant correcteur de son groupe en tant que `maintainer`.
> **Note**
> Afin de pouvoir créer des *MR* à partir d'*Issues* gérées dans votre tableau de bord **GitLab**, on vous demande de supprimer la relation avec le projet à l'origine du *fork* (voir /settings/general/advanced/ Remove fork relationship).
- Les runners **GitLab** sont configurés pour exécuter les *pipelines* en mode Docker donc vous devez conserver le tag 'docker' dans votre fichier `.gitlab-ci.yml`.
- Un des membres de l'équipe sera en charge de rédiger le fichier `README.md` (qui devra contenir, dès le début, les noms des membres de l'équipe) et le maintenir à jour pour faire état de l'avancement du travail.
- Enfin, tous les membres de l'équipe clonent le dépôt **GitLab**.

## Mise en place des règles

- Les règles suivantes doivent être mises en place dans votre *CI* dans un stage `pre` (avant le lancement des autres *jobs* de la *CI*).
- Chaque règle correspondra à un job spécifique nommé `pre-rule<numero>`.
- Vous devez créer, au préalable, une *Issue* pour chacune des règles qui sera nommée `us-rule<numero>` [`us` pour 'User Story' en méthodologie agile].
- Vous devez mettre en place une *MR* pour chacune des *Issues*.
- Vous pouvez traiter l'implémentation des règles suivantes dans le *désordre*.

### `rule1` : *présence du fichier `.gitignore`*

Afin de garantir, **dès le début du projet**, que les fichiers inutiles ne soient pas ajoutés dans le dépôt, on vous demande de mettre en place une règle qui vérifie qu'un fichier `.gitignore` est bien présent à la racine du dépôt.

- Le premier développeur crée une *Issue* nommée `us-rule1` et une *MR* associée pour la première règle à mettre en place, et implémente la fonctionnalité dans la branche correspondante en ajoutant les instructions nécessaires dans le fichier `.gitlab-ci.yml` à la racine du projet. La *CI* devrait être en échec car le fichier `.gitignore` n'est pas présent actuellement.
- Le ou les autres membres de l'équipe relisent la *MR* et, une fois les discussions résolues, ajoutent un fichier `.gitignore` dans une branche temporaire et fusionnent ensuite cette branche dans la branche `main`.
- Le développeur en charge de la *MR* rebase sa branche sur la branche `main` et s'assure que la *CI* passe maintenant. Il peut alors fusionner la *MR* dans la branche `main`.

> **Note technique**
>
> Pour vérifier la présence du fichier `.gitignore`, vous pouvez utiliser la syntaxe suivante dans un script *shell* (`bash`) :
> ```bash
> if [ -f /path/to/file ]; then
>     echo 'File exists.'
>     exit 0
> else
>     echo 'File does not exist.'
>     exit 1
> fi
> ```

### `rule2` : *la branche doit être rebasée*

Par défaut dans **Gitlab**, si une branche n'est pas rebasée, la *MR* associée ne pourra pas être fusionnée dans l'interface web. On vous demande de mettre en place une règle qui vérifie que la branche est bien rebasée sur la branche `main` avant de lancer les *jobs* de la *CI*, ce qui permettra d'économiser des ressources.

- Le second développeur crée une *Issue* nommée `us-rule2` et une *MR* associée pour la seconde règle à mettre en place, et implémente la fonctionnalité dans la branche correspondante. La *CI* devrait passer car la branche est bien rebasée sur la branche `main`.
- Le ou les autres membres de l'équipe relisent la *MR* et, une fois les discussions résolues, ajoutent un commit quelconque dans une branche temporaire et fusionnent ensuite cette branche dans la branche `main`.
- Le développeur en charge de la *MR* relance le pipeline associé pour faire échouer la *CI* car la branche n'est plus rebasée sur la branche `main`.
- Le développeur en charge de la *MR* rebase sa branche sur la branche `main` et s'assure que la *CI* passe maintenant. Il peut alors fusionner la *MR* dans la branche `main`.

> **Note technique**
>
> Pour vérifier que la branche est bien rebasée sur la branche `main`, vous pouvez utiliser la commande `check_rebase()` dans le script *shell* `.gitlab/check_ci.sh` :
> ```bash
> .gitlab/check_ci.sh rebase
> ```
> Lors de l'exécution de la *CI*, la variable d'environnement `CI_COMMIT_SHA` sera définie automatiquement par **GitLab** et correspondra au *hash* du dernier commit de la branche. Si vous souhaitez tester votre script en local, vous pouvez définir cette variable manuellement :
> ```bash
> export CI_COMMIT_SHA=`git show-ref -s HEAD`
> echo $CI_COMMIT_SHA
> .gitlab/check_ci.sh rebase
> ```

### `rule3` : *chaque fichier doit commencer par un `header` mentionnant un copyright*

Chacun des fichiers source du dépôt devrait commencer par un `header` qui mentionne le nom des auteurs, la date de création du fichier, un copyright... On vous demande de mettre en place une règle qui vérifie que chaque fichier commence bien par ce `header`.

- Le troisième développeur (ou le premier développeur du binôme) crée une *Issue* et une *MR* associée nommée `mr-rule3` pour la troisième règle à mettre en place, et implémente la fonctionnalité dans la branche correspondante. La *CI* devrait passer car tous les fichiers actuellement présents devraient déjà disposer d'un `header` valide.
- Le ou les autres membres de l'équipe relisent la *MR* et, une fois les discussions résolues, modifient (pour faire échouer la règle) le `header` du fichier `.gitlab/check_ci.sh` dans une branche temporaire et fusionnent ensuite cette branche dans la branche `main`.
- Le développeur en charge de la *MR* rebase sa branche sur la branche `main` et s'assure que la *CI* échoue car la règle n'est plus respectée.
- Le développeur en charge de la *MR* corrige le fichier `.gitlab/check_ci.sh` pour que la *CI* passe. Il peut alors fusionner la *MR* dans la branche `main`.

> **Note technique**
>
> Pour vérifier que chaque fichier commence bien par un `header`, vous pouvez utiliser la commande `check_header()` dans un script *shell* `.gitlab/check_ci.sh` :
> ```bash
> .gitlab/check_ci.sh header
> ```

## Refactoring

Une fois les règles mises en place, vous allez effectuer un refactoring de votre *CI* pour la rendre plus lisible et plus facile à maintenir. Vous allez également mettre en place des *jobs* pour les stages `build` et `test` qui seront déclenchés après le stage `pre`.
> Les 2 fonctionnalités suivantes peuvent être traitées de manière indépendante.

### `refactor1` : *déplacement des jobs dans des fichiers séparés*

En utilisant l'instruction `include:` dans `.gitlab-ci.yml`, déplacez le code correspondant aux jobs du stage `pre` dans un fichier rangé dans `.gitlab/preliminary.yml`. Ajouter les 2 stages `build`et `test` et les jobs associés dans `.gitlab/build.yml` et `.gitlab/test.yml`.

> **Note technique**
>
> Le fichier `build.yml` pourra ressembler à ceci :
> ```yaml
> build:
>   stage: build
>   script:
>     - echo "Building the project..."
> ```
> Le fichier `test.yml` pourra ressembler à ceci :
> ```yaml
> test:
>   stage: test
>   script:
>     - echo "Testing the project..."
> ```

### `refactor2` : *utilisation d'une matrice de jobs*

- En utilisant l'instruction `matrix:` dans `.gitlab-ci.yml`, mettez en place une matrice pour les *jobs* du stage `pre` qui permettra de tester votre projet avec trois options [`ignore`, `rebase`, `header`] pour votre script `.gitlab/check_ci.sh`.

> **Note technique**
>
> La matrice pourra ressembler à ceci :
> ```yaml
>  parallel:
>    matrix:
>      - TEST: [ignore, rebase, header]
> ```
> Vous pouvez consulter la documentation de **GitLab** pour plus d'informations sur les [matrices de jobs](https://docs.gitlab.com/ee/ci/yaml/#parallelmatrix).


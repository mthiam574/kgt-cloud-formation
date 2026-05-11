# AWS — Phase 04 Observabilité

## Services utilisés

| Service            | Rôle                           |
|--------------------|--------------------------------|
| CloudWatch Logs    | Stockage et analyse des logs   |
| CloudWatch Metrics | Métriques des services AWS     |
| CloudWatch Alarms  | Alertes sur seuils             |
| SNS                | Notification par email/SMS     |

## Ce qu on a configuré

### Log Group
- Nom : /ecs/kgt-app
- Rétention : 7 jours
- Coût : gratuit jusqu a 5 Go/mois

### SNS Topic
- Nom : kgt-alerts
- Abonnement : moustaphathiam@hotmail.com
- Coût : gratuit jusqu a 1000 emails/mois

### Alarme CloudWatch
- Nom : kgt-app-cpu-high
- Métrique : CPUUtilization
- Seuil : 80%
- Période : 120s
- Action : SNS kgt-alerts

## Commandes clés

aws logs create-log-group --log-group-name /ecs/kgt-app --region eu-west-3
aws logs put-retention-policy --log-group-name /ecs/kgt-app --retention-in-days 7 --region eu-west-3
aws sns create-topic --name kgt-alerts --region eu-west-3
aws sns subscribe --topic-arn ARN --protocol email --notification-endpoint EMAIL --region eu-west-3
aws cloudwatch put-metric-alarm --alarm-name kgt-app-cpu-high --metric-name CPUUtilization --namespace AWS/ECS --threshold 80 --region eu-west-3
aws cloudwatch describe-alarms --alarm-names kgt-app-cpu-high --region eu-west-3

## Architecture

ECS (conteneur)
   genere -> CloudWatch Metrics
   declenche -> CloudWatch Alarm (CPU > 80%)
   envoie -> SNS Topic (kgt-alerts)
   notifie -> Email moustaphathiam@hotmail.com

## Leçons apprises
- Configurer l observabilité AVANT le déploiement en production
- La rétention des logs évite des coûts inutiles
- SNS peut notifier par email, SMS, Lambda, HTTP
- INSUFFICIENT_DATA = conteneur arrêté, pas assez de données

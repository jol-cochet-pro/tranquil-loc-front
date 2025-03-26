debug:
	flutter run -d web-server --web-port 8080 --dart-define=ENVIRONMENT=DEVELOPMENT

debug-prod:
	flutter run -d web-server --web-port 8080 --dart-define=ENVIRONMENT=PRODUCTION

deploy-dev:
	flutter build web --dart-define=ENVIRONMENT=DEVELOPMENT
	firebase use development
	firebase deploy

deploy:
	flutter build web --dart-define=ENVIRONMENT=PRODUCTION
	firebase use production
	firebase deploy
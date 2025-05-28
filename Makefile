debug:
	flutter run --dart-define=ENVIRONMENT=DEVELOPMENT

debug-prod:
	flutter run --dart-define=ENVIRONMENT=PRODUCTION

deploy-funcs:
	npm run --prefix functions/ build
	firebase deploy --only functions

deploy-dev:
	flutter build web --dart-define=ENVIRONMENT=DEVELOPMENT
	firebase use development
	firebase deploy

deploy:
	npm run --prefix functions/ build
	flutter build web --dart-define=ENVIRONMENT=PRODUCTION
	firebase use production
	firebase deploy
	firebase use development
dev:
	# Library/Application Support
	flutter run

gen_watch:
	flutter pub run build_runner watch

gen:
	flutter pub run build_runner build
	flutter pub get

clean_data:
	rm -r '/Users/lihaojun/Library/Application Support/com.example.client'

.PHONY: gen
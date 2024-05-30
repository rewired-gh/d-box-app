dev:
	# Library/Application Support
	flutter run

gen_watch:
	dart run build_runner watch

gen:
	dart run build_runner build
	flutter pub get

clean_data:
	rm -r '/Users/lihaojun/Library/Application Support/moe.rewired.dbox'

icons:
	dart run flutter_launcher_icons

.PHONY: dev gen_watch gen clean_data icons

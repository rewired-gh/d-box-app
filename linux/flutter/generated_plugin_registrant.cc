//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <build_info_linux/build_info_linux_plugin.h>
#include <objectbox_flutter_libs/objectbox_flutter_libs_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) build_info_linux_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BuildInfoLinuxPlugin");
  build_info_linux_plugin_register_with_registrar(build_info_linux_registrar);
  g_autoptr(FlPluginRegistrar) objectbox_flutter_libs_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ObjectboxFlutterLibsPlugin");
  objectbox_flutter_libs_plugin_register_with_registrar(objectbox_flutter_libs_registrar);
}

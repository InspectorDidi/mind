Package.describe({
  name: 'council',
  version: '0.1.0'
});

Package.onUse(function (api) {
  api.versionsFrom('1.0.3.1');

  // Core dependencies.
  api.use([
    'coffeescript',
    'underscore'
  ]);

  // 3rd party dependencies.
  api.use([
    'kadira:flow-router@2.7.0',
    'kadira:blaze-layout@2.1.0',
    'peerlibrary:blaze-components@0.13.0',
    'peerlibrary:computed-field@0.3.0',
    'peerlibrary:assert@0.2.5'
  ]);

  // Internal dependencies.
  api.use([
    'core'
  ]);

  api.addFiles([
    'flow-router/root.html',
    'flow-router/root.coffee',
    'flow-router/layout.html',
    'flow-router/layout.coffee',
    'meetings/base.coffee',
    'meetings/list.html',
    'meetings/list.coffee'
  ], 'client');
});

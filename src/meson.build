valagl_deps = [
    dependency('glib-2.0'),
    dependency('gobject-2.0'),
    dependency('gio-2.0'),
    dependency('gl'),
    dependency('sdl2'),
]

valagl_sources = [
    'app.vala',
    'app-error.vala',
    'canvas.vala',
    
    'core/camera.vala',
    'core/core-error.vala',
    'core/geometry-util.vala',
    'core/gl-program.vala',
    'core/ibo.vala',
    'core/matrix-math.vala',
    'core/vao.vala',
    'core/vbo.vala',
]

executable('valagl',
    valagl_resources,
    valagl_sources,
    vala_args: '--target-glib=2.58',
    dependencies: valagl_deps,
    link_args : ['-lepoxy', '-lm' ],
    install: true,
)

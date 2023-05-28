project('valagl', ['c', 'vala'],
    default_options: [ 'warning_level=2' ],
    version: '1.0',
    meson_version: '>= 0.50.0',
)

pkg = import('pkgconfig')

# Load custom vapi files
add_project_arguments(
    ['--vapidir', meson.current_source_dir() / 'vapi'],
    language: 'vala'
)

subdir('data')
subdir('src')

project(
    'valagl',
    
    ['c', 'vala'],
    version: '1.0',
    meson_version: '>= 0.50.0',
)

pkg = import('pkgconfig')
gnome = import('gnome')
epoxy_proj = subproject('libepoxy-vala')

# Load custom vapi files
epoxy_vapidir = epoxy_proj.get_variable('epoxy_vapidir')
add_project_arguments(
    ['--vapidir', epoxy_vapidir],
    language: 'vala'
)

subdir('data')
subdir('src')

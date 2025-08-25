config.load_autoconfig()
#Set the Dark Mode:
config.set("colors.webpage.darkmode.enabled",True)
#Toggle the Dark Mode:
config.bind('td', 'config-cycle colors.webpage.darkmode.enabled true false')

# load all functions and packages of the research compendium (qui sont dans le repertoire R)
devtools::load_all()

# Configure drake plan before execution
# drake_config collects and sanitizes all the parameters and settings
config <- drake::drake_config(
  plan = write_plan(),
  envir = getNamespace("datatoolboxexos"))

#write_plan()donne les 4 objets, specifie le plan utilisé
#datatoolboxexos::write_plan()

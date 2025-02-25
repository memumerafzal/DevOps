from datetime import date
import os
import shutil

sourcedir = r"F:\\Pipelines-Data\\actions-runner-BE\\actions-runner\\_work\\neutrino2.0_be\\neutrino2.0_be\\downloaded_artifact_BE_UAT"
dirpath = r"C:\\inetpub\\wwwroot\\UAT_Neutrinomed_Api"
basebackupdir = f'F:\\IIS\\Neutrino_UAT\\Backup\\Backup_{date.today()}\\BE'
basereleasedir = f'F:\\IIS\\Neutrino_UAT\\Release\\Release_{date.today()}\\BE'

def get_unique_path(path):
    if not os.path.exists(path):
        return path
    i = 1
    new_path = f"{path} ({i})"
    while os.path.exists(new_path):
        i += 1
        new_path = f"{path} ({i})"
    return new_path

# Existing code backup
backupdir = get_unique_path(basebackupdir)
shutil.copytree(dirpath, backupdir , dirs_exist_ok=True)

if os.path.exists(f"{sourcedir}\\wwwroot"):
    shutil.rmtree(f"{sourcedir}\\wwwroot")
else:
     print("wwwroot not included in package")



if os.path.exists(f"{sourcedir}\\appsettings.json"):
    os.remove(f"{sourcedir}\\appsettings.json")
else:
     print("appsettings.json not included in package")
     
if os.path.exists(f"{sourcedir}\\web.config"):
    os.remove(f"{sourcedir}\\web.config")
else:
     print("web.config not included in package")
# New Release backup
releasedir = get_unique_path(basereleasedir)
shutil.copytree(sourcedir, releasedir , dirs_exist_ok=True)

if os.path.exists(dirpath):
     print("Directory already there")
else:
     os.mkdir(dirpath)

# Deploying to IIS folder
shutil.copytree(sourcedir, dirpath , dirs_exist_ok=True)

shutil.rmtree(sourcedir)
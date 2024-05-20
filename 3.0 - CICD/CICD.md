## Install Plugins in Jenkins

1. **Eclipse Temurin Installer**:

	- This plugin allows Jenkins to automatically install and set up the Eclipse Temurin JDK, previously known as AdoptOpenJDK.
	- To install it, navigate to the Jenkins dashboard, then to Manage Jenkins -> Manage Plugins -> Available tab.
	- Look for "Eclipse Temurin Installer" and choose it.
	- Press the "Install without restart" button.
   
2. **Pipeline Maven Integration**:
   - This plugin adds Maven support to Jenkins Pipeline.
   - It enables the use of Maven commands directly within your Jenkins Pipeline scripts.
   - To install, follow the same procedure as before, but search for "Pipeline Maven Integration" instead.
   
3. **Config File Provider:

   - This plugin allows you to define configuration files (e.g., properties, XML, JSON) centrally in Jenkins.
   - These configurations can then be referenced and used by your Jenkins jobs.
   - Install it using the same procedure as mentioned earlier.

4. **SonarQube Scanner:

   - SonarQube is a code quality and security analysis tool.
   - This plugin integrates Jenkins with SonarQube by providing a scanner that analyzes code during builds.
   - You can install it from the Jenkins plugin manager as described above.


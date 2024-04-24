# DemoReCaptcha

## Instructions for deploy:

1. Download the project: 
2. Create Google iOS Project 
3. Attach downloaded project to your goggle account and rewrite GoogleService-info.plist in the root of the project.__
```
	Make sure that API_KEY, bundle_id, PROJECT_ID,GOOGLE_APP_ID are specified and correct
	https://console.firebase.google.com/
	https://www.google.com/recaptcha/about/

	Get started with Enterprise
	Choose platform type: iOS app
	Name the project at DisplayName field
	Add iOS Bundle ID of your project
	Press Create Key
	You'll get key like  this:
	New ID:   XXXXXXXXXXXXXXXXXXXX-XX-XXXXXXXXXXXXXXXX
	Copy and save this key, it would be required in the next steps
```
4. Change key for the reCAPTCHA in ViewController.swift   
	let client = try await Recaptcha.getClient(
		withSiteKey: "XXXXXXXXXXXXXXXXXXXX-XX-XXXXXXXXXXXXXXXX"
        )	

### Configuring backend server:

1. Bind the server with your google account. Download google-cloud-sdk from https://cloud.google.com/sdk/docs/install and unpack it in your home directory.
```bash
➜  ~ ./google-cloud-sdk/install.sh
Welcome to the Google Cloud CLI!

To help improve the quality of this product, we collect anonymized usage data
...
Do you want to help improve the Google Cloud CLI (y/N)?  N


Your current Google Cloud CLI version is: 473.0.0
The latest available version is: 473.0.0
...
Modify profile to update your $PATH and enable shell command completion?

Do you want to continue (Y/n)?  Y

The Google Cloud SDK installer will now prompt you to update an rc file to bring the Google Cloud CLIs into your environment.

Enter a path to an rc file to update, or leave blank to use [/Users/Dmitrii/.zshrc]:
Backing up [/Users/Dmitrii/.zshrc] to [/Users/Dmitrii/.zshrc.backup].
[/Users/Dmitrii/.zshrc] has been updated.

==> Start a new shell for the changes to take effect.


Google Cloud CLI works best with Python 3.11 and certain modules.

Download and run Python 3.11 installer? (Y/n)?  n

➜  ~ ./google-cloud-sdk/bin/gcloud init
Welcome! This command will take you through the configuration of gcloud.

Your current configuration has been set to: [default]

Network diagnostic detects and fixes local network connection issues.
Checking network connection...done.
Reachability Check passed.
Network diagnostic passed (1/1 checks passed).

You must log in to continue. Would you like to log in (Y/n)?  Y

Your browser has been opened to visit:
You are logged in as: [XXXXXXXXXX@gmail.com].

Pick cloud project to use:
 [1] your-project-id
...
 [N-1] Enter a project ID
 [N] Create a new project
Please enter numeric choice or text value (must exactly match list item):  1

Your current project has been set to: [your-project-id].
➜  ~
```

2. Note that in project at ViewController.swift  you could also change port and host of your backend server in method sendPostRequestToLocalServer:
	```swift
        let port = "5001"
        let host = "127.0.0.1"
        let url = URL(string: "http://\(host):\(port)/post")!
	```

3. Change in CheckToken.py information related to your project:
	```python
	project_id = "your-project-id"
    	recaptcha_site_key = "XXXXXXXXXXXXXXXXXXXX-XX-XXXXXXXXXXXXXXXX"
    	recaptcha_action = "example_action"
	```
Note that the last recaptcha_action is an action that would be checked. If app token returns different action that means that the request is malformed.
You could encrypt this action in the APP and decrypt it at backend server and then perform checks. But this requires additionall code modifications on both sides.

4. Run the backend server in the virtual environment:
	```puthon
	python3 -m venv path/to/venv
	source path/to/venv/bin/activate
	pip install google
	pip install --upgrade google-api-python-client
	pip install google-cloud-recaptcha-enterprise

	python3 SimpleBackendServer.py
	```
5. Run iOS symulator and check how reCAPTCHA works, you sould have something like following in the terminal:
	```python
	The reCAPTCHA score for this token is: 0.699999988079071
	Assessment name: a48354e07a000000
	127.0.0.1 - - [24/Apr/2024 14:54:28] "POST /post HTTP/1.1" 200 -
	```

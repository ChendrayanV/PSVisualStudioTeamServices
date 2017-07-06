# Authentication

There are two authentication methods named OAUTH and Personal Access Token \(PAT\) and this book covers about personal access token for a demo. OAUTH is much secured and used in production environments. Choosing the right authentication mechanism [guidance](https://www.visualstudio.com/en-us/docs/integrate/get-started/authentication/authentication_guidance) will give more insight.

## Personal Access Token

Follow the steps beneath to create a personal access token

1. Sign in to either your Visual Studio Team Services account \([https://{youraccount}.visualstudio.com\](https://{youraccount}.visualstudio.com%29\)
2. From your home page, open your _**profile**_. Go to your _**security**_ details.
3. In the right pane click Personal access tokens and choose add. 
4. Name your _**token**_ and select the _**timespan.**_

The personal access token needs a conversion to base64 string and the below PowerShell script will do it. 


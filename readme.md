# Fake CoPilot CLI

I thought the new CoPilot CLI helper was super cool! However, I thought it must
be super easy to replicate.

In fact, it was.

I didn't write any of this code. GPT-4 did.

But it works!

Set the environment variable `OPEN_AI_API_KEY` and run it with your chosen
alias.

It will suggest commands and run them if you so choose.

It's probably not as good. I did have to make a couple corrections. But it's amazing that this is actually so useful!

Example:

```
> ./fake-copilot-cli.sh recursively list all files over 25kb
Suggested command: find . -size +25k
Do you want to run this command? (yes/no/correct/exit) yes
Executing: find . -size +25k
example/file-1.txt
example/file-4.png
example-48/file-6.html
```

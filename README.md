### shupper.ps1
A simple powershell script to assemble 200 parts of base64 encoded SharpUp, and run it in memory **to test endpoint detection & response systems**

### how to
A base64 encoded version of SharpUp.exe is attached with the script which you can use, or you can compile SharpUp and encode SharpUp.exe on your own (recommended). Regarldess, you will need to break this up into its 200 parts for the script to function.

Base64 encode SharpUp.exe once compiled with:

```
[Convert]::ToBase64String([IO.File]::ReadAllBytes("C:\Path\To\SharpUp.exe")) | Out-File -Encoding ascii base64.txt
```

Break up that Base64 encoded file into 200 parts with PowerShell... 
or use this web resource by Pine Tools like I did: https://pinetools.com/split-files

Note that the parts must all be named specifically base64.txt.part001 -> base64.txt.part200

This is simply just how the site broke them up, and I ran with that format, dont judge me. You can always change this in the script if you would like.

This is _very obviously_ all educational and for ethical hacking purposes.

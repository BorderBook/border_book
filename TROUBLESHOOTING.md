# Troubleshooting

## GPT-Engineer + Windows PowerShell

When you run gpt-engineer on Windows using Powershell you may have an issue
with encoding some characters, when it tries to translate GPT output to files.

In order to fix this bug, you can try the following steps to address the
encoding issue:

### 1. Set PYTHONIOENCODING in PowerShell

Before running your Python script, set the PYTHONIOENCODING environment
variable in PowerShell to enforce UTF-8 encoding:

```powershell
$env:PYTHONIOENCODING = "utf-8"
```

After setting this, run your Python script again. This ensures Python uses
UTF-8 for all I/O operations.

### 2. Use UTF-8 as Default in PowerShell

To set UTF-8 as the default encoding for PowerShell (which may help with other
character encoding issues):

```powershell
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
```

This command sets PowerShell's output encoding to UTF-8. While this won't affect
Python directly, it ensures the terminal handles characters correctly when
displaying output.

### 3. Modify Python Script or Virtual Environment Encoding

If setting the environment variable doesn't work, consider modifying the script
(if possible) as I mentioned earlier:

Open files with:

```python
with open(path, "w", encoding="utf-8") as f:
```

### 4. UTF-8 in Python Virtual Environment

If you're using a virtual environment, ensure it’s set up with UTF-8 encoding
as default. You can add this to your activate.ps1 script in the virtual
environment:

```powershell
$env:PYTHONIOENCODING = "utf-8"
```

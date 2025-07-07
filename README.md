# diskcheck.sh

A simple, resumable file readability scanner for macOS and Linux.

## What it does

- Scans every file on a target disk or folder
- Tests if each file is fully readable (by reading all bytes)
- Logs any unreadable (I/O error) files
- Supports pause and resume (safe to Ctrl+C and restart later)
- Shows progress, percentage, and estimated time remaining

---

## Usage

```bash
sudo ./diskcheck.sh /path/to/target_folder_or_disk
```

Example

```bash
sudo ./diskcheck.sh "/Volumes/MyExternalDrive"
```

## Features

- Progress log: remembers which files were tested (`~/diskcheck_progress.log`)
- Error log: unreadable files are listed in (`~/diskcheck_unreadable_files.txt`)
- Detailed errors: from cat system errors go to (`~/diskcheck_read_errors.log`)
- Resumable: interrupt with Ctrl+C, restart later — previously tested files are skipped


## Requirements
- bash (default on macOS/Linux)
- no other dependencies

## Limitations
- Only checks readability (basic I/O health)
- It does not verify data against checksums like SHA256
- If you need cryptographic verification, combine with md5sum or shasum

MIT License

Copyright (c) 2025 Dario Pagliaricci

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
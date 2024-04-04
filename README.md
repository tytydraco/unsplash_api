# unsplash_api

Unsplash API access without an API key.

# Getting started

Install the program using the following command:

`dart pub global activate -s git https://github.com/tytydraco/unsplash_api`

# Usage

```
unsplash -h

-h, --help                Shows the usage.
-d, --directory           The directory path for photo downloads.
                          (defaults to ".")
-n, --number              The number of photos to download.
                          (defaults to "1")
-q, --quality             [smallS3, thumb, small, regular, full (default), raw]
-w, --[no-]watermarked    Include watermarked (premium or plus) photos.
-e, --[no-]dry            Dry run; no downloads.
-r, --[no-]overwrite      Whether or not to overwrite existing downloads.
-v, --[no-]verbose        Provide logging.
```

# Example

`unsplash -d "~/Downloads" -n 50 -- Green Forest`

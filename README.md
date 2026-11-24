# Calendar Date Gaps

Sort unique ISO dates and measure calendar-day gaps between consecutive dates.

## Run

In PowerShell 7+, run `./run.ps1 -InputFile ./example.txt`. Pass `-OutputFile ./result.txt` to save to a new file. Existing output files are protected.

## Example

One YYYY-MM-DD date per line. The bundled example output includes:

```text
2 days
```

## Limitations

Input records are read from a UTF-8 text file. Blank lines are skipped.

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for checks and [CHANGELOG.md](CHANGELOG.md) for changes.

## License

[MIT License](LICENSE). Copyright (c) 2026 calendar-date-gaps contributors.

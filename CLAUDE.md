# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

`noted` is a lightweight bash CLI tool for taking markdown notes in a journal-like (time-series) fashion on macOS. It automatically creates date-stamped markdown files and appends timestamped entries.

## Key Commands

### Testing Changes
```bash
# Test the script directly (no build needed)
./noted version

# Test creating a note
./noted "Test note"

# Test viewing configuration
./noted config
```

### Development Workflow
1. Edit the bash script: `noted` (no extension)
2. Test changes directly by running `./noted [command]`
3. No compilation or build steps required

## Architecture

### Single Script Structure
The entire application is in a single bash file (`noted`) with this organization:

1. **Functions** (lines 9-103): Alphabetically ordered functions that implement all features
   - `create()`: Creates new note entries with templates
   - `edit()`: Opens files using macOS `open` command
   - `markdownFile()`: Constructs file paths
   - `ngrep()`: Wrapper for recursive grep in notes directory
   - `validate()`, `version()`, `loadProperties()`, etc.

2. **Configuration** (lines 109-131):
   - Hard-coded defaults
   - `loadProperties()` sources `$HOME/.notedconfig` to override defaults
   - Five configurable properties: `NOTED_MARKDOWN_HOME`, `NOTED_FILE_NAME_DATE_FORMAT`, `NOTED_TIMESTAMP_FORMAT`, `NOTED_TEMPLATE_FILE`, `NOTED_TODO_MARKER`

3. **Subcommand Router** (lines 138-171):
   - Simple if/elif chain to dispatch to functions
   - Default behavior is `create` when no subcommand specified

### Template System
- Templates support two variables: `TIMESTAMP` and `HEADERTEXT`
- Default template is embedded in the script (lines 37-45)
- Users can provide custom template via `NOTED_TEMPLATE_FILE` config

### Design Patterns
- Uses bash string replacement for templating: `${result/TIMESTAMP/$timestamp}`
- Leverages heredocs for multiline strings
- Function-based organization with clear single responsibilities
- Configuration via sourced file allows user customization without modifying script

## Adding New Features

### Adding a New Subcommand
1. Add function in alphabetical order in the functions section
2. Add elif branch in the subcommand router (lines 138-171)
3. Update `subcommands.md` documentation

### Adding a New Configuration Property
1. Add default value in the configuration section (lines 119-126)
2. Update `outputConfig()` function to display the new property
3. Document in README.md configuration guide

### Modifying Template Behavior
Template expansion happens in the `create()` function (lines 24-61). The template text is loaded either from `NOTED_TEMPLATE_FILE` or the default heredoc, then variables are replaced using bash parameter expansion.

## Important Constraints

- **macOS-specific**: Uses `open` command for file editing
- **Bash-only**: No other languages or dependencies
- **Single file**: Keep all functionality in the main `noted` script
- **Configuration**: Always respect user settings from `$HOME/.notedconfig`
- **Date formatting**: Uses standard `date` command format strings

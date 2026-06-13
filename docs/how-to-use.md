# How to Use This Kit

Use short in-agent commands after running `agent-init` in a project.

## For a bug

```txt
/bug

Error:
[paste error]

Expected:
[what should happen]

Actual:
[what happened]
```

## For code review

```txt
/review current diff against main
```

## For a structured fix

```txt
/fix add login validation
```

## For UI work

```txt
/ui fix mobile navbar
```

## For security and debugging together

```txt
/use debugging security
```

## For session behavior

```txt
/mode strict
/mode frontend
/mode security
/mode production
/mode reset
```

## Fallback

Use this only when an agent ignores slash commands:

```txt
Treat /bug as debugging workflow using AGENTS.md command router.
```

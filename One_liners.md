# Importing accounts from [fedifinder](http://fedifinder.glitch.me/) JSON file

```
for i in `cat accounts.json | jq '.[]["handles"]' | rg -v "\[\]" | rg -v "\[|\]" | tr -d '"'`; do toot follow "$i" &; done
```

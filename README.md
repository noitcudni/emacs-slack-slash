## Dependency
emacs-slack-slash is dependent on [`emacs-web]`(https://github.com/nicferrier/emacs-web). In your .spacemacs' `dotspacemacs/layers`, add the following inside the `dotspacemacs-addtional-packages` list

```lisp
dotspacemacs-additional-packages '(
  (web :location (recipe :fetcher github :repo "nicferrier/emacs-web"))                   ;; <--- add this
  (slack-slash :location (recipe :fetcher github :repo "noitcudni/emacs-slack-slash"))    ;; <--- add this one two
)
```

## Create your clj slash command inside emacs
```lisp
(clj-slack-setup :fun-name my-clj-fun
                 :command "/clj"
                 :channel-name "clj"
                 :username-name "self explanatory"
                 :token "command token goes here"
                 :external-url "Your external URL goes here"
                 )
```
It's worth noting that `:fun-name` doesn't take in a string. Whatever you supply here, it's be turned into a function with that name.

## Key binding to the newly created function
In your .spacmacs' `dotspacemacs/user-config` function, add the following:

```lisp
(define-key evil-normal-state-map ",nf" 'my-clj-fun)
```

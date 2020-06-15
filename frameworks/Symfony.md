# Symfony with Webpack Encore

Tested on a fresh install of a Symfony (5.1.2) web application with
[Webpack Encore](https://symfony.com/doc/current/frontend.html#webpack-encore) installed.

```bash
$ yarn add interactiveimagejs
```

Edit the `app.js` file
```javascript
import '../../node_modules/interactiveimagejs/dist/interactive-image.css'
import '../../node_modules/interactiveimagejs/dist/interactive-image.js'
```

Then:

```bash
$ yarn encore dev
```

Finally, add the required HTML tags (or edit your `js` files for JavaScript):

```html
<div id="my-interactive-image" style="width: 400px; height: 200px; background: url('/build/images/landscape.jpg')"></div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    var items = [
        {
            type: "text",
            title: "Fur",
            description: "The fur of clouded leopards is...",
            position: {
                left: 100,
                top: 50
            }
        }
    ];

    $(document).ready(function() {
        $("#my-interactive-image").interactiveImage(items);
    });
</script>
```

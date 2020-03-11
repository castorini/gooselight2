# ACL Anthology Blacklight Changes

This blacklight application uses styles and HTML components from the [ACL Anthology](https://github.com/acl-org/acl-anthology). Modifications from the original ACL Anthology are listed below.

This modification list is updated as of March 11, 2020.

#### Styles

Location: [app/assets/stylesheets/main.scss](app/assets/stylesheets/main.scss)

ACL Anthology source file: [main.scss](https://github.com/acl-org/acl-anthology/blob/master/hugo/assets/css/main.scss) 

Modifications:

* Removed vendor imports for bootstrap and other SCSS files in the ACL repository
* Removed the secondary color variable override `$secondary`

#### Header

Location: [app/views/shared/_header_navbar.html.erb](app/views/shared/_header_navbar.html.erb)

ACL Anthology source file: [header_navbar.html](https://github.com/acl-org/acl-anthology/blob/master/hugo/layouts/partials/header_navbar.html)

Modifications:

* Changed search bar route and query parameters to support Blacklight
* Changed navbar links to use plain HTML instead of Hugo templating
* Updated the ACL logo image location

#### Footer

Location: [app/views/shared/_footer_.html.erb](app/views/shared/_footer.html.erb)

ACL Anthology source file: [footer.html](https://github.com/acl-org/acl-anthology/blob/master/hugo/layouts/partials/footer.html)

Modifications:

* Added the `bg-light` classname to the footer HTML element for background color

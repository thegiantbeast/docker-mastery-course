# Assignment: Writing a compose files

* Build a basic compose file for Drupal content management system website
* Use the `drupal` image along with the `postgres` image
* Use `ports` to expose Drupal on 8080 so you can `localhost:8080`
* Be sure to set `POSTGRES_PASSWORD` for postgres
* Walk though Drupal setup
* Tip: Drupal assumes DB is `localhost`, but it's a service name
* Extra credit: Use volumes to store Drupal unique data
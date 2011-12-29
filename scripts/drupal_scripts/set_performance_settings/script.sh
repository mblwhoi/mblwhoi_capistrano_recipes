#!/bin/sh

# Set performance settings for a drupal site.

# This script should be run from the top-level directory of a drupal site.

# Enable page caching
drush vset --yes cache 1;

# Enable page compression
drush vset --yes page_compression 1;

# Enable block caching
drush vset --yes block_cache 1;

# Enable preprocessing css
drush vset --yes preprocess_css 1;

# Enable preprocessing js
drush vset --yes preprocess_js 1;




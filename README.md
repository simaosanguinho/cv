# Simão Sanguinho - CV Website

This repository contains the source code for my personal CV website, built using [Hugo](https://gohugo.io/). The site is designed to showcase my professional experience, education and skills.

![CV Preview](.github/assets/preview.png)

## Repository Layout

- **`data/content.yaml`** → contains the actual CV data  
- **`layouts/`** → includes the HTML templates used to render the pages  

---

## Getting Started

To run the project locally, you’ll need [Hugo](https://gohugo.io/). Once installed, run:

```bash
hugo server -D

```

## Building the Site
To build the site for production, use:

```bash
hugo --minify
```

A deployment script is provided in `deploy.sh` to automate the deployment process to the server.
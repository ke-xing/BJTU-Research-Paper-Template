# BJTU Paper Template for Overleaf

A GitHub-ready and Overleaf-ready LaTeX paper template for Beijing Jiaotong University (BJTU). It is designed for computer science and artificial intelligence papers, with modular sections, BJTU visual identity, BibTeX references, and a clean project layout.

## Project structure

```text
.
├── main.tex                  # Root document
├── bjtu.cls                  # BJTU paper class and visual style
├── references.bib            # BibTeX references
├── config/
│   ├── metadata.tex          # Title, authors, affiliations, keywords
│   └── packages.tex          # Extra packages and user macros
├── sections/                 # Main paper sections
├── appendix/                 # Appendix files
├── figures/                  # Figures and BJTU logo assets
├── tables/                   # Optional table files
├── .github/workflows/        # GitHub Actions PDF build workflow
└── .gitignore
```

## Use on Overleaf

### Option 1: Import from GitHub

1. Push this folder to a GitHub repository.
2. Open Overleaf.
3. Choose **New Project** → **Import from GitHub**.
4. Select your repository.
5. Set the main document to `main.tex`.
6. Use **pdfLaTeX** for the default English template.
7. Click **Recompile**.

### Option 2: Upload as a ZIP file

1. Compress all files in this folder into a `.zip` archive.
2. Open Overleaf.
3. Choose **New Project** → **Upload Project**.
4. Upload the `.zip` archive.
5. Set the main document to `main.tex`.
6. Use **pdfLaTeX** and recompile.

## Compiler settings

The default document class line is:

```latex
\documentclass[english,preprint]{bjtu}
```

Use **pdfLaTeX** for the default English version.

For a Chinese paper, change it to:

```latex
\documentclass[chinese,preprint]{bjtu}
```

Then switch the Overleaf compiler to **XeLaTeX**.

## Edit your paper

Most content should be edited in these files:

- `config/metadata.tex`: title, authors, affiliations, keywords, venue information.
- `sections/00_abstract.tex`: abstract and TL;DR.
- `sections/01_introduction.tex` to `sections/08_statements.tex`: main body.
- `appendix/`: appendix material.
- `references.bib`: BibTeX entries.

The file `main.tex` is intentionally minimal. It only controls the document structure and the order of included sections.

## Add figures

Put image files under `figures/`, then include them in LaTeX with:

```latex
\includegraphics[width=\linewidth]{your-figure-file}
```

You do not need to write the `figures/` prefix because the class already configures the graphics path.

## Build and publish on GitHub

This repository includes a GitHub Actions workflow at:

```text
.github/workflows/build-latex.yml
```

On every push to `main`, GitHub will compile `main.tex`, generate a PDF, and publish a small preview website through GitHub Pages.

After the first successful workflow run, the public preview page will be available here:

[View the GitHub Pages preview](https://ke-xing.github.io/BJTU-Research-Paper-Template/)

The page includes an embedded PDF preview and a direct download link:

[Download the compiled PDF](https://ke-xing.github.io/BJTU-Research-Paper-Template/BJTU-Research-Paper-Template.pdf)

The workflow also uploads the compiled `main.pdf` as an Actions artifact for each run.

To download the artifact manually:

1. Open your GitHub repository.
2. Go to **Actions**.
3. Open the latest successful workflow run.
4. Download the artifact named `bjtu-paper-template-pdf`.

### Enable GitHub Pages

In your GitHub repository, open **Settings** → **Pages**, then set:

- **Source**: `GitHub Actions`

This only needs to be configured once.

## Push to GitHub

From inside this folder, run:

```bash
git init
git add .
git commit -m "Initial Overleaf BJTU paper template"
git branch -M main
git remote add origin git@github.com:YOUR_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

Replace `YOUR_USERNAME/YOUR_REPOSITORY` with your actual GitHub repository path.

If you prefer HTTPS, use:

```bash
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
```

## Common issues

### Overleaf cannot find `bjtu.cls`

Make sure `bjtu.cls` and `main.tex` are in the same top-level directory.

### Overleaf cannot find logo images

Make sure the full `figures/` folder was uploaded or imported from GitHub.

### Chinese text does not compile

Use the `chinese` class option and switch the compiler to **XeLaTeX**.

### References do not show up

Use **Recompile from scratch** in Overleaf, or run the build twice. The template uses BibTeX through `natbib`.

## License

MIT License. You may use, modify, and redistribute this template.

# Base image
FROM rocker/tidyverse

# Set working directory
WORKDIR /home/rstudio

# Copy all required files
COPY . .

# Update, install requiRements package, install R packages from requirements.txt,
# install Quarto, and cleanup cache afterwards to reduce image size
RUN apt-get update && \
    R -e 'install.packages("requiRements")' && \
    R -e 'requiRements::install(path_to_requirements = "requirements.txt")' && \
    apt-get install -y curl && \
    curl -sSL https://downloads.quarto.org/quarto-cli/0.2.289/quarto-cli-0.2.289-linux.deb -o quarto.deb && \
    apt-get install -y ./quarto.deb && \
    rm quarto.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

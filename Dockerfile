# Base image
FROM rocker/tidyverse

# Set working directory
WORKDIR /home/rstudio

# Update and install required system packages
RUN apt-get update && \
    apt-get install -y curl gdebi-core && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install requiRements package
RUN R -e 'install.packages("requiRements")'

# Copy the requirements file
COPY requirements.txt .

# Install R packages from requirements.txt
RUN R -e 'requiRements::install(path_to_requirements = "requirements.txt")'

# Install Quarto and cleanup cache afterwards to reduce image size
RUN curl -LO https://quarto.org/download/latest/quarto-linux-amd64.deb && \
    gdebi -n quarto-linux-amd64.deb && \
    rm quarto-linux-amd64.deb

# Copy remaining required files
COPY . .

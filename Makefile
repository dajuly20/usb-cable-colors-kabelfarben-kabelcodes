all: pdf

pdf:
	@pandoc readme.md -o Kabelmanagement_Farblegende.pdf
install:
    sudo apt update && sudo apt install -y pandoc

docker.transmission
===================

docker build -t quangpham/transmission github.com/quangpham/transmission

    docker run -i -t --name transmission --volumes-from transmission quangpham/transmission bash
    
    docker run -d -p 9091:9091 -p 80:80 --name transmission -v /downloads:/var/lib/transmission-daemon/downloads quangpham/transmission
    
ebook-convert "book.epub" "book.mobi"
NB: Other formats are supported, too:

ebook-convert "book.azw3" "book.pdf"

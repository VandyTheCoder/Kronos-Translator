# Rails rTesseract Example

This project, I created for practicing to use [Tesseract-OCR](https://github.com/tesseract-ocr/) and [rTesseract-OCR Gem](https://github.com/dannnylo/rtesseract). It is OCR system for English and Khmer and created by using [Ruby On Rails](http://rubyonrails.org/).

## Getting Started

Before you install this project, there are some required source you need to install first before installing the project.

### Prerequisites

Install [Tesseract-OCR](https://github.com/tesseract-ocr/)
```
sudo apt-get install tesseract-ocr-eng
sudo apt-get install tesseract-ocr-khm
```

Install [ImageMagick](https://www.imagemagick.org/script/index.php)
```
sudo apt install imagemagick
convert -h
```

### Installing

You need to install the third party library gems from [RubyGems](https://rubygems.org/) and create the database.

Install Gems

```
bundle install
```

Create database and tables

```
rails db:migrate
```

Running Application

```
rails server
```

***Congratulation!*** Now, you already run the project on your machine or server.


## Versioning

Chronos Version is ***1.0.0***.

## Authors

* **Vandy Sodanheang** - *Initial work* - [Web and Mobile Developer](https://www.linkedin.com/in/vandy-sodanheang-368410113/)

See also the list of [contributors](https://github.com/Sodanheang/Chronos-Translator/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

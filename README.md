# Krosnos Translator

This project, I created for reviewing what I have learnt in **Natural Language Processing** and **Rails Action Cable(Real-Time System)**. It is fun experience because I have learnt a lot of things from this project. It is real-time translating like google translate and I created by using [Ruby On Rails](http://rubyonrails.org/).

## Getting Started

Before you install this project, there are some required source you need to install first before installing the project.

### Prerequisites

Install [Redis-Server](https://redis.io/)
```
sudo apt-get install redis-server
```

Running Redis-Server in Local Hosting(Independent Terminal)
```
redis-server
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

Run Redis-Server (Open Another Terminal)

```
redis-server
```

Run Rails Application(Independent Terminal)

```
rails server
```

Run Sidekiq Backgound Job(Independent Terminal)

```
sidekiq
```

***Congratulation!*** Now, you are ready to run the project on your local server.

## Notice
Because the data(corpus) were collected by my friends from unversity, I can't push the model along with source code. You have to
train it your self using [Mose Decoder](http://www.statmt.org/moses/).

-> Edit Path to Your Trained Model in file ***kronos-translator>app>worker>transalte_worker.rb***

## Versioning

Kronos Translator Version is ***1.0***

## Authors

* **Vandy Sodanheang** - *Initial work* - [Web and Mobile Developer](https://www.linkedin.com/in/vandy-sodanheang-368410113/)
* **NIPTICT CS FAMILY** - *Co-initial work* - Web and Mobile Developer

See also the list of [contributors](https://github.com/Sodanheang/Kronos-Translator/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

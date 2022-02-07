#!/bin/sh

# 2022-02 時点、 AWS Lambda ランタイム最新 Python バージョン
readonly GLOBAL_VERSION=3.9.10

# python
asdf plugin add python
asdf install python $GLOBAL_VERSION
$(asdf which pip) install --upgrade pip
$(asdf which pip) install awsume
asdf global python $GLOBAL_VERSION
asdf reshim python

# awscli
asdf plugin add awscli
asdf install awscli latest
asdf global awscli latest
asdf reshim awscli

# terraform
asdf plugin add terraform
asdf install terraform latest
asdf global terraform $(asdf latest terraform)
asdf reshim terraform

# go
asdf plugin add golang
asdf install golang latest
asdf global golang $(asdf latest golang)
asdf reshim golang

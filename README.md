# PocCircleciBuildkitParent

## Generate a CircleCI compatible openssh keypair


```
openssl genrsa -out ~/.ssh/circleci 2048
chmod 600 ~/.ssh/circleci
ssh-keygen -y -f ~/.ssh/circleci > ~/.ssh/circleci.pub
chmod 600 ~/.ssh/circleci.pub
```

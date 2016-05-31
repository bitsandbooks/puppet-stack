# puppet-stack

## Introduction

This repo demonstrates how to provision a few servers using Puppet, using common patterns and tools. Right now, it is built for Ubuntu 14.04 "Trusty Tahr" LTS systems, but may work with earlier releases that use Upstart for their init system. It has not yet been tested with 15.04 "Vivid Vervet", 15.10 "Wily Werewolf" or 16.04 "Xenial Xerus", as they use the Systemd init system. (Such support may be forthcoming.)

## Notes

* UFW rules must be set manually, like so: `ufw allow ssh && ufw allow http && ufw allow https`.

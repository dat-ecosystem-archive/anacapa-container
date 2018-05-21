# Anacapa Container

A containerized way to run the [Anacapa eDNA processing toolkit](https://github.com/limey-bean/Anacapa) on your own machine or server.

## Requirements

- Access to a Linux computer (Mac/Windows planned but not ready yet)
- [http://singularity.lbl.gov/docs-mount](Singularity) installed
- [https://github.com/datproject/dat/#installing-the--dat-command-line-tool](Dat) installed
- Around 6GB of disk space

### 1. Install Singularity

If you are intending to run this on a shared university cluster (one where you are not a system administrator and cannot use 'sudo' or install new system packages yourself) you will need to ask your system administrators to install Singularity. Please share with them this admin guide: http://singularity.lbl.gov/admin-guide

Otherwise, if you are using your own server, you can follow the admin guide yourself to install Singularity.

### 2. Install Dat

Dat is the data transfer software that you will use to download the 6GB container file. Unlike singularity, you do not need to be a system administrator to use Dat. Follow the guide here to install the `dat` command line tool (shared computing users can use the standalone version):

https://github.com/datproject/dat/#installing-the--dat-command-line-tool

### 3. Download the latest container

Once you have a way to download Dat links, download the following Dat repository to your machine using this command:

```
dat clone dat://5342b90492befa56fa50c74f2a59925f8a95b299567d75a06013ce62a2e12724 anacapa-container
```

### 4. Try running the container

Try this command to enter the container:

```
singularity shell anacapa-container/anacapa-1.2.0.img
```

You should see something like this:

```
$ singularity shell anacapa-1.2.0.img
Singularity: Invoking an interactive shell within container...

Singularity anacapa-1.2.0.img:~> 
```

Any commands you type in the Singularity shell will happen inside the container. Type `exit` to go back to your normal shell.



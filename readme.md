# Anacapa Container

Instructions For Running [The Anacapa Toolkit](https://github.com/limey-bean/Anacapa) in a Singularity container using Linux or a Vagrant Virtualbox for Mac/Windows.

Written by Emily Curd and Max Ogden.

## Requirements

- Linux (Recommended) or Windows/Mac via Virtualbox (Slower but works)
- Around 6GB of disk space

## Overview

The following guide shows how to download and run the Anacapa toolkit and process a small test dataset. To ensure reproducibility we recommend verifying the test dataset matches the included expected output data from our verified runs. Once you complete these steps you may continue on to load your own data for custom analysis.

### Linux Instructions

For Mac/Windows instructions, first see the [Vagrant](#vagrant) section below.

We recommend using Linux to run Anacapa Container, as running it on Windows or Mac involves virtualization which imposes performance and resource limitations, potentially making analysis slower depending on the size of your data.

### 1. Install Singularity

If you are intending to run this on a shared university cluster (one where you are not a system administrator and cannot use 'sudo' or install new system packages yourself) you will need to ask your system administrators to install Singularity. Please share with them this admin guide: http://singularity.lbl.gov/admin-guide

Otherwise, if you are using your own server, you can follow the admin guide yourself to install Singularity.

This guide was tested with Singularity version 2.5.2.

### 2. Download the container and test data

Download the Linux container dataset from DASH: https://doi.org/10.6071/M31H29. You will be emailed a download link that you can download to whatever machine you want to run the analysis on (You can do `wget <url of download>` to download on the CLI directly and then `tar xf downloaded-file.tar.gz` to extract it).

You should now see 3 files. 

#### anacapa-1.5.0.img

This is the Singularity container with all necessary software dependencies (Python, R, Perl, Bash) you will use with Singularity to execute the Anacapa toolkit. This image was created using Containerfile in this repository.

#### anacapa_db.tar.gz

This is a copy of the Anacapa toolkit packaged with a full copy of all CRUX primer types, and a small 12S test sequence. The extracted `anacapa` directory will contain the following:
  - Anacapa_db (the toolkit itself)
  - 12S_test_data
  - Anacapa_test_data_expected_output_after_QC_dada2
  - Anacapa_test_data_expected_output_after_classifier
  - Crux_test_expected_output

#### crux_db.tar.gz

(Optional) A partial copy of the [CRUX](https://github.com/limey-bean/CRUX_Creating-Reference-libraries-Using-eXisting-tools/) repository modified for use in Vagrant and a small 16S test dataset. If developing your own reference libraries, you will need to extract this and then download additional files. Follow the instructions in the CRUX GitHub readme if so.

### 3. Test the container

Try this command to enter the container:

```
singularity shell anacapa-1.5.0.img
```

You should see something like this:

```
$ singularity shell anacapa-1.5.0.img
Singularity: Invoking an interactive shell within container...

Singularity anacapa-1.5.0.img:~> 
```

Any commands you type in the Singularity shell will happen inside the container. Type `exit` to go back to your normal shell.

### 4. Run the Anacapa QC example

This command runs the Anacapa QC pipeline with the included `12S_test_data`. Edit the ANACAPA variable to point to your extracted `anacapa` folder.

```
$ export ANACAPA="/home/vagrant/anacapa"
$ singularity exec /home/vagrant/anacapa-container/anacapa-1.5.0.img /bin/bash $ANACAPA/Anacapa_db/anacapa_QC_dada2.sh -i $ANACAPA/12S_test_data -o /home/vagrant/12S_time_test -d $ANACAPA/Anacapa_db -f $ANACAPA/12S_test_data/forward.txt -r $ANACAPA/12S_test_data/reverse.txt -e $ANACAPA/Anacapa_db/metabarcode_loci_min_merge_length.txt -a nextera -t MiSeq -l
```

The expected results can be found in `anacapa/Anacapa_test_data_expected_output_after_QC_dada2`

Approximate time to run:

```
real	0m45.906s
user	0m43.568s
sys	0m1.396s
```

If using `slurm` or `qsub` an example job file is available in the `jobs/` folder of this repository.

### 5. Run the Anacapa Classifier example

This command runs the Anacapa Classifier pipeline on the output of the QC pipeline. Edit the ANACAPA variable to point to your extracted `anacapa` folder.


```
$ export ANACAPA="/home/vagrant/anacapa"
$ singularity exec /home/vagrant/anacapa-container/anacapa-1.5.0.img /bin/bash $ANACAPA/Anacapa_db/anacapa_classifier.sh -o /home/vagrant/12S_time_test -d $ANACAPA/Anacapa_db  -l
```

The expected results can be found in `anacapa/Anacapa_test_data_expected_output_after_classifier`

Approximate time to run:

```
real	0m19.467s
user	0m13.384s
sys	0m1.480s
```

If using `slurm` or `qsub` an example job file is available in the `jobs/` folder of this repository.

### 6. (Optional) Run the CRUX example

***Note*** To run Crux on Linux, you'll need to download a large amount of external genomic/taxonomy data. Please see the Crux readme for more info.

**Note** For all the follow examples, you may need to change the exact paths to match the paths on your local machine. Included paths use vagrant paths as an example.

```
$ singularity exec /home/vagrant/anacapa-1.5.0.img /bin/bash /home/vagrant/anacapa/crux_db/crux.sh -n 16S_example -f GTGYCAGCMGCCGCGGTAA -r GGACTACNVGGGTWTCTAAT -s 200 -m 450 -o ~/anacapa/crux_db/16S_example -d ~/anacapa/crux_db/ -l -a 1 -v 0.001 -e 5 -q
```

The expected results can be found in `~/anacapa/Crux_test_expected_output`

### Vagrant

#### Instructions For Mac/Windows Users

These instructions will allow users to run the Anacapa Toolkit on an OSX or PC. The authors note that running Anacapa on a Virtualbox may reduce the speed, and performance of the toolkit. We recommend that the user allow the Vagrant Virtualbox at least 10 GB of memory. 	If the vagrant Virtualbox does not have at least 5 GB of free Memory some steps may fail.

1. Install Singularity Vagrant Virtualbox Linux

Follow these Vagrant/Singularity installation instructions (These pages are also backed up in Git files above if links break):
  - Instructions can be found here for a Mac: http://singularity.lbl.gov/install-mac
  - Instructions can be found here for a PC: http://singularity.lbl.gov/install-windows

2. Start a new instance and login

After a successful installation of the Singularity Vagrant VirtualBox, start a new instance by logging into a terminal (for Mac) or GitBash for (PC).

As per the above instructions, you should have already created a folder e.g. `singularity-vm` and executed the command `vagrant init singularityware/singularity-2.4` inside of it. You only have to do those two commands once as a set up step. However, each time you wish to use the vagrant machine you have to ensure you run the following three commands:

```
$ cd singularity-vm/
$ vagrant up
$ vagrant ssh
```

The final command, `vagrant ssh`, will open a terminal into the virtual machine where you have the `singularity` command available.

3. Download the Anacapa vagrant container

Download the Anacapa Vagrant Container (Mac/Windows) from https://doi.org/10.6071/M3R07J. Extract the downloaded .tar.gz file and you should see an anacapa.img and a copy of both Anacapa and CRUX configured for use in Vagrant. Move the `crux_db` folder inside the `Anacapa_db` folder. Then move `anacapa-1.5.0.img` and `Anacapa_db` into a new folder somewhere you are comfortable working in, such as a folder called 'anacapa' in your home folder.

4. To load your own data

If the need arises, users can load their own data into the Virtualbox by adding it to the `singularity-vm/` directory and moving it into the vagrant directory in the Vituralbox.

```
vagrant@vagrant:/vagrant$ cp -r /vagrant/datafolder ~/anacapa/
```

5. Follow test instructions

At this point please follow the Linux instructions above, starting at number 3 "Test the container", using your `vagrant ssh` session to enter the commands.

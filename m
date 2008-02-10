From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sun, 10 Feb 2008 19:43:59 +0000
Subject: Re: How can I test a joystick type device?
Message-Id: <1202672639.6237.2.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202514806.6237.1.camel@localhost.localdomain>
In-Reply-To: <1202514806.6237.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Fri, 2008-02-08 at 19:18 -0600, Harley Laue wrote:
> On Friday 08 February 2008 05:53:26 pm you wrote:
> > As below shows I think I have successfully ported the 2.4 Dreamcast
> > controller driver to 2.6 - but how can I test it? Is there a device I
> > should be looking for in /dev that I could just cat?
> Cool. 
> if a /dev/input/js? or /dev/js? does not show up you can try:
> mknod js0 c 13 0
> then you can cat js0 and move the joystick to see if it's working


Clearly the porting isn't as simple as I'd hoped: I cannot seem to get a
udev rule to recognise the thing and if I create the node manually there
is strangeness and an unwillingness to work!

I'll hack away at it, but I obviously need to get a better understanding
of the 2.6 input layer also...

-bash-3.1# ls js* -l
crw-r--r-- 1 root 4294967258 13, 0 Feb 10 19:39 js0
-bash-3.1# df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda1            189303128 159489980  20197044  89% /
tmpfs                     6852         0      6852   0% /lib/init/rw
udev                     10240         4     10236   1% /dev
tmpfs                     6852         0      6852   0% /dev/shm
/dev/gdrom           189303128 159489980  20197044  89% /mnt
-bash-3.1# mknod js0 c 13 0
mknod: `js0': File exists
-bash-3.1# rm js0
-bash-3.1# mknod js0 c 13
0                                                                                                                                  
-bash-3.1# ls js* -l
crw-r--r-- 1 root 4294967258 13, 0 Feb 10 19:40 js0
-bash-3.1# cat js0
cat: js0: No such device


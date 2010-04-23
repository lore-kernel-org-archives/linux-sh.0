From: Alexandre Courbot <alex@dcl.info.waseda.ac.jp>
Date: Fri, 23 Apr 2010 06:25:12 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <w2yea710c1b1004222325ue422e52bx244f5ee34dd2ba9a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

> Does the kernel commandline option "earlyprintk=sh-sci.1,115200" work?

It does not - nothing gets displayed at all by the kernel.

> Your command line is word wrapped so it's not apparent what options you
> are using.

Sorry - the options I were using on sh2007 to get the log I attached
previously are
"earlyprintk=bios console=ttySC1,115200"

> One noticeable difference for sh-bios users in sh-sci is the
> detach callback via sh_bios_gdb_detach(), you might want to try
> commenting this out to make sure you're not trapping in to some bogus
> location.

> If the sh-bios earlyprintk is working for you then you might
> also try the 'keep' option to prevent the serial console from taking
> control away from it.

Indeed, that workarounds the problem, but then I stop getting feedback
from the kernel starting from when init is supposed to start:

VFS: Mounted root (nfs filesystem) on device 0:12.
Freeing unused kernel memory: 184k freed

However, by monitoring the network activity (I use a NFS root FS), I
can see that the init script executes normally as all the boot time
invoked binaries and libraries are sent through the network. Therefore
the kernel is starting normally, but it seems it just lacks a console
that uses the same device as the kernel earlyprintk. Any idea about
how I could create such an entry in /dev/ ? (major/minor numbers?)

Still, it would be nice to get the SCIF to work on that platform. I'm
willing to investigate the problem (may be clock-related indeed), but
could someone provide me some guidance about where in the driver I
should look at?

Thanks again, looks like I'm close to having a working kernel again!
Alex.

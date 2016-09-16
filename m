From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Date: Fri, 16 Sep 2016 20:43:17 +0000
Subject: Re: Runtime failure running sh:qemu in -next due to 'sh: fix copy_from_user()'
Message-Id: <20160916204317.GK14311@csclub.uwaterloo.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <20160916191218.GA12104@roeck-us.net>
 <20160916200320.GZ2356@ZenIV.linux.org.uk>
 <20160916203205.GA29660@roeck-us.net>
In-Reply-To: <20160916203205.GA29660@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>

On Fri, Sep 16, 2016 at 01:32:05PM -0700, Guenter Roeck wrote:
> On Fri, Sep 16, 2016 at 09:03:20PM +0100, Al Viro wrote:
> > On Fri, Sep 16, 2016 at 12:12:18PM -0700, Guenter Roeck wrote:
> > > Hi,
> > > 
> > > I see the following runtime failure when running a 'sh' image with qemu in -next.
> > > 
> > > [ ... ]
> > > 
> > > sd 0:0:0:0: [sda] Attached SCSI disk
> > > EXT2-fs (sda): warning: mounting unchecked fs, running e2fsck is recommended
> > > VFS: Mounted root (ext2 filesystem) on device 8:0.
> > > Freeing unused kernel memory: 124K (8c48a000 - 8c4a9000)
> > > This architecture does not have kernel memory protection.
> > > random: fast init done
> > > Starting logging: OK
> > > usb 1-1: new full-speed USB device number 2 using sm501-usb
> > > Initializing random number generator... done.
> > > Starting network...
> > > ip: OVERRUN: Invalid argument
> > > ip: OVERRUN: Bad address
> > > ip: OVERRUN: Bad address
> > > ip: OVERRUN: Bad address
> > > ip: OVERRUN: Bad address
> > > [repeats until the test aborts]
> > > 
> > > Bisect points to commit 6e050503a150 ("sh: fix copy_from_user()"). Bisect log is
> > > attached.
> > 
> > BTW, could you post your .config and information about your userland?  E.g.
> > is that ip(8) a busybox one, etc.  If it's busybox, this smells like EINVAL
> > and EFAULT resp. coming from recvmsg() on netlink sockets, with nothing
> > extraordinary in iovecs, AFAICS...
> 
> Please see https://github.com/groeck/linux-build-test/tree/master/rootfs/sh.
> The rootfs is some three years old. I don't remember how I created it :-).

Well it certainly says in it that ip is busybox, and the version is 1.21.1

-- 
Len Sorensen

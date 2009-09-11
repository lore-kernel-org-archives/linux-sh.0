From: Matt Fleming <matt@console-pimps.org>
Date: Fri, 11 Sep 2009 18:35:59 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090911183557.GA21695@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 11, 2009 at 01:06:31PM -0500, Dale Larson wrote:
> I've been porting linux (2.6.30.2) to our 7763 based platform and the
> kernel seems to be running fine but when user mode programs run I
> randomly get errors like this:
> 
> [    8.419557] VFS: Mounted root (nfs filesystem) on device 0:9.
> [    8.431863] Freeing unused kernel memory: 80k freed
> init started: BusyBox v1.14.3 (2009-09-04 15:19:48 CDT)
> [    8.682286] Fixing up unaligned userspace access in "mount" pid2
> pc=0x295583d0 ins=0x60b2
> [    8.699336] Sending SIGBUS to "mount" due to unaligned access (PC
> a0042955 PR 295583da)
> Populating /dev using udev: done
> 
> Another example:
> 
> Starting dropbear sshd: OK
> [  484.428550] Fixing up unaligned userspace access in "touch" pid8
> pc=0x295583d0 ins=0x60b2
> [  492.438796] Sending SIGBUS to "touch" due to unaligned access (PC
> a0042955 PR 295583da)
> 
> The SIGBUS kills the process. I've tried various versions of linux
> form kernel.org: 2.6.28, 2.6.29, 2.6.30 and all have the same
> behaviour.
> 
> Using JTAG I see that I'm having both data alignment and PC alignment
> problems. If I turn off the I&D caching this problem doesn't happen.
> 

This is most likely to be the cache aliasing bug I'm hunting. What are
the dimensions of your cache? Can you tried building a kernel from the
sh/cachetlb branch at,

git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git

and see if the issue persists? Paul has made some changes recently that
might work around this problem.

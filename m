From: David McCullough <David_Mccullough@securecomputing.com>
Date: Tue, 08 Apr 2008 03:20:12 +0000
Subject: Re: SH7751R - STRANGE initramfs/rootfs behavior
Message-Id: <20080408032012.GB11323@securecomputing.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
In-Reply-To: <9e0cf0bf0804070616y72f1bf4er6dcbb23188937543@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Jivin Paul Mundt lays it down ...
> On Mon, Apr 07, 2008 at 04:16:01PM +0300, Alon Bar-Lev wrote:
> > I am trying to boot 2.6.24 kernel on SH7751R big endian (sh4eb) using
> > embedded initramfs, anyone have this configuration working?
> > 
> > I use zImage converted to srec using objcopy, load the srec into
> > memory and jump to the load address of the kernel.
> > 
> > The kernel boots, but when trying to decompress the initramfs image it
> >  fails with "crc error",  resulting from lib/inflate.c::gunzip:1250.
> > 
> > Has anyone got this error? The initramfs image is correct. I also
> > dumped the memory of __initramfs_start->__initramfs_start and verified
> > that it matches the initramfs image on usr/initramfs_data.cpio.gz.
> > 
> I've noticed this on an SH7203 (SH-2A FPU) board, which is also
> big-endian. It seems to be an endianness issue, in that it's never show
> up on any of the little endian configurations. If your board is
> endianness selectable, I'd suggest trying little endian and seeing if
> that works.
> 
> Little endian certainly gets the bulk of the testing, so it's quite
> possible that there are some things broken on big endian.

I have done this on several big-endian mips boards,  so I don't think
it's endianess.

Most of the problems I have seen in this area were generally due to
either setting up the initramfs incorrectly,  bad dram settings or
something to do with memory maps/bootloaders and image sizes.  Not much
help I know.

Settings:

	CONFIG_BLK_DEV_INITRD=y
	CONFIG_INITRAMFS_SOURCE="/tmp/XX.ramfs.cpio"
	CONFIG_INITRAMFS_ROOT_UID=0
	CONFIG_INITRAMFS_ROOT_GID=0

and the initramfs is created with:

	cd rootfsdir; find . | cpio --quiet -o -H newc > /tmp/XX.ramfs.cpio

followed of course by a:

	make vmlinux

or whatever you need, maybe there is something in there that helps,

Cheers,
Davidm

-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com

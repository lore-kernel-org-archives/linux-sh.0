From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 31 Oct 2008 07:26:28 +0000
Subject: Re: How could i use a file system on Ram ?
Message-Id: <20081031072628.GH26928@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <loom.20081024T092251-945@post.gmane.org>
In-Reply-To: <loom.20081024T092251-945@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 24, 2008 at 09:35:14AM +0000, Cuong Dang Phu wrote:
> Hi,
> 
> This is my problem: my kernel can find root file system (it???s loaded on Ram)
> 
> ???
> RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
> driver sh_udc, 12 Nov 2007
> List of all partitions:
> No filesystem could mount root, tried: ext3 ext2 cramfs minix vfat
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
> ???
> 
> My kernel command is: ???root=/dev/ram0??? I think my kernel doesn???t know file-
> system???s address and I don???t know how to configure kernel, could you help me to 
> configure it?
> 
It sounds like you may wish to give initramfs a try. See:

	http://www.linux-sh.org/shwiki/Using_Early_User_Space

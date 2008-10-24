From: Cuong Dang Phu <cuongdp@Cybersoft-VN.com>
Date: Fri, 24 Oct 2008 09:35:14 +0000
Subject: How could i use a file system on Ram ?
Message-Id: <loom.20081024T092251-945@post.gmane.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Hi,

This is my problem: my kernel can find root file system (it’s loaded on Ram)

…
RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
driver sh_udc, 12 Nov 2007
List of all partitions:
No filesystem could mount root, tried: ext3 ext2 cramfs minix vfat
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)
…

My kernel command is: “root=/dev/ram0” I think my kernel doesn’t know file-
system’s address and I don’t know how to configure kernel, could you help me to 
configure it?

Best regards,



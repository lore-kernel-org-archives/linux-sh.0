From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 10 Jun 2019 13:36:04 +0000
Subject: Linux SH kernel currently broken on qemu-system
Message-Id: <e7855beb-fbf6-8f67-140f-21820a0fe4af@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Booting the Linux SH kernel in qemu-system currently doesn't work, the screen
just stays black. Previously, the kernel suffered another regression where it
booted but crashed very early.

The first regression came with the following commit:

205e1b7f51e4af2643eb1d61a6503e415cd1e014 is the first bad commit
commit 205e1b7f51e4af2643eb1d61a6503e415cd1e014
Author: Christoph Hellwig <hch@lst.de>
Date:   Fri Dec 22 14:50:47 2017 +0100

    dma-mapping: warn when there is no coherent_dma_mask
    
    These days all devices should have a DMA coherent mask, and most dma_ops
    implementations rely on that fact.  But just to be sure add an assert to
    ring the warning bell if that is not the case.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
    Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

:040000 040000 e0c021952944b917e5055be573140b11fc02134d aa01f012af1cad3af647b04aa12ee701ac0e1f6e M      include

I haven't found the commit yet which caused the second regression but Michael
Karcher (CC'ed) has found out that the kernel already crashing while trying
to decompress the compressed zImage.

To test, I used the current debian-installer netboot image for sh4 which
I built and uploaded at [1].

I'm booting with:

$ qemu-system-sh4 -M r2d -kernel installer-sh4/current/images/sh7751r/netboot/vmlinuz-4.19.0-5-sh7751r \
  -initrd installer-sh4/current/images/sh7751r/netboot/initrd.gz -hda debian.qcow \
  -append "root=/dev/sda1 console=tty0"

The qcow image was created with:

$ qemu-img create -f qcow2 debian.qcow 10G

Adrian

> [1] https://cdimage.debian.org/cdimage/ports/debian-installer/sh4/debian-installer-images_20190411_sh4.tar.gz

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Date: Mon, 23 Mar 2015 01:36:16 +0000
Subject: Can't mount QSPI-FLASH to userland on Lager
Message-Id: <550F6E10.8010907@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Rob Herring-san.
I'm sorry to bother you!

I'm Hiep from Jinzai Solution (a Japanese Company).
We are testing Linux kernel v4.0-rc2 on Lager and Koelsch Board (=20
Renesas's boards).
When we tried to test QSPI-FLASH, we can't mount the device file of=20
QSPI-FLASH on Lager.
(Koelsch has no problems)
The logs is showed as below:
#mount /dev/mtdblock2 /mnt/
"EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mtdblock2.
EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
FAT-fs (mtdblock2): bogus number of reserved sectors
FAT-fs (mtdblock2): Can't find a valid FAT filesystem
FAT-fs (mtdblock2): bogus number of reserved sectors
FAT-fs (mtdblock2): Can't find a valid FAT filesystem
mount: you must specify the filesystem type"

We found that, after removing this patch(as below),
QSPI-FLASH can mount on Lager very well without any problems.
"9064bf3=E3=80=80spi: spi-pxa2xx: only include mach/dma.h for legacy DMA"
I'd like to report it to you and please review it when you have time.


Best Regards,
Jinso/Cao Minh Hiep.


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 27 May 2013 01:39:46 +0000
Subject: ARM: shmobile: r8a7778: rename device additional functio
Message-Id: <87hahp8ald.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches rename device additional function on r8a7778.
These are part of "I2C/HSPI/MMC support to r8a7778/BockW/defconfig",
but, I separeted patches into small set.

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: rename device additional function for sh-eth
      ARM: shmobile: r8a7778: rename device additional function for sdhi

> 1) - 2) are not SH patch but needed
> 3) - 5) are pfc patches
> 6) - 8) are r8a7778 patches
> 9) - b) are bockw patches
> c) - e) are defconfig patches
> f) - h) are tidyup cleanup patches

These are f) - h) part patches as 2nd step,
and independed from my previous 1st step patches
("add __initdata on resource and device data" patch)

base on  renesas-next-20130526 tag

# sdhi patch exchange both board and setup files
# please let me know if you need separeted patches.

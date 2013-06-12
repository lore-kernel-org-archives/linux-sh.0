From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 12 Jun 2013 02:14:00 +0000
Subject: [PATCH 0/3 v4] ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <877gi06pp7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2rs6pvv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2rs6pvv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> 1) - 2) are not SH patch but needed
> 3) - 5) are pfc patches
> 6) - 8) are r8a7778 patches
> 9) - b) are bockw patches
> c) - e) are defconfig patches
> f) - h) are tidyup cleanup patches

These patches are part of c) - e) v4 I2C/HSPI/MMC support on BockW defconfig.
These patches are based on renesas-next-20130611v2 tag

Kuninori Morimoto (3):
      ARM: shmobile: bockw defconfig: add RTC RX8581 support
      ARM: shmobile: bockw defconfig: add M25P80 support
      ARM: shmobile: bockw defconfig: add MMCIF support

 arch/arm/configs/bockw_defconfig |   11 +++++++++++
 1 file changed, 11 insertions(+)

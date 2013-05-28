From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 May 2013 04:20:42 +0000
Subject: Re: ARM: shmobile: r8a7778/bockw: add I2C/HSPI/MMC support
Message-Id: <874ndnag6h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li7fwgk8.wl%kuninori.morimoto.gx@renesas.com>
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

These patches are part of 6) - 8) v3 I2C/HSPI/MMC support for r8a7778.

These patches are based on renesas-next-20130527 tag

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: add I2C support
      ARM: shmobile: r8a7778: add HSPI support
      ARM: shmobile: r8a7778: add MMCIF support

 arch/arm/mach-shmobile/clock-r8a7778.c        |   23 +++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    5 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   61 +++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

Best regards
---
Kuninori Morimoto

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 01:21:36 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7778: HSPI support on DT
Message-Id: <8738ngzzky.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are HSPI support for r8a7778 on DT.
HSPI driver DT support exist on this branch

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git :: topic/hspi

But there is no boot issue without it.
I'm using renesas-devel-v3.12-rc7-20131030.

# BTW, renesas-devel-v3.12-rc7-20131030 has double I2C support
# on ${LINUX}/arch/arm/boot/dts/r8a7778.dtsi
# the commits are
# 3c13daa1ef375122c327b1e959187da0dd4d6a7b
# 7cab820da7a496fba63d5355152c781344465408

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: add HSPI suppport on DTSI
      ARM: shmobile: r8a7778: add HSPI clock support for DT
      ARM: shmobile: bockw: enable HSPI0 on DTS

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |   11 +++++++++
 arch/arm/boot/dts/r8a7778.dtsi                |   30 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-r8a7778.c        |    3 +++
 3 files changed, 44 insertions(+)



Best regards
---
Kuninori Morimoto

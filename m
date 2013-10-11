From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:33:31 +0000
Subject: [PATCH 0/10] ARM: shmobile: marzen/bockw: SDHI support on DT
Message-Id: <87li201fm0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are SDHI support on DT for marzen/bockw.
These are based on renesas-devel-20131011

#1 fixup dts file conflict issue
#2, #3 are cleanup patch for bockw
#4 - #7 are SDHI support on r8a7778/BockW
#8 - #10 are SDHI support on r8a7779/Marzen


Kuninori Morimoto (10):
       1) ARM: shmobile: bockw: fixup MMC pin conflict on DTS
       2) ARM: shmobile: bockw: header cleanup
       3) ARM: shmobile: bockw: fixup FPGA ioremap area
       4) ARM: shmobile: r8a7778: add SDHI clock support for DT
       5) ARM: shmobile: bockw: add pin pull-up setting for SDHI
       6) ARM: shmobile: r8a7778: add SDHI support on DTSI
       7) ARM: shmobile: bockw: add SDHI support on DTS
       8) ARM: shmobile: r8a7779: add SDHI clock support for DT
       9) ARM: shmobile: r8a7779: add SDHI support on DTSI
      10) ARM: shmobile: marzen: add SDHI support on DTS

 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   24 +++++++++++---
 arch/arm/boot/dts/r8a7778.dtsi                 |   30 ++++++++++++++++++
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |   11 ++++++-
 arch/arm/boot/dts/r8a7779.dtsi                 |   40 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++--
 arch/arm/mach-shmobile/clock-r8a7778.c         |    3 ++
 arch/arm/mach-shmobile/clock-r8a7779.c         |    4 +++
 7 files changed, 125 insertions(+), 7 deletions(-)


Best regards
---
Kuninori Morimoto

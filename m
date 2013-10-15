From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 15 Oct 2013 07:43:36 +0000
Subject: [PATCH 00/17] ARM: shmobile: fixup DT node naming
Message-Id: <87iowzdlnh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches cleanup DT node to use generic naming,
and are focusing on SDHI/MMC/SCIF.
These are based on renesas-devel-20131011 + my previous
"ARM: shmobile: marzen/bockw: SDHI support on DT" patches.

My previous patches are not applied yet at this point,
but I send fixup patches for it here.

Simon, please let me know if you want v2 patches instead
of these fixup patches for my previous series

Kuninori Morimoto (17):
      ARM: shmobile: r8a73a4: fixup DT node naming for SDHI
      ARM: shmobile: r8a73a4: fixup DT node naming for MMCIF
      ARM: shmobile: r8a73a4: fixup DT node naming for SCIFA
      ARM: shmobile: r8a7740: fixup DT node naming for SDHI
      ARM: shmobile: r8a7740: fixup DT node naming for MMCIF
      ARM: shmobile: r8a7740: fixup DT node naming for SCIFA
      ARM: shmobile: sh73a0: fixup DT node naming for SDHI
      ARM: shmobile: sh73a0: fixup DT node naming for MMCIF
      ARM: shmobile: sh73a0: fixup DT node naming for SCIFA
      ARM: shmobile: r8a7778: fixup DT node naming for SCIF
      ARM: shmobile: r8a7778: fixup DT node naming for SDHI
      ARM: shmobile: r8a7778: fixup DT node naming for MMCIF
      ARM: shmobile: r8a7779: fixup DT node naming for SDHI
      ARM: shmobile: r8a7779: fixup DT node naming for SCIF
      ARM: shmobile: r8a7790: fixup DT node naming for SCIF
      ARM: shmobile: r8a7790: fixup DT node naming for SDHI
      ARM: shmobile: r8a7790: fixup DT node naming for MMCIF

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |   24 ++++++++--------
 arch/arm/boot/dts/r8a73a4.dtsi                     |   10 +++----
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   22 +++++++-------
 arch/arm/boot/dts/r8a7740.dtsi                     |    6 ++--
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      |   12 ++++----
 arch/arm/boot/dts/r8a7778.dtsi                     |    8 +++---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |   12 ++++----
 arch/arm/boot/dts/r8a7779.dtsi                     |    8 +++---
 arch/arm/boot/dts/r8a7790-lager-reference.dts      |    8 +++---
 arch/arm/boot/dts/r8a7790.dtsi                     |   12 ++++----
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   30 ++++++++++----------
 arch/arm/boot/dts/sh73a0.dtsi                      |    8 +++---
 12 files changed, 80 insertions(+), 80 deletions(-)


Best regards
---
Kuninori Morimoto

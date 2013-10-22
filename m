From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Oct 2013 02:32:57 +0000
Subject: Re: [PATCH 00/12] ARM: shmobile: fixup DT node naming
Message-Id: <877gd6m3vt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 of cleanup DT node patches.
#1 - #6 are for SoC,
#7 - #12 are for board.

#1 also added missing SDHI2 entry.
SoC DT node cleanup patches are including clock cleanup.

Kuninori Morimoto (12):
       1) ARM: shmobile: r8a7740: tidyup DT node naming
       2) ARM: shmobile: r8a73a4: tidyup DT node naming
       3) ARM: shmobile: r8a7778: tidyup DT node naming
       4) ARM: shmobile: r8a7779: tidyup DT node naming
       5) ARM: shmobile: r8a7790: tidyup DT node naming
       6) ARM: shmobile: sh73a0: tidyup DT node naming
       7) ARM: shmobile: armadillo: tidyup DT node naming
       8) ARM: shmobile: ape6evm: tidyup DT node naming
       9) ARM: shmobile: kzm9g: tidyup DT node naming
      10) ARM: shmobile: bockw: tidyup DT node naming
      11) ARM: shmobile: marzen: tidyup DT node naming
      12) ARM: shmobile: lager: tidyup DT node naming

 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |    8 ++++----
 arch/arm/boot/dts/r8a73a4.dtsi                     |   10 +++++-----
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |    8 ++++----
 arch/arm/boot/dts/r8a7740.dtsi                     |   18 +++++++++++++++---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      |    4 ++--
 arch/arm/boot/dts/r8a7778.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |    6 +++---
 arch/arm/boot/dts/r8a7779.dtsi                     |    8 ++++----
 arch/arm/boot/dts/r8a7790-lager-reference.dts      |    4 ++--
 arch/arm/boot/dts/r8a7790.dtsi                     |   10 +++++-----
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    8 ++++----
 arch/arm/boot/dts/sh73a0.dtsi                      |    8 ++++----
 arch/arm/mach-shmobile/clock-r8a73a4.c             |   10 +++++-----
 arch/arm/mach-shmobile/clock-r8a7740.c             |    8 ++++----
 arch/arm/mach-shmobile/clock-r8a7778.c             |    8 ++++----
 arch/arm/mach-shmobile/clock-r8a7779.c             |    8 ++++----
 arch/arm/mach-shmobile/clock-r8a7790.c             |   12 ++++++------
 arch/arm/mach-shmobile/clock-sh73a0.c              |    8 ++++----
 18 files changed, 83 insertions(+), 71 deletions(-)

Best regards
---
Kuninori Morimoto

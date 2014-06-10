From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 10 Jun 2014 02:33:01 +0000
Subject: [PATCH 0/3][RFC] ARM: shmobile: r8a7790/lager sound support on DT
Message-Id: <87wqcpcx3w.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are r8a7790/lager sound patches on DT.
These add PIO transfer mode only at this poinnt,
since DMA DT is not supported yet.

I add [RFC] for these patches, 
because this "PIO transfer" only will be new confusion
for some reasons.
I (or Ben ?) will send full patches if DMA DT was supported.

The purpose of these patches is sharing information for sound DT

But, I guess #1 (#2 too ?)
can be applied immediately ?

Kuninori Morimoto (3):
      ARM: shmobile: r8a7790: add MSTP10 support on DTSI
      ARM: shmobile: r8a7790: add R-Car sound support on DTSI
      ARM: shmobile: lager: add sound support on DT

 arch/arm/boot/dts/r8a7790-lager.dts       |   70 +++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi            |   88 +++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig            |    1 +
 include/dt-bindings/clock/r8a7790-clock.h |   26 +++++++++
 4 files changed, 185 insertions(+)


Best regards
---
Kuninori Morimoto

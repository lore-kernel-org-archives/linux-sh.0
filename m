From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:35:56 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: r8a7778/r8a7790: sound DT support
Message-Id: <878urydhee.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ior2dhp9.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ior2dhp9.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches adds sound DT support on r8a7778/r8a7790.
But, r8a7778 can't use it at this point,
since it doesn't support CCF.

These patches are based on...

     1) Simon's renesas-devel-v3.14-rc7-20140324
     2) Mark's  asoc/topic/rcar
     3) Mark's  asoc/topic/simple
     4) Mark's  asoc/fix/rcar
     5) my previous patches

Kuninori Morimoto (7):
      ARM: shmobile: r8a7790: add MSTP10 support on DTSI
      ARM: shmobile: r8a7790: add R-Car sound support on DTSI
      ARM: shmobile: r8a7778: add R-Car sound support on DTSI
      ARM: shmobile: lager: enable sound codec for DT
      ARM: shmobile: bockw: enable sound codec for DT
      ARM: shmobile: lager: add R-Car sound support on DTS
      ARM: shmobile: bockw: add R-Car sound support on DTS

 arch/arm/boot/dts/r8a7778-bockw-reference.dts |  138 +++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi                |   54 ++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts           |   51 +++++++++
 arch/arm/boot/dts/r8a7790.dtsi                |  105 +++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                |    3 +
 include/dt-bindings/clock/r8a7790-clock.h     |   24 +++++
 6 files changed, 375 insertions(+)

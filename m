From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:30:53 +0000
Subject: Re: [PATCH 0/4 v2] ARM: shmobile: bockw: enable SMSC on DT
Message-Id: <87ioxgyszq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 patches of SMSC support on BockW via DT.
These depends on renesas-devel-20131001 tag

Kuninori Morimoto (4):
      ARM: shmobile: r8a7778: split r8a7778_init_irq_extpin() for DT
      ARM: shmobile: r8a7778: add renesas_intc_irqpin support on DT
      ARM: shmobile: bockw: add SMSC support on reference
      ARM: shmobile: bockw: add SMSC support on DTS

 arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   27 +++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7778.dtsi                 |   19 +++++++++++++++++
 arch/arm/mach-shmobile/board-bockw-reference.c |   20 ++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h  |    1 +
 arch/arm/mach-shmobile/setup-r8a7778.c         |    6 +++++-
 5 files changed, 71 insertions(+), 2 deletions(-)

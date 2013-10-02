From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:37:02 +0000
Subject: Re: [PATCH 0/4 v2] ARM: shmobile: marzen: fixup SMSC IRQ
Message-Id: <87bo38yspg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

These patches are v2 of fixup Marzen board SMSC IRQ miss settings.
These are based on renesas-devel-20131001 tag

Kuninori Morimoto (4):
      ARM: shmobile: r8a7779: split r8a7779_init_irq_extpin() for DT
      ARM: shmobile: r8a7779: add default status on irqpin
      ARM: shmobile: marzen: enable INTC IRQ
      ARM: shmobile: marzen: fixup SMSC IRQ number on DTS

 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |    8 ++++++--
 arch/arm/boot/dts/r8a7779.dtsi                  |    1 +
 arch/arm/mach-shmobile/board-marzen-reference.c |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c          |    6 +++++-
 5 files changed, 14 insertions(+), 3 deletions(-)

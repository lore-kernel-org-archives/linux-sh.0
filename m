From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 06:18:56 +0000
Subject: [PATCH 0/2] ARM: shmobile: marzen: fixup SMSC IRQ
Message-Id: <87siwkyz3n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches fixup Marzen board SMSC IRQ miss settings.
Current SMSC on Marzen reference is using IRQ1 directly,
but it should be use INTC IRQ.
(Un)fortunately it works before, but doesn't work now,
since current r8a7779.dtsi has INTC IRQ settings.
(IRQ conflict occur)
These patches fixup this issue.

Kuninori Morimoto (2):
      ARM: shmobile: r8a7779: split r8a7779_init_irq_extpin() for DT
      ARM: shmobile: marzen: enable INTC IRQ and fixup SMSC IRQ number

 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |    8 ++++++--
 arch/arm/boot/dts/r8a7779.dtsi                  |    1 +
 arch/arm/mach-shmobile/board-marzen-reference.c |    1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h   |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c          |    6 +++++-
 5 files changed, 14 insertions(+), 3 deletions(-)

Best regards
---
Kuninori Morimoto

From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 15 May 2013 02:57:26 +0000
Subject: [PATCH v2 0/4] marzen-reference ethernet patches
Message-Id: <1368586650-26263-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi,

this series builds on work by Laurent Pinchart and in turn
prior work by Guennadi Liakhovetski and myself.

The four small patches attepts to fix SMSC ethernet support for
the marzen-reference board. It does seem to be sufficient in order
to initialise the NIC and complete a boot using nfsroot.
However, as reported by Laurent earlier, there appear to be
some issues with spurious interrupts.

This series is based on the renesas-next-20130515v2 tag of
my renesas branch.

Laurent Pinchart (2):
  ARM: shmobile: marzen-reference: Reference the correct IRQ for
    ethernet
  ARM: shmobile: marzen-reference: Update lan device name in pinctrl
    maps

Simon Horman (2):
  ARM: shmobile: marzen-reference: Initialise irqpin
  ARM: shmobile: marzen-reference: Set SMSC lan to use irq-push-pull

 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |  5 +++--
 arch/arm/mach-shmobile/board-marzen-reference.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

-- 
1.8.2.1


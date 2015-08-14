From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 14 Aug 2015 13:53:06 +0000
Subject: [PATCH 0/2] r8a7778/bockw: fix SMSC Ethernet for MP
Message-Id: <1439560388-5061-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series enables the DT-wise IRLM setup in the intc-irqpin driver (same
as on r8a7779) and configures the FPGA correctly.

CU
Uli


Ulrich Hecht (2):
  ARM: shmobile: r8a7778: enable IRLM setup via DT
  ARM: shmobile: bockw dts: enable SMSC interrupt

 arch/arm/boot/dts/r8a7778-bockw.dts       | 17 +++++++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi            |  3 ++-
 drivers/irqchip/irq-renesas-intc-irqpin.c |  6 ++++--
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.4.6


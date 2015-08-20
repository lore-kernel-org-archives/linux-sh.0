From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 20 Aug 2015 15:45:53 +0000
Subject: [PATCH v2 0/3] r8a7778/bockw: fix SMSC Ethernet for MP
Message-Id: <1440085556-4340-1-git-send-email-ulrich.hecht+renesas@gmail.com>
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

               
Changes since v1: 
- split IRLM support into C and DT parts
- added clarifying comment to FPGA description
- added Acks


Ulrich Hecht (3):
  irqchip: renesas-intc-irqpin: r8a7778 IRLM setup support
  ARM: shmobile: r8a7778: enable IRLM setup via DT
  ARM: shmobile: bockw dts: enable SMSC interrupt

 arch/arm/boot/dts/r8a7778-bockw.dts       | 20 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi            |  3 ++-
 drivers/irqchip/irq-renesas-intc-irqpin.c |  6 ++++--
 3 files changed, 26 insertions(+), 3 deletions(-)

-- 
2.4.6


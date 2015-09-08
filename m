From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 08 Sep 2015 15:42:21 +0000
Subject: [PATCH v3 0/5] r8a7778/bockw: fix SMSC Ethernet for MP
Message-Id: <1441726946-30131-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

This series enables the DT-wise IRLM setup in the intc-irqpin driver (same
as on r8a7779) and configures the FPGA correctly.

This revision adds defconfig updates and Simon's Tested-By.

CU
Uli


Changes since v2:
- added defconfig updates
- added Tested-By

Changes since v1:
- split IRLM support into C and DT parts
- added clarifying comment to FPGA description
- added Acks


Ulrich Hecht (5):
  irqchip: renesas-intc-irqpin: r8a7778 IRLM setup support
  ARM: shmobile: r8a7778: enable IRLM setup via DT
  ARM: shmobile: bockw dts: enable SMSC interrupt
  ARM: shmobile_defconfig: enable PINCTRL_SINGLE
  ARM: multi_v7_defconfig: enable PINCTRL_SINGLE

 arch/arm/boot/dts/r8a7778-bockw.dts       | 20 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7778.dtsi            |  3 ++-
 arch/arm/configs/multi_v7_defconfig       |  1 +
 arch/arm/configs/shmobile_defconfig       |  1 +
 drivers/irqchip/irq-renesas-intc-irqpin.c |  6 ++++--
 5 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.4.6


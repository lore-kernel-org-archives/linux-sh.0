From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 24 Jul 2013 13:15:06 +0000
Subject: [PATCH 00/14] sh-pfc: r8a7790: Various fixes and improvements
Message-Id: <1374671720-8794-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

Here's a set of 14 assorted sh-pfc fixes, cleanups and improvements for the
r8a7790 platform. There's not much more to tell, the individual patches are
pretty self-descriptive.

Kunihito Higashiyama (1):
  sh-pfc: r8a7790: Add MSIOF pin groups and functions

Laurent Pinchart (2):
  sh-pfc: r8a7790: Sort pin groups and functions alphabetically
  sh-pfc: r8a7790: Add SCIF2 pin groups and functions

Shinobu Uehara (2):
  sh-pfc: r8a7790: Add USB pin groups and functions
  sh-pfc: r8a7790: Add VIN pin groups and functions

Shinya Kuribayashi (9):
  sh-pfc: r8a7790: Rename I2C SDA/SCL pins
  sh-pfc: r8a7790: Remove trailing '_TANS' string from RTS/CTS pins
  sh-pfc: r8a7790: Remove deprecated Ethernet MII/RMII pins
  sh-pfc: r8a7790: Remove deprecated RDS pins
  sh-pfc: r8a7790: Remove deprecated SPV_EVEN pin
  sh-pfc: r8a7790: Swap SCIFA2_RXD_B and HRX0_C configurations
  sh-pfc: r8a7790: Add TCLK1 pin configuration support
  sh-pfc: r8a7790: Add SCIF2 pins configuration support
  sh-pfc: r8a7790: Fix miscellaneous pinmux configuration tables
    mistakes

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 1621 +++++++++++++++++++++-------------
 1 file changed, 994 insertions(+), 627 deletions(-)

-- 
Regards,

Laurent Pinchart


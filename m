From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Nov 2013 03:15:47 +0000
Subject: [PATCH v2 0/8] Lager multiplatform support
Message-Id: <1384053355-30703-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This is the second version of the patch set that moves the lager-reference
board over to multiplatform kernel. It starts by syncing the Lager DTS with
the Lager reference DTS (1/8), set the external clock frequency in DT (2/8),
switches lager-reference over to multiplatform (3/8 to 4/8) and cleans up
unneeded leftovers (5/8 to 8/8).

The net result is a multiplatform-only lager-reference board with a single DTS
shared by the lager and lager-reference boards.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/lager

Compared to v1, the patches have been rebased on top of the second version of
the r8a7790 CCF patches that I've just posted.

Laurent Pinchart (8):
  ARM: shmobile: Sync Lager DTS with Lager reference DTS
  ARM: shmobile: lager: Specify external clock frequency in DT
  ARM: shmobile: lager-reference: Switch to multiplaform
  ARM: shmobile: lager-reference: Instantiate clkdevs for SCIF and CMT
  ARM: shmobile: Remove non-multiplatform Lager reference support
  ARM: shmobile: Let Lager multiplatform boot with Lager DTB
  ARM: shmobile: Remove Lager reference DTS
  ARM: shmobile: r8a7790: Remove legacy clock aliases for DT devices

 arch/arm/boot/dts/Makefile                     |  4 +-
 arch/arm/boot/dts/r8a7790-lager-reference.dts  | 84 --------------------------
 arch/arm/boot/dts/r8a7790-lager.dts            | 57 +++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                 | 18 +++---
 arch/arm/mach-shmobile/Makefile                |  2 +-
 arch/arm/mach-shmobile/Makefile.boot           |  1 -
 arch/arm/mach-shmobile/board-lager-reference.c | 40 +++++++++++-
 arch/arm/mach-shmobile/clock-r8a7790.c         | 10 ---
 8 files changed, 105 insertions(+), 111 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts

-- 
Regards,

Laurent Pinchart


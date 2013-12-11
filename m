From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 11 Dec 2013 14:13:46 +0000
Subject: [PATCH v4 00/16] Lager and Koelsch multiplatform support
Message-Id: <1386771242-21876-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This is the fourth version of the patch set that moves the lager-reference and
koelsch-reference boards to multiplatform kernel. It starts by syncing the
non-reference DTSes with the reference DTSes (01/16 and 02/16), setting the
external clock frequency in DT (03/16 and 04/16), adding CCF support to the
-reference boards (05/16 to 09/16), and cleaning up unneeded leftovers (10/16
to 16/16).

The net result are multiplatform-only lager-reference and koelsch-reference
boards with a DTSes shared by the reference and non-reference boards.

The code is available in my git tree at

	git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/rcar-gen2-boards

It has been tested on both the Lager and Koelsch boards.

Changes compared to v3:

- Rebase on top of the fourth version of the R-Car Gen2 CCF patches
- Initialize clocks in rcar_gen2_timer_init()

Changes compared to v2:

- Rebase on top of the third version of the R-Car Gen2 CCF patches
- Add Koelsch board multiplatform support

Changes compared to v1:

- Rebase on top of the second version of the r8a7790 CCF patches

Laurent Pinchart (16):
  ARM: shmobile: Sync Lager DTS with Lager reference DTS
  ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS
  ARM: shmobile: lager: Specify external clock frequency in DT
  ARM: shmobile: koelsch: Specify external clock frequency in DT
  ARM: shmobile: rcar-gen2: Initialize CCF before clock sources
  ARM: shmobile: lager-reference: Enable multiplaform kernel support
  ARM: shmobile: koelsch-reference: Remove duplicate CCF initialization
  ARM: shmobile: lager-reference: Instantiate clkdevs for SCIF and CMT
  ARM: shmobile: koelsch-reference: Instantiate clkdevs for SCIF and CMT
  ARM: shmobile: Remove non-multiplatform Lager reference support
  ARM: shmobile: Remove non-multiplatform Koelsch reference support
  ARM: shmobile: Let Lager multiplatform boot with Lager DTB
  ARM: shmobile: Let Koelsch multiplatform boot with Koelsch DTB
  ARM: shmobile: Remove Lager reference DTS
  ARM: shmobile: Remove Koelsch reference DTS
  ARM: shmobile: r8a7790: Remove legacy clock aliases for DT devices

 arch/arm/boot/dts/Makefile                       |  5 +-
 arch/arm/boot/dts/r8a7790-lager-reference.dts    | 89 ------------------------
 arch/arm/boot/dts/r8a7790-lager.dts              | 57 +++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts  | 61 ----------------
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 33 +++++++++
 arch/arm/mach-shmobile/Kconfig                   | 30 +++-----
 arch/arm/mach-shmobile/Makefile                  |  3 +-
 arch/arm/mach-shmobile/Makefile.boot             |  2 -
 arch/arm/mach-shmobile/board-koelsch-reference.c | 30 +++++++-
 arch/arm/mach-shmobile/board-lager-reference.c   | 32 +++++++++
 arch/arm/mach-shmobile/clock-r8a7790.c           | 10 ---
 arch/arm/mach-shmobile/setup-rcar-gen2.c         |  8 ++-
 12 files changed, 168 insertions(+), 192 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts
 delete mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts

-- 
Regards,

Laurent Pinchart


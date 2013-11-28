From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:37 +0000
Subject: [PATCH v3 00/15] Lager and Koelsch multiplatform support
Message-Id: <1385600632-5181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This is the third version of the patch set that moves the lager-reference and
koelsch-reference boards to multiplatform kernel. It starts by syncing the
non-reference DTSes with the reference DTSes (01/15 and 02/15), setting the
external clock frequency in DT (03/15 and 04/15), adding CCF support to the
-reference boards (05/15 to 08/15), and cleaning up unneeded leftovers (09/15
to 15/15).

The net result are multiplatform-only lager-reference and koelsch-reference
boards with a DTSes shared by the reference and non-reference boards.

The code is available in my git tree at

        git://linuxtv.org/pinchartl/fbdev.git clocks/ccf/rcar-gen2-boards

It has been tested on both the Lager and Koelsch boards.

Changes compared to v2:

- Rebase on top of the third version of the R-Car Gen2 CCF patches
- Add Koelsch board multiplatform support

Changes compared to v1:

- Rebase on top of the second version of the r8a7790 CCF patches

Laurent Pinchart (15):
  ARM: shmobile: Sync Lager DTS with Lager reference DTS
  ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS
  ARM: shmobile: lager: Specify external clock frequency in DT
  ARM: shmobile: koelsch: Specify external clock frequency in DT
  ARM: shmobile: lager-reference: Switch to multiplaform
  ARM: shmobile: koelsch-reference: Initialize CPG device
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
 arch/arm/boot/dts/r8a7790-lager-reference.dts    | 84 ------------------------
 arch/arm/boot/dts/r8a7790-lager.dts              | 57 ++++++++++++++++
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts  | 61 -----------------
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 33 ++++++++++
 arch/arm/mach-shmobile/Kconfig                   | 30 +++------
 arch/arm/mach-shmobile/Makefile                  |  3 +-
 arch/arm/mach-shmobile/Makefile.boot             |  2 -
 arch/arm/mach-shmobile/board-koelsch-reference.c | 41 +++++++++++-
 arch/arm/mach-shmobile/board-lager-reference.c   | 40 ++++++++++-
 arch/arm/mach-shmobile/clock-r8a7790.c           | 10 ---
 11 files changed, 177 insertions(+), 189 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts
 delete mode 100644 arch/arm/boot/dts/r8a7791-koelsch-reference.dts

-- 
Regards,

Laurent Pinchart


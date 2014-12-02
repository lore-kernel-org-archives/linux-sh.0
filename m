From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 02 Dec 2014 16:35:41 +0000
Subject: [PATCH 0/5] R-Car Gen2 removal and cleanups
Message-Id: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series remove the Lager legacy and reference board files from the
kernel. It builds upon two patches previously posted by Magnus and updated to
removal left-overs.

The rationale for the change, beside keeping the ARM SoC maintainers happy, is
that the Lager board is now correctly supported using DT boot and generic code
only, so there's no reason to keep board files along.

The second reason to repost the patches is to include a pet peeve of mine that
I've been carrying in my local branches for too long. The last two patches
update the Lager and Koelsch DT files to finally rename the two serial ports
to ttySC0 and ttySC1.

The patches are targeted at v3.20, as they depend on the "ARM: shmobile:
lager: Remove DU platform device" patch scheduled for merge in v3.19-rc1
through the DRM tree.

Laurent Pinchart (3):
  ARM: shmobile: r8a7790: Remove legacy code
  ARM: shmobile: lager: Rename SCIFA[01] serial ports to ttySC[01]
  ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]

Magnus Damm (2):
  ARM: shmobile: lager-reference: DTS-only board support
  ARM: shmobile: lager: Remove legacy board support

 MAINTAINERS                                    |   1 -
 arch/arm/boot/dts/Makefile                     |   1 -
 arch/arm/boot/dts/r8a7790-lager.dts            |   6 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts          |   4 +-
 arch/arm/configs/lager_defconfig               | 150 -----
 arch/arm/configs/shmobile_defconfig            |   1 -
 arch/arm/mach-shmobile/Kconfig                 |  20 -
 arch/arm/mach-shmobile/Makefile                |   3 -
 arch/arm/mach-shmobile/Makefile.boot           |   1 -
 arch/arm/mach-shmobile/board-lager-reference.c |  39 --
 arch/arm/mach-shmobile/board-lager.c           | 827 -------------------------
 arch/arm/mach-shmobile/clock-r8a7790.c         | 459 --------------
 arch/arm/mach-shmobile/r8a7790.h               |  28 -
 arch/arm/mach-shmobile/setup-r8a7790.c         | 284 +--------
 14 files changed, 6 insertions(+), 1818 deletions(-)
 delete mode 100644 arch/arm/configs/lager_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-lager-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-lager.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a7790.c

-- 
Regards,

Laurent Pinchart


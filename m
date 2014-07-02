From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Jul 2014 16:23:35 +0000
Subject: [PATCH 0/3] ARM: shmobile: r7s72100: Remove legacy board support
Message-Id: <1404318218-4732-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Now that all features supported by the Genmai legacy and reference board files
are supported using DT boot on a multiplatform kernel, remove support for the
Genmai board code and legacy (non multiplatform) r7s72100 code.

This patch set is based on top of and depends on the Genmai MTU2 DT patch
("ARM: shmobile: genmai-reference: Enable MTU2 in device tree").

Laurent Pinchart (3):
  ARM: shmobile: r7s72100: genmai: Remove reference board file
  ARM: shmobile: r7s72100: genmai: Remove legacy board file
  ARM: shmobile: r7s72100: Remove legacy board support

 arch/arm/mach-shmobile/Kconfig                  |  17 --
 arch/arm/mach-shmobile/Makefile                 |   3 -
 arch/arm/mach-shmobile/board-genmai-reference.c |  35 ----
 arch/arm/mach-shmobile/board-genmai.c           | 174 ------------------
 arch/arm/mach-shmobile/clock-r7s72100.c         | 231 ------------------------
 arch/arm/mach-shmobile/r7s72100.h               |   6 -
 arch/arm/mach-shmobile/setup-r7s72100.c         |   2 -
 7 files changed, 468 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/board-genmai-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-genmai.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r7s72100.c
 delete mode 100644 arch/arm/mach-shmobile/r7s72100.h

-- 
Regards,

Laurent Pinchart


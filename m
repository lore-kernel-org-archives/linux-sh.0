From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Aug 2015 21:37:14 +0000
Subject: [PATCH 0/3] ARM: shmobile: Remove legacy leftovers
Message-Id: <1440797837-25516-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series removes legacy leftovers related to clock and IRQ support in
non-multiplatform kernels. Please see individual patches for details.

The series is based on Simon's renesas-devel-20150826-v4.2-rc8 tag.

Laurent Pinchart (3):
  pinctrl: sh-pfc: Remove hardcoded IRQ numbers
  ARM: shmobile: Remove legacy mach/irqs.h
  ARM: shmobile: Remove legacy clock support leftovers

 arch/arm/mach-shmobile/common.h            |   2 -
 arch/arm/mach-shmobile/include/mach/irqs.h |  10 ---
 arch/arm/mach-shmobile/irqs.h              |  15 ----
 arch/arm/mach-shmobile/r8a7779.h           |   2 -
 arch/arm/mach-shmobile/setup-r8a7778.c     |   1 -
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c       | 116 ++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c       |  68 ++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c        |  68 ++++++++---------
 drivers/pinctrl/sh-pfc/sh_pfc.h            |   7 +-
 9 files changed, 123 insertions(+), 166 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shmobile/irqs.h

-- 
Regards,

Laurent Pinchart


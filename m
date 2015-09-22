From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Sep 2015 07:08:12 +0000
Subject: [PATCH v2 0/2] ARM: shmobile: Remove legacy leftovers
Message-Id: <1442905694-2317-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch series removes legacy leftovers related to IRQ support in
non-multiplatform kernels. Please see individual patches for details.

The series is based on Simon's renesas-devel-20150914-v4.3-rc1 tag. It should
be queued up  in a tree that has support for the last non-multiplatform
kernels removed.

Laurent Pinchart (2):
  pinctrl: sh-pfc: Remove hardcoded IRQ numbers
  ARM: shmobile: Remove legacy mach/irqs.h

 arch/arm/mach-shmobile/include/mach/irqs.h |  10 ---
 arch/arm/mach-shmobile/irqs.h              |  15 ----
 arch/arm/mach-shmobile/setup-r8a7778.c     |   1 -
 drivers/pinctrl/sh-pfc/gpio.c              |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c       | 116 ++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c       |  64 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c        |  64 ++++++++--------
 drivers/pinctrl/sh-pfc/sh_pfc.h            |   8 +-
 8 files changed, 125 insertions(+), 160 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-shmobile/irqs.h

-- 
Regards,

Laurent Pinchart


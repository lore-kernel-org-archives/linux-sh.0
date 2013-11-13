From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 15:52:50 +0000
Subject: [PATCH v2 0/3] ARM: shmobile: r8a7779/90: Poll MSTP clocks status
Message-Id: <1384357973-27365-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set implements a busy loop to ensure that enabling an MSTP clock
will not return before the clock is actually enabled. The first and third
patches have been previously posted on the linux-sh mailing list, and the
second patch is new. They have been successfully tested on the Marzen board
and on the Lager board where they fix random crashes with the VSP1.

Guennadi Liakhovetski (1):
  ARM: shmobile: wait for MSTP clock status to toggle, when enabling it

Laurent Pinchart (1):
  ARM: shmobile: r8a7779: Wait for status on selected MSTP clocks

Shinya Kuribayashi (1):
  ARM: shmobile: r8a7790: Wait for status on all MSTP clocks

 arch/arm/mach-shmobile/clock-r8a7779.c | 26 ++++------
 arch/arm/mach-shmobile/clock-r8a7790.c | 90 ++++++++++++++++++----------------
 drivers/sh/clk/cpg.c                   | 38 ++++++++++++++
 include/linux/sh_clk.h                 | 19 ++++---
 4 files changed, 109 insertions(+), 64 deletions(-)

-- 
Regards,

Laurent Pinchart


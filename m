From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 29 Oct 2013 17:13:52 +0000
Subject: [PATCH 0/2] ARM: shmobile: r8a7790: Wait for status on all MSTP clocks
Message-Id: <1383066834-25956-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set implements a busy loop to ensure that enabling an MSTP clock
will not return before the clock is actually enabled. The first patch has been
previously posted by Guennadi on the linux-sh mailing list, and the second
patch is new. They have been successfully tested on the Lager board and fix
random crashes with the VSP1.

The series is based on Simon's renesas-devel-20131016 tag.

Guennadi Liakhovetski (1):
  ARM: shmobile: wait for MSTP clock status to toggle, when enabling it

Shinya Kuribayashi (1):
  ARM: shmobile: r8a7790: Wait for status on all MSTP clocks

 arch/arm/mach-shmobile/clock-r8a7790.c | 86 +++++++++++++++++++---------------
 drivers/sh/clk/cpg.c                   | 38 +++++++++++++++
 include/linux/sh_clk.h                 | 19 +++++---
 3 files changed, 97 insertions(+), 46 deletions(-)

-- 
Regards,

Laurent Pinchart


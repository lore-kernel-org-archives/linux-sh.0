From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Dec 2013 15:23:50 +0000
Subject: [PATCH v4 0/3] ARM: shmobile: r8a7779/90: Poll MSTP clocks status
Message-Id: <1387034633-3798-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set implements a busy loop to ensure that enabling an MSTP clock
will not return before the clock is actually enabled. It has successfully been
tested on the Marzen board and on the Lager board where they fix random crashes
with the VSP1.

Simon, could you please apply this for v3.14 ?

Changes since v3:

- Rebased on top of renesas-devel-v3.13-rc3-20131214v2

Changes since v2:

- Don't remove unused MSTPCR registers from 2/3
- Rebased on top of renesas-devel-v3.13-rc1-20131125

Guennadi Liakhovetski (1):
  ARM: shmobile: wait for MSTP clock status to toggle, when enabling it

Laurent Pinchart (1):
  ARM: shmobile: r8a7779: Wait for status on selected MSTP clocks

Shinya Kuribayashi (1):
  ARM: shmobile: r8a7790: Wait for status on all MSTP clocks

 arch/arm/mach-shmobile/clock-r8a7779.c |  20 +++---
 arch/arm/mach-shmobile/clock-r8a7790.c | 115 ++++++++++++++++++---------------
 drivers/sh/clk/cpg.c                   |  38 +++++++++++
 include/linux/sh_clk.h                 |  19 ++++--
 4 files changed, 122 insertions(+), 70 deletions(-)

-- 
Regards,

Laurent Pinchart


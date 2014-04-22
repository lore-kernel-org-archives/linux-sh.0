From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Apr 2014 10:50:41 +0000
Subject: [PATCH v4 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <1398163856-7379-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set switches all Renesas platforms to the new style CMT, MTU2 and
TMU device platform data. All patches have been previously posted as part of
the "[PATCH v3 00/52] Renesas CMT and TMU cleanups" and "[PATCH 00/22] SH
MTU2 DT support" patch series.

This new version just rebases the patches on top of the clockevents branch
that contains the latest driver cleanups, found at

	git://git.linaro.org/people/daniel.lezcano/linux.git clockevents/cmt-mtu2-tmu-cleanups

Simon, could you please pull that branch in your tree and apply this series on
top of it ? Furthermore, as I have other pending patches for the driver side,
could you do so in a separate topic branch that Daniel could merge into his
tree ?

Cc: Simon Horman <horms@verge.net.au>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>

Laurent Pinchart (15):
  sh: Switch to new style CMT device
  ARM: shmobile: sh7372: Switch to new style CMT device
  ARM: shmobile: sh73a0: Switch to new style CMT device
  ARM: shmobile: r8a73a4: Switch to new style CMT device
  ARM: shmobile: r8a7740: Switch to new style CMT device
  ARM: shmobile: r8a7790: Switch to new style CMT device
  ARM: shmobile: r8a7791: Switch to new style CMT device
  sh: Switch to new style TMU device
  ARM: shmobile: sh7372: Switch to new style TMU device
  ARM: shmobile: sh73a0: Switch to new style TMU device
  ARM: shmobile: r8a7740: Switch to new style TMU device
  ARM: shmobile: r8a7778: Switch to new style TMU device
  ARM: shmobile: r8a7779: Switch to new style TMU device
  sh: Switch to new style MTU2 device
  ARM: shmobile: r7s72100: Switch to new style MTU2 device

 arch/arm/mach-shmobile/board-koelsch-reference.c |   2 +-
 arch/arm/mach-shmobile/board-lager-reference.c   |   2 +-
 arch/arm/mach-shmobile/clock-r7s72100.c          |   2 +-
 arch/arm/mach-shmobile/clock-r8a73a4.c           |   2 +-
 arch/arm/mach-shmobile/clock-r8a7740.c           |  10 +-
 arch/arm/mach-shmobile/clock-r8a7778.c           |   4 +-
 arch/arm/mach-shmobile/clock-r8a7779.c           |   4 +-
 arch/arm/mach-shmobile/clock-r8a7790.c           |   2 +-
 arch/arm/mach-shmobile/clock-r8a7791.c           |   2 +-
 arch/arm/mach-shmobile/clock-sh7372.c            |   9 +-
 arch/arm/mach-shmobile/clock-sh73a0.c            |   5 +-
 arch/arm/mach-shmobile/setup-r7s72100.c          |  26 +-
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  17 +-
 arch/arm/mach-shmobile/setup-r8a7740.c           | 133 ++--------
 arch/arm/mach-shmobile/setup-r8a7778.c           |  30 +--
 arch/arm/mach-shmobile/setup-r8a7779.c           |  66 +----
 arch/arm/mach-shmobile/setup-r8a7790.c           |  17 +-
 arch/arm/mach-shmobile/setup-r8a7791.c           |  17 +-
 arch/arm/mach-shmobile/setup-sh7372.c            |  89 ++-----
 arch/arm/mach-shmobile/setup-sh73a0.c            |  92 ++-----
 arch/sh/kernel/cpu/clock-cpg.c                   |  10 +-
 arch/sh/kernel/cpu/sh2/setup-sh7619.c            |  66 +----
 arch/sh/kernel/cpu/sh2a/clock-sh7264.c           |   4 +-
 arch/sh/kernel/cpu/sh2a/clock-sh7269.c           |   4 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c              |  98 +-------
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c           |  98 +-------
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c           | 133 ++--------
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c           | 164 ++-----------
 arch/sh/kernel/cpu/sh2a/setup-sh7264.c           | 140 ++---------
 arch/sh/kernel/cpu/sh2a/setup-sh7269.c           | 133 ++--------
 arch/sh/kernel/cpu/sh3/setup-sh7705.c            |  78 +-----
 arch/sh/kernel/cpu/sh3/setup-sh770x.c            |  78 +-----
 arch/sh/kernel/cpu/sh3/setup-sh7710.c            |  78 +-----
 arch/sh/kernel/cpu/sh3/setup-sh7720.c            | 228 ++---------------
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c           |  78 +-----
 arch/sh/kernel/cpu/sh4/setup-sh7750.c            | 138 ++---------
 arch/sh/kernel/cpu/sh4/setup-sh7760.c            |  78 +-----
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c           |   2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c           |   6 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c           |  10 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c           |  10 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7734.c           |  12 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c           |   4 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c           |   8 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c           |  16 +-
 arch/sh/kernel/cpu/sh4a/clock-shx3.c             |   8 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c           |  96 +-------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c           |  96 +-------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c           |  96 +-------
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c           | 172 ++-----------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c           | 173 ++-----------
 arch/sh/kernel/cpu/sh4a/setup-sh7734.c           | 235 ++----------------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c           |  48 +---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c           | 154 +-----------
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c           | 230 ++---------------
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c           | 154 +-----------
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c           | 154 +-----------
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c           | 299 ++---------------------
 arch/sh/kernel/cpu/sh4a/setup-shx3.c             | 150 +-----------
 arch/sh/kernel/cpu/sh5/setup-sh5.c               |  79 +-----
 61 files changed, 554 insertions(+), 3797 deletions(-)

-- 
Regards,

Laurent Pinchart


From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 08 Mar 2013 08:20:16 +0000
Subject: [PATCH 0/4] clocksource: Set initcall level to subsys
Message-Id: <1362730820-25417-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This small series updates the innitcall level of the
CMT, TMU, MTU2 and STI clock source drivers from module init
to subsys.

This came up as a problem with using CMT as a clock source kzm9g-reference
which does not make use of early timers or devices. In that scenario
initialisation of SDHI and MMCIF both stall on msleep() calls due to the
absence of a initialised clock source.

The purpose of changing the TMU, MTU2 and STI drivers is to keep their
source in sync with the CMT source.

I have boot tested the CMT, TMU and STI changes as noted in their
change logs.

I have only compile tested the MTU2 change as I do not believe that
I have access to a board that uses that driver.

Simon Horman (4):
  clocksource: sh_cmt: Set initcall level to subsys
  clocksource: sh_tmu: Set initcall level to subsys
  clocksource: em_sti: Set initcall level to subsys
  clocksource: sh_mtu2: Set initcall level to subsys

 drivers/clocksource/em_sti.c  |   13 ++++++++++++-
 drivers/clocksource/sh_cmt.c  |    2 +-
 drivers/clocksource/sh_mtu2.c |    2 +-
 drivers/clocksource/sh_tmu.c  |    2 +-
 4 files changed, 15 insertions(+), 4 deletions(-)

-- 
1.7.10.4


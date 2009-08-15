From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 15 Aug 2009 02:53:07 +0000
Subject: [PATCH 00/04] sh: CONFIG_SUSPEND fixes for 2.6.31
Message-Id: <20090815025307.8125.50234.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: CONFIG_SUSPEND fixes for 2.6.31

[PATCH 01/04] sh: skip disabled LCDC channels
[PATCH 02/04] sh: CMT suspend/resume
[PATCH 03/04] sh: use in-soc KEYSC on se7724
[PATCH 04/04] sh: sh7724 ddr self-refresh changes  

These patches fix suspend-to-ram issues found in 2.6.31-rc. All
are needed for proper suspend/resume support on Solution Engine 7724.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-se/7724/setup.c |    9 ++--
 arch/sh/kernel/cpu/shmobile/sleep.S |   70 ++++++++++++++++++++++++++++++++++-
 drivers/clocksource/sh_cmt.c        |   28 ++++++++++++++
 drivers/video/sh_mobile_lcdcfb.c    |    5 ++
 4 files changed, 106 insertions(+), 6 deletions(-)

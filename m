From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 13:59:46 +0000
Subject: [PATCH 00/07] SuperH clkdev rework round 1
Message-Id: <20100510140052.32745.71055.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH clkdev rework round 1

[PATCH 01/07] sh: hwblk index rework
[PATCH 02/07] sh: scif and tmu clkdev changes
[PATCH 03/07] sh: tie in hwblk clocks using clkdev
[PATCH 04/07] sh: allow registering clocks without name
[PATCH 05/07] sh: get rid of hwblk clock names
[PATCH 06/07] sh: tie in div6 clocks using clkdev
[PATCH 07/07] sh: get rid of div6 clock names

These patches contain the first part of the clkdev rework
for SH. In this round hwblk and div6 clocks are converted.

Next round will convert div4 / mstp32 / main clocks.

Finally there will be patches to share the clock framework 
between the SH architecture and SH-Mobile ARM processors.

Tested on Ecovec.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   11 -
 arch/sh/include/asm/hwblk.h            |   14 -
 arch/sh/kernel/cpu/clock.c             |    7 
 arch/sh/kernel/cpu/hwblk.c             |    5 
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   20 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   20 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |  140 ++++++++++++-----
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |  222 ++++++++++++++++++---------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |  261 ++++++++++++++++++++------------
 9 files changed, 470 insertions(+), 230 deletions(-)

From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 04:59:33 +0000
Subject: [PATCH 00/09] SuperH clkdev rework round 2
Message-Id: <20100511045933.26302.37116.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH clkdev rework round 2

[PATCH 01/09] sh: sh7343 mstp32 index rework
[PATCH 02/09] sh: sh7343 mstp32 clkdev lookup 
[PATCH 03/09] sh: sh7366 mstp32 index rework
[PATCH 04/09] sh: sh7366 mstp32 clkdev lookup 
[PATCH 05/09] sh: sh7785 mstp32 index rework
[PATCH 06/09] sh: sh7785 mstp32 clkdev lookup 
[PATCH 07/09] sh: sh7786 mstp32 index rework
[PATCH 08/09] sh: sh7786 mstp32 clkdev lookup 
[PATCH 09/09] sh: get rid of mstp32 clock name and id

These patches contain the second part of the clkdev rework
for SH. In this round mstp32 clocks are converted. The first
8 patches are broken as two patches per processor. The final
patch changes a header file and modifies code for all cpus.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   15 -
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |  257 ++++++++++++++++++++------------
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |  226 +++++++++++++++++-----------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |  153 ++++++++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |  207 ++++++++++++++++---------
 5 files changed, 550 insertions(+), 308 deletions(-)

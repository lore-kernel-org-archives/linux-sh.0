From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 07:05:01 +0000
Subject: [PATCH 00/09] SuperH clkdev rework round 3
Message-Id: <20100511070501.20792.54381.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100511045933.26302.37116.sendpatchset@t400s>
In-Reply-To: <20100511045933.26302.37116.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH clkdev rework round 3

[PATCH 01/09] sh: div4 reparent workaround
[PATCH 02/09] sh: sh7722 div4 clkdev lookup
[PATCH 03/09] sh: sh7723 div4 clkdev lookup
[PATCH 04/09] sh: sh7724 div4 clkdev lookup
[PATCH 05/09] sh: sh7343 div4 clkdev lookup
[PATCH 06/09] sh: sh7366 div4 clkdev lookup
[PATCH 07/09] sh: sh7785 div4 clkdev lookup
[PATCH 08/09] sh: sh7786 div4 clkdev lookup
[PATCH 09/09] sh: get rid of div4 clock name

These patches contain the third part of the clkdev rework
for SH. In this round div4 clocks are converted.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/clock.h            |   15 ++++++--------
 arch/sh/kernel/cpu/clock-cpg.c         |    7 +++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |   30 +++++++++++++++++++----------
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   30 +++++++++++++++++++----------
 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   33 +++++++++++++++++++++-----------
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   33 +++++++++++++++++++++-----------
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   21 +++++++++++++-------
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |   30 +++++++++++++++++++----------
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |   24 +++++++++++++++--------
 9 files changed, 147 insertions(+), 76 deletions(-)


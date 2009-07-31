From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:01:36 +0000
Subject: [PATCH] sh: clean up MSTPCRn register definitions
Message-Id: <20090731070136.28104.85192.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes the unused MSTPCRn register definitions
from the SuperH Mobile code for sh7722, sh7723 and sh7724.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |    3 ---
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |    3 ---
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |    3 ---
 3 files changed, 9 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2009-07-31 15:04:53.000000000 +0900
@@ -32,9 +32,6 @@
 #define SCLKBCR		0xa415000c
 #define IRDACLKCR	0xa4150018
 #define PLLCR		0xa4150024
-#define MSTPCR0		0xa4150030
-#define MSTPCR1		0xa4150034
-#define MSTPCR2		0xa4150038
 #define DLLFRQ		0xa4150050
 
 /* Fixed 32 KHz root clock for RTC and Power Management purposes */
--- 0001/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2009-07-31 15:04:58.000000000 +0900
@@ -32,9 +32,6 @@
 #define SCLKBCR		0xa415000c
 #define IRDACLKCR	0xa4150018
 #define PLLCR		0xa4150024
-#define MSTPCR0		0xa4150030
-#define MSTPCR1		0xa4150034
-#define MSTPCR2		0xa4150038
 #define DLLFRQ		0xa4150050
 
 /* Fixed 32 KHz root clock for RTC and Power Management purposes */
--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2009-07-31 15:05:04.000000000 +0900
@@ -33,9 +33,6 @@
 #define FCLKBCR		0xa415000c
 #define IRDACLKCR	0xa4150018
 #define PLLCR		0xa4150024
-#define MSTPCR0		0xa4150030
-#define MSTPCR1		0xa4150034
-#define MSTPCR2		0xa4150038
 #define SPUCLKCR	0xa415003c
 #define FLLFRQ		0xa4150050
 #define LSTATS		0xa4150060

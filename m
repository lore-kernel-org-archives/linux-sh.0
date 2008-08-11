From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 11 Aug 2008 05:52:46 +0000
Subject: [PATCH] sh: remove MSTPCR defines from Migo-R header file
Message-Id: <20080811055246.19910.85965.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove MSTPCR register definitions from Migo-R header file. The clock
frame work should be used instead of direct register access. 

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/include/asm/migor.h |    3 ---
 1 file changed, 3 deletions(-)

--- 0001/arch/sh/include/asm/migor.h
+++ work/arch/sh/include/asm/migor.h	2008-08-04 19:46:47.000000000 +0900
@@ -42,9 +42,6 @@
 
 #define PORT_MSELCRB 0xa4050182
 
-#define MSTPCR1 0xa4150034
-#define MSTPCR2 0xa4150038
-
 #define PORT_PSELA 0xa405014e
 #define PORT_PSELB 0xa4050150
 #define PORT_PSELC 0xa4050152

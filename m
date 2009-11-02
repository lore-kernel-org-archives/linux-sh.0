From: Roel Kluin <roel.kluin@gmail.com>
Date: Mon, 02 Nov 2009 16:14:42 +0000
Subject: [PATCH] sh: Make sure indexes are positive
Message-Id: <4AEF0572.9020609@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

The indexes are signed, make sure they are not negative
when we read array elements.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 arch/sh/boards/mach-highlander/setup.c |    2 +-
 arch/sh/boards/mach-r2d/irq.c          |    2 +-
 arch/sh/mm/numa.c                      |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Found by code analysis, is this required?

diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index 566e69d..f663c14 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -384,7 +384,7 @@ static unsigned char irl2irq[HL_NR_IRL];
 
 static int highlander_irq_demux(int irq)
 {
-	if (irq >= HL_NR_IRL || !irl2irq[irq])
+	if (irq >= HL_NR_IRL || irq < 0 || !irl2irq[irq])
 		return irq;
 
 	return irl2irq[irq];
diff --git a/arch/sh/boards/mach-r2d/irq.c b/arch/sh/boards/mach-r2d/irq.c
index c70fece..78d7b27 100644
--- a/arch/sh/boards/mach-r2d/irq.c
+++ b/arch/sh/boards/mach-r2d/irq.c
@@ -116,7 +116,7 @@ static unsigned char irl2irq[R2D_NR_IRL];
 
 int rts7751r2d_irq_demux(int irq)
 {
-	if (irq >= R2D_NR_IRL || !irl2irq[irq])
+	if (irq >= R2D_NR_IRL || irq < 0 || !irl2irq[irq])
 		return irq;
 
 	return irl2irq[irq];
diff --git a/arch/sh/mm/numa.c b/arch/sh/mm/numa.c
index 9b784fd..6c52444 100644
--- a/arch/sh/mm/numa.c
+++ b/arch/sh/mm/numa.c
@@ -60,7 +60,7 @@ void __init setup_bootmem_node(int nid, unsigned long start, unsigned long end)
 	unsigned long bootmem_paddr;
 
 	/* Don't allow bogus node assignment */
-	BUG_ON(nid > MAX_NUMNODES || nid = 0);
+	BUG_ON(nid > MAX_NUMNODES || nid <= 0);
 
 	start_pfn = start >> PAGE_SHIFT;
 	end_pfn = end >> PAGE_SHIFT;

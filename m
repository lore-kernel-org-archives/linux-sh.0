From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Mon, 30 May 2011 02:50:58 +0000
Subject: [PATCH] sh: asm/tlb.h needs linux/swap.h
Message-Id: <1306723858-745-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

By commit 1e56a56410bb64bce62d44563e35a143fc2d515f, mmu_gather of sh
was reworked. But this forgot include linux/swap.h in asm/tlb.h.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
CC: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 arch/sh/include/asm/tlb.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/tlb.h b/arch/sh/include/asm/tlb.h
index 6c308d8..ec88bfc 100644
--- a/arch/sh/include/asm/tlb.h
+++ b/arch/sh/include/asm/tlb.h
@@ -9,6 +9,7 @@
 #include <linux/pagemap.h>
 
 #ifdef CONFIG_MMU
+#include <linux/swap.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
-- 
1.7.5.1


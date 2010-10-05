From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 05 Oct 2010 08:16:08 +0000
Subject: [PATCH] sh: Fix address calculation of Initrd
Message-Id: <1286266568-23206-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/setup.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index f24d0ea..4e27846 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -135,8 +135,9 @@ void __init check_for_initrd(void)
 		goto disable;
 	}
 
-	if (unlikely(start < PAGE_OFFSET)) {
-		pr_err("initrd start < PAGE_OFFSET\n");
+	if (unlikely(start < __MEMORY_START)) {
+		pr_err("initrd start (%08lx) < __MEMORY_START(%x)\n",
+			start, __MEMORY_START);
 		goto disable;
 	}
 
@@ -157,7 +158,7 @@ void __init check_for_initrd(void)
 	/*
 	 * Address sanitization
 	 */
-	initrd_start = (unsigned long)__va(__pa(start));
+	initrd_start = (unsigned long)__va(start);
 	initrd_end = initrd_start + INITRD_SIZE;
 
 	memblock_reserve(__pa(initrd_start), INITRD_SIZE);
-- 
1.7.1


From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Aug 2008 09:21:29 +0000
Subject: [PATCH] sh: fix platform_resource_setup_memory() section mismatch
Message-Id: <20080827092129.9118.7022.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch kills a section mismatch for platform_resource_setup_memory().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/mm/consistent.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/sh/mm/consistent.c
+++ work/arch/sh/mm/consistent.c	2008-08-26 15:14:46.000000000 +0900
@@ -101,7 +101,7 @@ static int __init memchunk_setup(char *s
 }
 __setup("memchunk.", memchunk_setup);
 
-static void memchunk_cmdline_override(char *name, unsigned long *sizep)
+static void __init memchunk_cmdline_override(char *name, unsigned long *sizep)
 {
 	char *p = boot_command_line;
 	int k = strlen(name);
@@ -118,8 +118,8 @@ static void memchunk_cmdline_override(ch
 	}
 }
 
-int platform_resource_setup_memory(struct platform_device *pdev,
-				   char *name, unsigned long memsize)
+int __init platform_resource_setup_memory(struct platform_device *pdev,
+					  char *name, unsigned long memsize)
 {
 	struct resource *r;
 	dma_addr_t dma_handle;

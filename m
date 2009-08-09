From: Marcin Slusarz <marcin.slusarz@gmail.com>
Date: Sun, 09 Aug 2009 19:53:59 +0000
Subject: [PATCH 04/14] sh: use printk_once
Message-Id: <1249847649-11631-5-git-send-email-marcin.slusarz@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
In-Reply-To: <1249847649-11631-1-git-send-email-marcin.slusarz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Signed-off-by: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/mm/ioremap_64.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/sh/mm/ioremap_64.c b/arch/sh/mm/ioremap_64.c
index 828c859..b16843d 100644
--- a/arch/sh/mm/ioremap_64.c
+++ b/arch/sh/mm/ioremap_64.c
@@ -94,7 +94,6 @@ static struct resource *shmedia_find_resource(struct resource *root,
 static void __iomem *shmedia_alloc_io(unsigned long phys, unsigned long size,
 				      const char *name, unsigned long flags)
 {
-	static int printed_full;
 	struct xresource *xres;
 	struct resource *res;
 	char *tack;
@@ -108,11 +107,8 @@ static void __iomem *shmedia_alloc_io(unsigned long phys, unsigned long size,
 		tack = xres->xname;
 		res = &xres->xres;
 	} else {
-		if (!printed_full) {
-			printk(KERN_NOTICE "%s: done with statics, "
+		printk_once(KERN_NOTICE "%s: done with statics, "
 			       "switching to kmalloc\n", __func__);
-			printed_full = 1;
-		}
 		tlen = strlen(name);
 		tack = kmalloc(sizeof(struct resource) + tlen + 1, GFP_KERNEL);
 		if (!tack)
-- 
1.6.3.3


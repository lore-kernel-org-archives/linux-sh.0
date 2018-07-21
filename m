From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 21 Jul 2018 19:37:06 +0000
Subject: [PATCH] mtd: solutionengine.c: fix printk format warnings
Message-Id: <02694f68-7994-d91d-6556-4f29eb284268@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

From: Randy Dunlap <rdunlap@infradead.org>

Fix 2 printk format warnings (this driver is currently SUPERH only)
by using "%pap" instead of "%lx".
(or we could just cast the physical addresses to unsigned int)

Fixes these build warnings:

../drivers/mtd/maps/solutionengine.c: In function 'init_soleng_maps':
../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 2 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
../drivers/mtd/maps/solutionengine.c:62:54: note: format string is defined here
  printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
                                                  ~~~~^
                                                  %08x
../include/linux/kern_levels.h:5:18: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
../drivers/mtd/maps/solutionengine.c:62:72: note: format string is defined here
  printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
                                                                    ~~~~^
                                                                    %08x

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-mtd@lists.infradead.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/mtd/maps/solutionengine.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-next-20180720.orig/drivers/mtd/maps/solutionengine.c
+++ linux-next-20180720/drivers/mtd/maps/solutionengine.c
@@ -59,9 +59,13 @@ static int __init init_soleng_maps(void)
 			return -ENXIO;
 		}
 	}
-	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
-	       soleng_flash_map.phys & 0x1fffffff,
-	       soleng_eprom_map.phys & 0x1fffffff);
+	{
+	resource_size_t fl_phys = soleng_flash_map.phys & 0x1fffffff;
+	resource_size_t ep_phys = soleng_eprom_map.phys & 0x1fffffff;
+
+	printk(KERN_NOTICE "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
+	       &fl_phys, &ep_phys);
+	}
 	flash_mtd->owner = THIS_MODULE;
 
 	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);



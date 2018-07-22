From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 22 Jul 2018 23:28:52 +0000
Subject: [PATCH v2] mtd/maps: fix solutionengine.c printk format warnings
Message-Id: <0ca72308-0551-97dc-dc74-11e1d8dac5b1@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix 2 printk format warnings (this driver is currently only used by
arch/sh/) by using "%pap" instead of "%lx".
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
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: indent all lines inside the new block

 drivers/mtd/maps/solutionengine.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- linux-next-20180717.orig/drivers/mtd/maps/solutionengine.c
+++ linux-next-20180717/drivers/mtd/maps/solutionengine.c
@@ -59,9 +59,14 @@ static int __init init_soleng_maps(void)
 			return -ENXIO;
 		}
 	}
-	printk(KERN_NOTICE "Solution Engine: Flash at 0x%08lx, EPROM at 0x%08lx\n",
-	       soleng_flash_map.phys & 0x1fffffff,
-	       soleng_eprom_map.phys & 0x1fffffff);
+	{
+		resource_size_t fl_phys = soleng_flash_map.phys & 0x1fffffff;
+		resource_size_t ep_phys = soleng_eprom_map.phys & 0x1fffffff;
+
+		printk(KERN_NOTICE
+		       "Solution Engine: Flash at 0x%pap, EPROM at 0x%pap\n",
+	       	       &fl_phys, &ep_phys);
+	}
 	flash_mtd->owner = THIS_MODULE;
 
 	eprom_mtd = do_map_probe("map_rom", &soleng_eprom_map);



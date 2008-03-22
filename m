From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 22 Mar 2008 17:56:32 +0000
Subject: Re: [PATCH] 1/3 mtd: add Kbuild support and makefile support for
Message-Id: <1206208592.6324.19.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1206207805.6324.13.camel@localhost.localdomain>
In-Reply-To: <1206207805.6324.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw2 <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-sh <linux-sh@vger.kernel.org>, Greg KH <greg@kroah.com>, Paul Mundt <lethal@users.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---
diff -ruN a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
--- a/drivers/mtd/maps/Kconfig	2008-03-22 17:26:24.000000000 +0000
+++ b/drivers/mtd/maps/Kconfig	2008-03-22 17:20:45.000000000 +0000
@@ -590,5 +590,19 @@
 
 	  This selection automatically selects the map_ram driver.
 
+config MTD_VMU_FLASH
+	tristate "Dreamcast Visual Memory devices and clones"
+	depends on SH_DREAMCAST
+	select MAPLE
+	help
+	  Flash map driver for the SEGA Dreamcast Visual Memory Unit
+	  and clones.
+
+	  Most Dreamcast users will have one of these and so will want
+	  to say Y here.
+
+	  To compile this driver as a module choose M here: the module
+	  will be called vmu-flash.
+
 endmenu
 
diff -ruN a/drivers/mtd/maps/Makefile b/drivers/mtd/maps/Makefile
--- a/drivers/mtd/maps/Makefile	2008-03-22 17:26:24.000000000 +0000
+++ b/drivers/mtd/maps/Makefile	2008-03-22 17:20:45.000000000 +0000
@@ -68,3 +68,4 @@
 obj-$(CONFIG_MTD_OMAP_NOR)	+= omap_nor.o
 obj-$(CONFIG_MTD_MTX1)		+= mtx-1_flash.o
 obj-$(CONFIG_MTD_INTEL_VR_NOR)	+= intel_vr_nor.o
+obj-$(CONFIG_MTD_VMU_FLASH)	+= vmu_flash.o



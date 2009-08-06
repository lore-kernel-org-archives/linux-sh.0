From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Aug 2009 14:34:38 +0000
Subject: [PATCH] sh: 18-bit SYS panel fix for SuperH Mobile LCDC
Message-Id: <20090806143438.4005.17251.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Fix the SuperH Mobile LCDC driver to make use of the full
18-bit DRD field in the LDDRDR register. Without this patch
only 16-bit register access is possible. Needed by 18-bit
SYS panels such as the one used on kfr2r09.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Tested on Migo-R and kfr2r09. Applies on top of the wait bit fix.

 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0003/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2009-08-06 21:44:44.000000000 +0900
@@ -177,7 +177,7 @@ static unsigned long lcdc_sys_read_data(
 	udelay(1);
 	lcdc_wait_bit(ch->lcdc, _LDSR, 2, 0);
 
-	return lcdc_read(ch->lcdc, _LDDRDR) & 0xffff;
+	return lcdc_read(ch->lcdc, _LDDRDR) & 0x3ffff;
 }
 
 struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {

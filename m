From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 10 Mar 2010 11:33:10 +0000
Subject: [PATCH] video: enable sh_mobile_lcdc on SH-Mobile ARM
Message-Id: <20100310113310.20654.18555.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch enables the sh_mobile_lcdc driver on
SH-Mobile ARM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/video/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2010-03-10 20:12:42.000000000 +0900
@@ -1867,7 +1867,7 @@ config FB_W100
 
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
-	depends on FB && SUPERH && HAVE_CLK
+	depends on FB && (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT

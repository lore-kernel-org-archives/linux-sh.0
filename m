From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Fri, 27 May 2011 23:23:06 +0000
Subject: [PATCH] Subject: shmobile: Fix build of the LCDC driver
Message-Id: <201105280123.06622.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

The shmobile lcdcfb driver fails to build because of the undefined
ret variable in sh_mobile_lcdc_start().  Fix this problem.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Hi,

I don't know whether this is known or not.  In case it isn't,
here's a fix. :-)

Thanks,
Rafael

---
 drivers/video/sh_mobile_lcdcfb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/video/sh_mobile_lcdcfb.c
=================================--- linux-2.6.orig/drivers/video/sh_mobile_lcdcfb.c
+++ linux-2.6/drivers/video/sh_mobile_lcdcfb.c
@@ -616,7 +616,7 @@ static int sh_mobile_lcdc_start(struct s
 			struct sh_mobile_meram_info *mdev;
 			unsigned long icb_addr_y, icb_addr_c;
 			int icb_pitch;
-			int pf;
+			int pf, ret;
 
 			cfg = ch->cfg.meram_cfg;
 			mdev = priv->meram_dev;

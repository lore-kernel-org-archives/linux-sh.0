From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 28 Jul 2008 18:05:13 +0000
Subject: [PATCH] sh7760fb: write colormap value to hardware.
Message-Id: <20080728180513.GA31478@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <486B39E3.60601@renesas.com>
In-Reply-To: <486B39E3.60601@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: Munakata Hisao <munakata.hisao@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linuc-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>

The computed color value is never actually written to hardware
colormap register.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/video/sh7760fb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh7760fb.c b/drivers/video/sh7760fb.c
index 4d0e28c..8d0212d 100644
--- a/drivers/video/sh7760fb.c
+++ b/drivers/video/sh7760fb.c
@@ -152,6 +152,7 @@ static int sh7760fb_setcmap(struct fb_cmap *cmap, struct fb_info *info)
 		col |= ((*g) & 0xff) << 8;
 		col |= ((*b) & 0xff);
 		col &= SH7760FB_PALETTE_MASK;
+		iowrite32(col, par->base + LDPR(s));
 
 		if (s < 16)
 			((u32 *) (info->pseudo_palette))[s] = s;
-- 
1.5.6.3


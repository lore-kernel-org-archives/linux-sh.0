From: Roel Kluin <roel.kluin@gmail.com>
Date: Sun, 18 Jan 2009 19:46:58 +0000
Subject: [PATCH] pvr2fb: test var->xoffset as bool?
Message-Id: <49738732.2020002@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

was this what was intended?
------------8<------------->8------------
Test for negative xoffset

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
index 0a0fd48..5869e6c 100644
--- a/drivers/video/pvr2fb.c
+++ b/drivers/video/pvr2fb.c
@@ -460,7 +460,7 @@ static int pvr2fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 	set_color_bitfields(var);
 
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->xoffset || var->yoffset < 0 ||
+		if (var->xoffset < 0 || var->yoffset < 0 ||
 		    var->yoffset >= var->yres_virtual) {
 			var->xoffset = var->yoffset = 0;
 		} else {

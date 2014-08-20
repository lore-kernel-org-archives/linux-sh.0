From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 20 Aug 2014 19:12:54 +0000
Subject: [PATCH resend] rcar_vin: fix error message in rcar_vin_get_formats()
Message-Id: <1487353.2gPEFjuLHa@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <2757286.QhObRprPE4@wasted.cogentembedded.com>
In-Reply-To: <2757286.QhObRprPE4@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de, m.chehab@samsung.com, linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The dev_err() call is supposed to output <width>x<height> in decimal but one of
the format specifiers is "%x" instead of "%u" (most probably due  to a typo).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'media_tree.git' repo's 'fixes' branch.
Resending with Mauro's current address (again)...

 drivers/media/platform/soc_camera/rcar_vin.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: media_tree/drivers/media/platform/soc_camera/rcar_vin.c
=================================--- media_tree.orig/drivers/media/platform/soc_camera/rcar_vin.c
+++ media_tree/drivers/media/platform/soc_camera/rcar_vin.c
@@ -981,7 +981,7 @@ static int rcar_vin_get_formats(struct s
 
 		if (shift = 3) {
 			dev_err(dev,
-				"Failed to configure the client below %ux%x\n",
+				"Failed to configure the client below %ux%u\n",
 				mf.width, mf.height);
 			return -EIO;
 		}

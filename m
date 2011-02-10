From: Alexandre Courbot <gnurou@gmail.com>
Date: Thu, 10 Feb 2011 15:22:46 +0000
Subject: [PATCH 2/2] sh: mach-ecovec24: support for main lcd backlight
Message-Id: <1297351366-7374-3-git-send-email-gnurou@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Alexandre Courbot <gnurou@gmail.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 701667a..6d316f6 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -261,6 +261,11 @@ const static struct fb_videomode ecovec_dvi_modes[] = {
 	},
 };
 
+static struct sh_mobile_lcdc_bl_info lcdc_bl_info = {
+	.name = "sh_mobile_mainlcd_bl",
+	.gpio = GPIO_PTR1,
+};
+
 static struct sh_mobile_lcdc_info lcdc_info = {
 	.ch[0] = {
 		.interface_type = RGB18,
@@ -272,6 +277,7 @@ static struct sh_mobile_lcdc_info lcdc_info = {
 		},
 		.board_cfg = {
 		},
+		.bl_info = &lcdc_bl_info,
 	}
 };
 
-- 
1.7.4


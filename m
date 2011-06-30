From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Jun 2011 07:30:55 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: ag5evm: fixup compile error caused by i2c function
Message-Id: <87iprn4vyr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101119131112.45efa0dc.yoshii.takashi@gmail.com>
In-Reply-To: <20101119131112.45efa0dc.yoshii.takashi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ag5evm compile will be error if it doesn't have CONFIG_I2C.
this patch fixup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 9761f80..1351c99 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -205,6 +205,7 @@ static struct platform_device irda_device = {
 	.num_resources  = ARRAY_SIZE(irda_resources),
 };
 
+#ifdef CONFIG_I2C
 static unsigned char lcd_backlight_seq[3][2] = {
 	{ 0x04, 0x07 },
 	{ 0x23, 0x80 },
@@ -227,6 +228,9 @@ static void lcd_backlight_on(void)
 			break;
 	}
 }
+#else
+#define lcd_backlight_on()
+#endif
 
 static void lcd_backlight_reset(void)
 {
-- 
1.7.4.1


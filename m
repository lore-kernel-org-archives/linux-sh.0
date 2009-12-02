From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 02 Dec 2009 09:35:42 +0000
Subject: [PATCH] sh: mach-ecovec24: LCDC drive ability become high
Message-Id: <uk4x5zpjl.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Drive ability for LCDC become high for safety,
became there is strange individual specificity board in mass production

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 0dd98ed..826e623 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -666,8 +666,8 @@ static int __init arch_setup(void)
 	gpio_direction_output(GPIO_PTR1, 0);
 	gpio_direction_output(GPIO_PTA2, 0);
 
-	/* I/O buffer drive ability is low */
-	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x00c0) | 0x0040 , IODRIVEA);
+	/* I/O buffer drive ability is high */
+	ctrl_outw((ctrl_inw(IODRIVEA) & ~0x00c0) | 0x0080 , IODRIVEA);
 
 	if (gpio_get_value(GPIO_PTE6)) {
 		/* DVI */
-- 
1.6.3.3


From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 03 Dec 2010 05:37:54 +0000
Subject: [PATCH] sh: se/7724: Remove FSI/B of GPIO init code
Message-Id: <1291354674-13100-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

se7724 board does not have FSI/B.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index 1486ab7..527a0cd 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -827,22 +827,14 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_KEYOUT0,     NULL);
 
 	/* enable FSI */
-	gpio_request(GPIO_FN_FSIMCKB,    NULL);
 	gpio_request(GPIO_FN_FSIMCKA,    NULL);
+	gpio_request(GPIO_FN_FSIIASD,    NULL);
 	gpio_request(GPIO_FN_FSIOASD,    NULL);
 	gpio_request(GPIO_FN_FSIIABCK,   NULL);
 	gpio_request(GPIO_FN_FSIIALRCK,  NULL);
 	gpio_request(GPIO_FN_FSIOABCK,   NULL);
 	gpio_request(GPIO_FN_FSIOALRCK,  NULL);
 	gpio_request(GPIO_FN_CLKAUDIOAO, NULL);
-	gpio_request(GPIO_FN_FSIIBSD,    NULL);
-	gpio_request(GPIO_FN_FSIOBSD,    NULL);
-	gpio_request(GPIO_FN_FSIIBBCK,   NULL);
-	gpio_request(GPIO_FN_FSIIBLRCK,  NULL);
-	gpio_request(GPIO_FN_FSIOBBCK,   NULL);
-	gpio_request(GPIO_FN_FSIOBLRCK,  NULL);
-	gpio_request(GPIO_FN_CLKAUDIOBO, NULL);
-	gpio_request(GPIO_FN_FSIIASD,    NULL);
 
 	/* set SPU2 clock to 83.4 MHz */
 	clk = clk_get(NULL, "spu_clk");
-- 
1.7.2.3


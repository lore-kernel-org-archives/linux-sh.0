From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 14 Sep 2009 11:22:31 +0000
Subject: [PATCH] sh: USB1 disable process in boot for EcoVec24
Message-Id: <u3a6pg494.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


This patch prevent USB1 interrupt immediately after re-boot

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 4d6d588..2129e4c 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -449,6 +449,7 @@ static int __init arch_setup(void)
 
 	/* enable USB */
 	ctrl_outw(0x0000, 0xA4D80000);
+	ctrl_outw(0x0000, 0xA4D90000);
 	gpio_request(GPIO_PTB3,  NULL);
 	gpio_request(GPIO_PTB4,  NULL);
 	gpio_request(GPIO_PTB5,  NULL);
-- 
1.6.0.4


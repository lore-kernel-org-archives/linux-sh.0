From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 10 Sep 2009 01:40:00 +0000
Subject: [PATCH 4/6] sh: EcoVec24: add HIZA setting for LED
Message-Id: <uocpjy3v3.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 620a6d7..3632f41 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -428,6 +428,7 @@ static int __init arch_setup(void)
 	gpio_direction_output(GPIO_PTG1, 0);
 	gpio_direction_output(GPIO_PTG2, 0);
 	gpio_direction_output(GPIO_PTG3, 0);
+	ctrl_outw((ctrl_inw(PORT_HIZA) & ~(0x1 << 1)) , PORT_HIZA);
 
 	/* enable SH-Eth */
 	gpio_request(GPIO_PTA1, NULL);
-- 
1.6.0.4


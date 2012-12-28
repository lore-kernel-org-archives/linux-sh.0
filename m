From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:53:48 +0000
Subject: [PATCH v4 06/81] sh: sh7786: Fix last GPIO index
Message-Id: <1356735303-29474-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A careless look at the code shows that the last entry in the
pinmux_gpios seems to be GPIO_FN_FSE. However, entries are ordered by
the GPIO number, as the PINMUX_GPIO macro is expended to an indexed
array initializer. The last entry in the array is thus GPIO_FN_IRL4. Set
the pinmux_info last_gpio field accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
index c24a777..60df99c 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-sh7786.c
@@ -825,7 +825,7 @@ static struct pinmux_info sh7786_pinmux_info = {
 	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 
 	.first_gpio = GPIO_PA7,
-	.last_gpio = GPIO_FN_FSE,
+	.last_gpio = GPIO_FN_IRL4,
 
 	.gpios = pinmux_gpios,
 	.cfg_regs = pinmux_config_regs,
-- 
1.7.8.6


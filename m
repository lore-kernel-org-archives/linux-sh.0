From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:53:49 +0000
Subject: [PATCH v4 07/81] sh: shx3: Fix last GPIO index
Message-Id: <1356735303-29474-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A careless look at the code shows that the last entry in the
pinmux_gpios seems to be GPIO_FN_IRQOUT. However, entries are ordered by
the GPIO number, as the PINMUX_GPIO macro is expended to an indexed
array initializer. The last entry in the array is thus GPIO_FN_STATUS0.
Set the pinmux_info last_gpio field accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/kernel/cpu/sh4a/pinmux-shx3.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
index aaa5338..2ebb983 100644
--- a/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/pinmux-shx3.c
@@ -572,7 +572,7 @@ static struct pinmux_info shx3_pinmux_info = {
 	.mark		= { PINMUX_MARK_BEGIN,     PINMUX_MARK_END },
 	.function	= { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
 	.first_gpio	= GPIO_PA7,
-	.last_gpio	= GPIO_FN_IRQOUT,
+	.last_gpio	= GPIO_FN_STATUS0,
 	.gpios		= shx3_pinmux_gpios,
 	.gpio_data	= shx3_pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(shx3_pinmux_data),
-- 
1.7.8.6


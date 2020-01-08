From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 08 Jan 2020 19:45:20 +0000
Subject: [PATCH] sh: sh4a: Remove unused tmu3_device
Message-Id: <20200108194520.3341-1-krzk@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>

Remove left-over from previous cleanups to silence the warning:

    arch/sh/kernel/cpu/sh4a/setup-sh7786.c:243:31:
        warning: ‘tmu3_device’ defined but not used [-Wunused-variable]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 4b0db8259e3d..22d1c38f742f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -229,27 +229,6 @@ static struct platform_device tmu2_device = {
 	.num_resources	= ARRAY_SIZE(tmu2_resources),
 };
 
-static struct sh_timer_config tmu3_platform_data = {
-	.channels_mask = 7,
-};
-
-static struct resource tmu3_resources[] = {
-	DEFINE_RES_MEM(0xffde0000, 0x2c),
-	DEFINE_RES_IRQ(evt2irq(0x7c0)),
-	DEFINE_RES_IRQ(evt2irq(0x7c0)),
-	DEFINE_RES_IRQ(evt2irq(0x7c0)),
-};
-
-static struct platform_device tmu3_device = {
-	.name		= "sh-tmu",
-	.id		= 3,
-	.dev = {
-		.platform_data	= &tmu3_platform_data,
-	},
-	.resource	= tmu3_resources,
-	.num_resources	= ARRAY_SIZE(tmu3_resources),
-};
-
 static const struct sh_dmae_channel dmac0_channels[] = {
 	{
 		.offset = 0,
-- 
2.17.1

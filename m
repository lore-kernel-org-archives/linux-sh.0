From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:17:31 +0000
Subject: [PATCH 5/7] ARM: shmobile: kzm9g: Use of_machine_is_compatible()
Message-Id: <1359080253-30995-6-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359080253-30995-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The machine number is hardcoded to ~0 on DT-enabled machines, making
machine_is_*() always fail when support for more than one machine is
compiled into the kernel. Replace the machine_is_kzm9g() call with
of_machine_is_compatible("renesas,kzm9g").

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index c02448d..eadf309 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -623,7 +623,7 @@ static int __init as3711_enable_lcdc_backlight(void)
 		0x45, 0xf0,
 	};
 
-	if (!machine_is_kzm9g())
+	if (!of_machine_is_compatible("renesas,kzm9g"))
 		return 0;
 
 	if (!a)
-- 
1.7.10.4


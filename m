From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 04 Oct 2013 08:20:07 +0000
Subject: [PATCH] ARM: shmobile: ape6evm: fix incorrect placement of __initdata tag
Message-Id: <40fca03cae59cfd9b87142ca327abb8a4d386908.1380874512.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1380874512.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1380874512.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

__initdata tag should be placed between the variable name and equal
sign for the variable to be placed in the intended .init.data section.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 24b87eea..00e3add 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -86,7 +86,7 @@ static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_VOLUMEDOWN,	329,	"S21"),
 };
 
-static struct __initdata gpio_keys_platform_data ape6evm_keys_pdata = {
+static struct gpio_keys_platform_data ape6evm_keys_pdata __initdata = {
 	.buttons	= gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
-- 
1.8.4


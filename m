From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Jan 2012 11:14:07 +0000
Subject: [PATCH] ARM: mach-shmobile: IRQ driven GPIO key support for Kota2
Message-Id: <20120117111407.5451.17918.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Now when GPIO IRQs are supported on sh73a0 modify the Kota2
board code to switch from the polled "gpio-keys-polled" driver
to the IRQ driven "gpio-keys" driver.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-kota2.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-kota2.c
+++ work/arch/arm/mach-shmobile/board-kota2.c	2012-01-17 20:00:13.000000000 +0900
@@ -143,11 +143,10 @@ static struct gpio_keys_button gpio_butt
 static struct gpio_keys_platform_data gpio_key_info = {
 	.buttons        = gpio_buttons,
 	.nbuttons       = ARRAY_SIZE(gpio_buttons),
-	.poll_interval  = 250, /* polled for now */
 };
 
 static struct platform_device gpio_keys_device = {
-	.name   = "gpio-keys-polled", /* polled for now */
+	.name   = "gpio-keys",
 	.id     = -1,
 	.dev    = {
 		.platform_data  = &gpio_key_info,

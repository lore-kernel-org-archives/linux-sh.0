From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Tue, 26 Dec 2017 06:47:40 +0000
Subject: [PATCH 05/11 v2] sh: mach-rsk: rsk7203: constify gpio_led
Message-Id: <cc2baa7e8f144e1ba8b1a2e83b8e836095cf3d3e.1514267721.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <de0879ef47b96776e3f18a1889c41d976a677b21.1514267721.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nsekhar@ti.com, khilman@kernel.org, linux@armlinux.org.uk, kaloz@openwrt.org, khalasa@piap.pl, aaro.koskinen@iki.fi, tony@atomide.com, jason@lakedaemon.net, andrew@lunn.ch, sebastian.hesselbarth@gmail.com, gregory.clement@free-electrons.com, daniel@zonque.org, haojian.zhuang@gmail.com, marek.vasut@gmail.com, slapin@ossfans.org, jic23@cam.ac.uk, kgene@kernel.org, krzk@kernel.org, ralf@linux-mips.org, ysato@users.sourceforge.jp, dalias@libc.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

gpio_led are not supposed to change at runtime.
struct gpio_led_platform_data working with const gpio_led
provided by <linux/leds.h>. So mark the non-const structs
as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
              The GPIO LED driver can be built as a module, it can
              be loaded after the init sections have gone away.
              So removed '__initconst'.

 arch/sh/boards/mach-rsk/devices-rsk7203.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
index a8089f7..6676c0e 100644
--- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
+++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
@@ -50,7 +50,7 @@ static struct platform_device smsc911x_device = {
 	},
 };
 
-static struct gpio_led rsk7203_gpio_leds[] = {
+static const struct gpio_led rsk7203_gpio_leds[] = {
 	{
 		.name			= "green",
 		.gpio			= GPIO_PE10,
-- 
2.7.4


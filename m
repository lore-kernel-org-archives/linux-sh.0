From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 16:12:03 +0000
Subject: [PATCH 3/4] ARM: shmobile: ape6evm: use smsc911x platform parameters to handle eth reset
Message-Id: <1374595924-12338-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Steve Glendinning <steve.glendinning@shawell.net>, netdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Instead of fixing ethernet reset GPIO in platform initialisation code, pass
the GPIO to the driver.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 96a6994..bd46c75 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -56,6 +56,8 @@ static const struct smsc911x_platform_config lan9220_data = {
 	.flags		= SMSC911X_USE_32BIT,
 	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
 	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_HIGH,
+	.reset_gpio	= 270,
+	.reset_gpio_config = SMSC911X_RESET_GPIO_VALID | GPIOF_INIT_LOW,
 };
 
 /*
@@ -156,9 +158,6 @@ static void __init ape6evm_add_standard_devices(void)
 	r8a73a4_pinmux_init();
 	r8a73a4_add_standard_devices();
 
-	/* LAN9220 ethernet */
-	gpio_request_one(270, GPIOF_OUT_INIT_HIGH, NULL); /* smsc9220 RESET */
-
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
 	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
-- 
1.7.2.5


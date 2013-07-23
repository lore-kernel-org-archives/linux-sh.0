From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 16:12:02 +0000
Subject: [PATCH 2/4] net: smsc911x: add a reset GPIO DT binding
Message-Id: <1374595924-12338-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374595924-12338-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Steve Glendinning <steve.glendinning@shawell.net>, netdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>, devicetree@vger.kernel.org

Add a new DT property to specify a reset GPIO.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/net/smsc911x.txt |    1 +
 drivers/net/ethernet/smsc/smsc911x.c               |   11 +++++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/smsc911x.txt b/Documentation/devicetree/bindings/net/smsc911x.txt
index adb5b57..2bf32be 100644
--- a/Documentation/devicetree/bindings/net/smsc911x.txt
+++ b/Documentation/devicetree/bindings/net/smsc911x.txt
@@ -23,6 +23,7 @@ Optional properties:
   external PHY
 - smsc,save-mac-address : Indicates that mac address needs to be saved
   before resetting the controller
+- smsc,reset-gpios : a GPIO binding to take the controller out of reset
 - local-mac-address : 6 bytes, mac address
 
 Examples:
diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index ca01c03..db6255e 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2328,6 +2328,8 @@ static int smsc911x_probe_config_dt(struct smsc911x_platform_config *config,
 {
 	const char *mac;
 	u32 width = 0;
+	enum of_gpio_flags flags;
+	int gpio;
 
 	if (!np)
 		return -ENODEV;
@@ -2361,6 +2363,15 @@ static int smsc911x_probe_config_dt(struct smsc911x_platform_config *config,
 	if (of_get_property(np, "smsc,save-mac-address", NULL))
 		config->flags |= SMSC911X_SAVE_MAC_ADDRESS;
 
+	gpio = of_get_named_gpio_flags(np, "smsc,reset-gpios", 0, &flags);
+	if (gpio = -EPROBE_DEFER)
+		return gpio;
+	if (gpio_is_valid(gpio)) {
+		config->reset_gpio = gpio;
+		config->reset_gpio_config = SMSC911X_RESET_GPIO_VALID |
+			(flags & OF_GPIO_ACTIVE_LOW ? GPIOF_INIT_LOW : GPIOF_INIT_HIGH);
+	}
+
 	return 0;
 }
 #else
-- 
1.7.2.5


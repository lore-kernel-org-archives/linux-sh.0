From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 19 Oct 2015 14:07:39 +0000
Subject: [PATCH/RFT 6/7] media: adv7604: automatic "default-input" selection
Message-Id: <1445263660-6945-7-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: William Towle <william.towle@codethink.co.uk>

Add logic such that the "default-input" property becomes unnecessary
for chips that only have one suitable input (ADV7611 by design, and
ADV7612 due to commit 7111cddd "[media] media: adv7604: reduce support
to first (digital) input").

Additionally, Ian's documentation in commit bf9c8227 ("[media] media:
adv7604: ability to read default input port from DT") states that the
"default-input" property should reside directly in the node for
adv7612. Hence, also adjust the parsing to make the implementation
consistent with this.

Signed-off-by: William Towle <william.towle@codethink.co.uk>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/media/i2c/adv7604.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/adv7604.c b/drivers/media/i2c/adv7604.c
index 5631ec0..5bd81bd 100644
--- a/drivers/media/i2c/adv7604.c
+++ b/drivers/media/i2c/adv7604.c
@@ -2799,7 +2799,7 @@ static int adv76xx_parse_dt(struct adv76xx_state *state)
 	struct device_node *endpoint;
 	struct device_node *np;
 	unsigned int flags;
-	u32 v;
+	u32 v= -1;
 
 	np = state->i2c_clients[ADV76XX_PAGE_IO]->dev.of_node;
 
@@ -2809,14 +2809,25 @@ static int adv76xx_parse_dt(struct adv76xx_state *state)
 		return -EINVAL;
 
 	v4l2_of_parse_endpoint(endpoint, &bus_cfg);
-
-	if (!of_property_read_u32(endpoint, "default-input", &v))
-		state->pdata.default_input = v;
-	else
-		state->pdata.default_input = -1;
-
 	of_node_put(endpoint);
 
+	if (of_property_read_u32(np, "default-input", &v)) {
+		/* not specified ... can we choose automatically? */
+		switch (state->info->type) {
+		case ADV7611:
+			v = 0;
+			break;
+		case ADV7612:
+			if (state->info->max_port
+					= ADV76XX_PAD_HDMI_PORT_A)
+				v = 0;
+			/* else is unhobbled, leave unspecified */
+		default:
+			break;
+		}
+	}
+	state->pdata.default_input = v;
+
 	flags = bus_cfg.bus.parallel.flags;
 
 	if (flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH)
-- 
2.6.1


From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 12 Feb 2014 01:27:08 +0000
Subject: [PATCH 1/2] regulator: gpio: print warning if gpios <-> gpios-states mismatch on DT
Message-Id: <87iosl9l3q.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87eh3o7mfc.wl%kuninori.morimoto.gx@gmail.com>
	<20140204184327.GS22609@sirena.org.uk>
In-Reply-To: <20140204184327.GS22609@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/regulator/gpio-regulator.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index ac3a8c7..5491cee 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -176,7 +176,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 	if (prop) {
 		proplen = prop->length / sizeof(int);
 		if (proplen != config->nr_gpios) {
-			/* gpios <-> gpios-states mismatch */
+			dev_warn(dev, "gpios <-> gpios-states mismatch\n");
 			prop = NULL;
 		}
 	}
-- 
1.7.9.5


From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 03:39:07 +0000
Subject: [PATCH] regulator: gpio: reborn necessary prop
Message-Id: <87iosjd6lj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee.jones@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

934624d6e9f0b3d41557c4105c286e8daeaadb4e
(regulator: gpio-regulator: do not open-code counting and access of dt array elements)
removed struct property *prop from of_get_gpio_regulator_config()
but, it is still used on
0094050d783bbadffe83effef11a0bda901153ce
(regulator: gpio: add gpios-status for DT)

Compile will fail without this patch

gpio-regulator.c: In function 'of_get_gpio_regulator_config':
gpio-regulator.c:174:2: error: 'prop' undeclared (first use in this function)
gpio-regulator.c:174:2: note: each undeclared identifier is reported \
	only once for each function it appears in

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This is for latest mark-regulator/topic/gpio branch

 drivers/regulator/gpio-regulator.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 9fd5561..20248c1 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -136,6 +136,7 @@ static struct gpio_regulator_config *
 of_get_gpio_regulator_config(struct device *dev, struct device_node *np)
 {
 	struct gpio_regulator_config *config;
+	struct property *prop;
 	const char *regtype;
 	int proplen, gpio, i;
 	int ret;
-- 
1.7.9.5


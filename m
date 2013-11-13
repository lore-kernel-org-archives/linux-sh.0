From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Nov 2013 22:59:46 +0000
Subject: [PATCH 02/03] gpio: em: Setup gpiochip->dev
Message-Id: <20131113225946.21449.68990.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20131113225927.21449.78044.sendpatchset@w520>
In-Reply-To: <20131113225927.21449.78044.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linus.walleij@linaro.org, grant.likely@secretlab.ca, horms@verge.net.au, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm@opensource.se>

Make sure gpio_chip->dev is setup so of_gpiochip_add()
will work as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/gpio/gpio-em.c |    1 +
 1 file changed, 1 insertion(+)

--- 0001/drivers/gpio/gpio-em.c
+++ work/drivers/gpio/gpio-em.c	2013-11-13 20:47:40.000000000 +0900
@@ -327,6 +327,7 @@ static int em_gio_probe(struct platform_
 	gpio_chip->request = em_gio_request;
 	gpio_chip->free = em_gio_free;
 	gpio_chip->label = name;
+	gpio_chip->dev = &pdev->dev;
 	gpio_chip->owner = THIS_MODULE;
 	gpio_chip->base = pdata->gpio_base;
 	gpio_chip->ngpio = pdata->number_of_pins;

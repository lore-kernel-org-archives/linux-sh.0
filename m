From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 Jan 2015 10:07:58 +0000
Subject: [PATCH 1/2] gpio: rcar: Fix error path for devm_kzalloc() failure
Message-Id: <1421057279-16081-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1421057279-16081-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1421057279-16081-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

If the call to devm_kzalloc() fails, nothing must be cleant up.
This was missed before because gpio_rcar_probe() had a "return"
statement after the first "goto err0".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: df0c6c80232f2ad4 ("gpio: rcar: Add minimal runtime PM support")
---
 drivers/gpio/gpio-rcar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index 584484e3f1e3cd1d..ca2b6310f8f709d3 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -372,10 +372,8 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	int ret;
 
 	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
-	if (!p) {
-		ret = -ENOMEM;
-		goto err0;
-	}
+	if (!p)
+		return -ENOMEM;
 
 	p->pdev = pdev;
 	spin_lock_init(&p->lock);
-- 
1.9.1


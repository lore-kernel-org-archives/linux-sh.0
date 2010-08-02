From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 02 Aug 2010 07:16:37 +0000
Subject: [PATCH] i2c: i2c-sh_mobile irq rollback fix
Message-Id: <20100802071637.18054.76993.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: khali@linux-fr.org, Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the i2c-sh_mobile driver to properly free
interrupts. The function sh_mobile_i2c_hook_irqs()
is fixed so module both unload and load are working
as expected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/i2c/busses/i2c-sh_mobile.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- 0001/drivers/i2c/busses/i2c-sh_mobile.c
+++ work/drivers/i2c/busses/i2c-sh_mobile.c	2010-08-02 15:14:48.000000000 +0900
@@ -538,15 +538,17 @@ static int sh_mobile_i2c_hook_irqs(struc
 {
 	struct resource *res;
 	int ret = -ENXIO;
-	int q, m;
-	int k = 0;
-	int n = 0;
+	int n, k = 0;
 
 	while ((res = platform_get_resource(dev, IORESOURCE_IRQ, k))) {
 		for (n = res->start; hook && n <= res->end; n++) {
 			if (request_irq(n, sh_mobile_i2c_isr, IRQF_DISABLED,
-					dev_name(&dev->dev), dev))
+					dev_name(&dev->dev), dev)) {
+				for (n--; n >= res->start; n--)
+					free_irq(n, dev);
+
 				goto rollback;
+			}
 		}
 		k++;
 	}
@@ -554,16 +556,17 @@ static int sh_mobile_i2c_hook_irqs(struc
 	if (hook)
 		return k > 0 ? 0 : -ENOENT;
 
-	k--;
 	ret = 0;
 
  rollback:
-	for (q = k; k >= 0; k--) {
-		for (m = n; m >= res->start; m--)
-			free_irq(m, dev);
+	k--;
+
+	while (k >= 0) {
+		res = platform_get_resource(dev, IORESOURCE_IRQ, k);
+		for (n = res->start; n <= res->end; n++)
+			free_irq(n, dev);
 
-		res = platform_get_resource(dev, IORESOURCE_IRQ, k - 1);
-		m = res->end;
+		k--;
 	}
 
 	return ret;

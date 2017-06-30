From: Chris Packham <chris.packham@alliedtelesis.co.nz>
Date: Fri, 30 Jun 2017 00:54:04 +0000
Subject: [PATCH 2/6] i2c: pca-platform: correctly set algo_data.reset_chip
Message-Id: <20170630005408.23968-3-chris.packham@alliedtelesis.co.nz>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: wsa@the-dreams.de, andy.shevchenko@gmail.com, linux-i2c@vger.kernel.org
Cc: ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org

When device tree support was added the setting of algo_data.reset_chip
was moved. There were two problems with this. The first being that
i2c_pca_pf_resetchip was only used if platform data was provided. The
second that it was unconditionally overridden with
i2c_pca_pf_dummyreset. Ensure that however the reset gpio is defined the
correct reset_chip function is used.

Fixes: commit 4cc7229daa46 ("i2c: pca-platform: switch to struct gpio_desc")
Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/i2c/busses/i2c-pca-platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pca-platform.c b/drivers/i2c/busses/i2c-pca-platform.c
index 395eca0cbb1f..daccef6865e8 100644
--- a/drivers/i2c/busses/i2c-pca-platform.c
+++ b/drivers/i2c/busses/i2c-pca-platform.c
@@ -184,7 +184,6 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 			if (ret = 0) {
 				i2c->gpio = gpio_to_desc(platform_data->gpio);
 				gpiod_direction_output(i2c->gpio, 0);
-				i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
 			} else {
 				dev_warn(&pdev->dev, "Registering gpio failed!\n");
 				i2c->gpio = NULL;
@@ -205,7 +204,10 @@ static int i2c_pca_pf_probe(struct platform_device *pdev)
 
 	i2c->algo_data.data = i2c;
 	i2c->algo_data.wait_for_completion = i2c_pca_pf_waitforcompletion;
-	i2c->algo_data.reset_chip = i2c_pca_pf_dummyreset;
+	if (i2c->gpio)
+		i2c->algo_data.reset_chip = i2c_pca_pf_resetchip;
+	else
+		i2c->algo_data.reset_chip = i2c_pca_pf_dummyreset;
 
 	switch (res->flags & IORESOURCE_MEM_TYPE_MASK) {
 	case IORESOURCE_MEM_32BIT:
-- 
2.13.0


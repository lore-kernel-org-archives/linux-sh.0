From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 09 Oct 2015 06:54:51 +0000
Subject: [PATCH 2/4] i2c: rcar: enable RuntimePM before registering to the core
Message-Id: <1444373693-2372-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail. While here, move drvdata, too.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-rcar.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index d8361dada58455..3d7536d78cb366 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -690,15 +690,15 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	pm_runtime_enable(dev);
+	platform_set_drvdata(pdev, priv);
+
 	ret = i2c_add_numbered_adapter(adap);
 	if (ret < 0) {
 		dev_err(dev, "reg adap failed: %d\n", ret);
 		return ret;
 	}
 
-	pm_runtime_enable(dev);
-	platform_set_drvdata(pdev, priv);
-
 	dev_info(dev, "probed\n");
 
 	return 0;
-- 
2.1.4


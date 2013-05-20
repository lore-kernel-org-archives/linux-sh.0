From: Axel Lin <axel.lin@ingics.com>
Date: Mon, 20 May 2013 13:45:41 +0000
Subject: [PATCH v2] pwm: renesas-tpu: Add missing pwmchip_remove() call in tpu_remove()
Message-Id: <1369057541.11578.1.camel@phoenix>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/pwm/pwm-renesas-tpu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 8e6d8d7..319a6fe 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -432,6 +432,11 @@ static int tpu_remove(struct platform_device *pdev)
 {
 	struct tpu_device *tpu = platform_get_drvdata(pdev);
 	unsigned int i;
+	int ret;
+
+	ret = pwmchip_remove(&tpu->chip);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
 		struct tpu_pwm_device *pwm = &tpu->pwms[i];
-- 
1.8.1.2




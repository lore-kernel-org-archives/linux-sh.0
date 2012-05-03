From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:05:33 +0000
Subject: [PATCH 04/29] regulator: fix devm_regulator_put() to call regulator_put() explicitly
Message-Id: <1336057558-11031-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

devres_destroy() doesn't call the release() method, it only destroys the
resource. The caller should take care to release the associated object
itself.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index e70dd38..fdeabba 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1429,6 +1429,7 @@ void devm_regulator_put(struct regulator *regulator)
 {
 	int rc;
 
+	regulator_put(regulator);
 	rc = devres_destroy(regulator->dev, devm_regulator_release,
 			    devm_regulator_match, regulator);
 	WARN_ON(rc);
-- 
1.7.2.5


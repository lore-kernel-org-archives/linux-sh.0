From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 03 May 2012 15:05:34 +0000
Subject: [PATCH 05/29] regulator: use IS_ERR_OR_NULL() instead of open-coding
Message-Id: <1336057558-11031-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/regulator/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index fdeabba..a57defb 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1381,7 +1381,7 @@ void regulator_put(struct regulator *regulator)
 {
 	struct regulator_dev *rdev;
 
-	if (regulator = NULL || IS_ERR(regulator))
+	if (IS_ERR_OR_NULL(regulator))
 		return;
 
 	mutex_lock(&regulator_list_mutex);
-- 
1.7.2.5


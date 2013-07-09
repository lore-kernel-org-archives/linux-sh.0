From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 09 Jul 2013 14:27:24 +0000
Subject: [PATCH] pinctrl: sh-pfc: fix SDHI0 VccQ regulator on sh73a0 with DT
Message-Id: <Pine.LNX.4.64.1307091625490.28812@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PFC pinctrl driver on sh73a0 is also regiatering a VccQ regulator for
SDHI0. However, its consumers list only included the platform-data based
SDHI device name. When booted with DT SDHI0 couldn't enable VccQ and
therefore was unusable. Fix this by adding a consumer with DT-based name.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Is this the correct fix or is there a better option? Observed and tested 
on kzm9g-reference.

 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 7956df5..31f7d0e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -3785,6 +3785,7 @@ static const struct regulator_desc sh73a0_vccq_mc0_desc = {
 
 static struct regulator_consumer_supply sh73a0_vccq_mc0_consumers[] = {
 	REGULATOR_SUPPLY("vqmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vqmmc", "ee100000.sdhi"),
 };
 
 static const struct regulator_init_data sh73a0_vccq_mc0_init_data = {
-- 
1.7.2.5


From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Thu, 27 Sep 2012 05:53:11 +0000
Subject: [PATCH] sh: pfc: fix return value check in sh_pfc_pinctrl_probe()
Message-Id: <CAPgLHd-R+kd5ydz2FM34Gu+dDdExR_29t8_e=mGHHC=nTbu8Yg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function pinctrl_register() returns
NULL not ERR_PTR(). The IS_ERR() test in the return value
check should be replaced with NULL test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/sh/pfc/pinctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 0646bf6..4848596 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -441,8 +441,8 @@ static int __devinit sh_pfc_pinctrl_probe(struct platform_device *pdev)
 
 	sh_pfc_pmx->pctl = pinctrl_register(&sh_pfc_pinctrl_desc, &pdev->dev,
 					    sh_pfc_pmx);
-	if (IS_ERR(sh_pfc_pmx->pctl)) {
-		ret = PTR_ERR(sh_pfc_pmx->pctl);
+	if (!sh_pfc_pmx->pctl) {
+		ret = -EINVAL;
 		goto free_functions;
 	}
 


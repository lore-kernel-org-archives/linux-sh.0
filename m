From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 03 Sep 2015 02:51:21 +0000
Subject: [PATCH 7/9 v2] sh-pfc: remove unused PINMUX_IPSR_MODSEL_DATA()
Message-Id: <87egigqkw6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, all PINMUX_IPSR_MODSEL_DATA() are replased to PINMUX_IPSR_MSEL()
Let's remove unused PINMUX_IPSR_MODSEL_DATA()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v1 -> v2

 - tidyup log comment for checkpatch
 - Add Laurent Acked-by

 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index c8c1d49..d0b6f5c 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -180,8 +180,6 @@ struct sh_pfc_soc_info {
 	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
 #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
 	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
-#define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms)				\
-	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
 
 /*
  * GP port style (32 ports banks)
-- 
1.9.1


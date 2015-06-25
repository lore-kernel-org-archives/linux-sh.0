From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 25 Jun 2015 22:40:56 +0000
Subject: [PATCH v3 1/3] sh-pfc: fix sparse GPIOs for R-Car SoCs
Message-Id: <2925145.E3lLFJfWJW@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
In-Reply-To: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

The PFC driver causes the kernel to hang on the R-Car gen2 SoC based  boards
when the CPU_ALL_PORT() macro is fixed to reflect the reality, i.e. when the
GPIO space becomes actually sparse.  This happens because the _GP_GPIO() macro
includes  an indexed initializer which causes the "holes" (array entries filled
with all 0s) between the groups  of the existing GPIOs; and the driver can't
cope with that.  There seems to  be no reason to use the indexed initializer,
so we can remove the index specifier and so avoid the "holes".

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- new patch.

 drivers/pinctrl/sh-pfc/sh_pfc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/sh_pfc.h
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -224,7 +224,7 @@ struct sh_pfc_soc_info {
 
 /* PINMUX_GPIO_GP_ALL - Expand to a list of sh_pfc_pin entries */
 #define _GP_GPIO(bank, _pin, _name, sfx)				\
-	[(bank * 32) + _pin] = {					\
+	{								\
 		.pin = (bank * 32) + _pin,				\
 		.name = __stringify(_name),				\
 		.enum_id = _name##_DATA,				\


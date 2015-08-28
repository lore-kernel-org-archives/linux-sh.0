From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 28 Aug 2015 05:20:41 +0000
Subject: [PATCH][RFC] sh-pfc: add new PINMUX_IPSR_MODS() macro
Message-Id: <87h9nkc7km.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Actually, PINMUX_IPSR_MODS() macro is same as PINMUX_IPSR_MODSEL_DATA().
Current PFC driver is very difficult to read, because macro names are
using different lenth. Especially PINMUX_IPSR_MODSEL_DATA() is well
used macro

	PINMUX_IPSR_NOGP(ispr, ...)
	PINMUX_IPSR_DATA(ipsr, ...)
	PINMUX_IPSR_NOGM(ispr, ...)
	PINMUX_IPSR_NOFN(ipsr, ...)
	PINMUX_IPSR_MSEL(ipsr, ...)
	PINMUX_IPSR_MODSEL_DATA(ipsr, ...)

These are readable

	PINMUX_IPSR_NOGP(ispr, ...)
	PINMUX_IPSR_DATA(ipsr, ...)
	PINMUX_IPSR_NOGM(ispr, ...)
	PINMUX_IPSR_NOFN(ipsr, ...)
	PINMUX_IPSR_MSEL(ipsr, ...)
	PINMUX_IPSR_MODS(ipsr, ...)

We can replace all PINMUX_IPSR_MODSEL_DATA() to PINMUX_IPSR_MODS(),
and remove PINMUX_IPSR_MODSEL_DATA() from header.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
> LinusW, Laurent

As I mentioned above, if this patch was accepted, I can replace all PINMUX_IPSR_MODSEL_DATA()
to PINMUX_IPSR_MODS(). But I didn't it since it is [RFC] now

 drivers/pinctrl/sh-pfc/sh_pfc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 0874cfe..40447d54 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -173,6 +173,8 @@ struct sh_pfc_soc_info {
 	PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
 #define PINMUX_IPSR_MSEL(ipsr, fn, ms)					\
 	PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr, FN_##ms)
+#define PINMUX_IPSR_MODS(ipsr, fn, ms)			\
+	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
 #define PINMUX_IPSR_MODSEL_DATA(ipsr, fn, ms)				\
 	PINMUX_DATA(fn##_MARK, FN_##ms, FN_##ipsr, FN_##fn)
 
-- 
1.9.1


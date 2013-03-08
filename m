From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:33 +0000
Subject: [PATCH v3 13/64] sh-pfc: r8a7779: Add USB0 and USB1 PENC pinmux support
Message-Id: <1362740544-19164-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The USB0 and USB1 PENC functions were missing. Add them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 492832c..4ab7b11 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -429,7 +429,8 @@ enum {
 	A0_MARK, SD1_DAT3_MARK, MMC0_D3_MARK, FD3_MARK,
 	BS_MARK, SD1_DAT2_MARK, MMC0_D2_MARK, FD2_MARK,
 	ATADIR0_MARK, SDSELF_MARK, HCTS1_MARK, TX4_C_MARK,
-	USB_PENC2_MARK, SCK0_MARK, PWM1_MARK, PWMFSW0_MARK,
+	USB_PENC0_MARK, USB_PENC1_MARK, USB_PENC2_MARK,
+	SCK0_MARK, PWM1_MARK, PWMFSW0_MARK,
 	SCIF_CLK_MARK, TCLK0_C_MARK,
 
 	EX_CS0_MARK, RX3_C_IRDA_RX_C_MARK, MMC0_D6_MARK,
@@ -640,6 +641,9 @@ static pinmux_enum_t pinmux_data[] = {
 	PINMUX_DATA(A18_MARK, FN_A18),
 	PINMUX_DATA(A19_MARK, FN_A19),
 
+	PINMUX_DATA(USB_PENC0_MARK, FN_USB_PENC0),
+	PINMUX_DATA(USB_PENC1_MARK, FN_USB_PENC1),
+
 	PINMUX_IPSR_DATA(IP0_2_0, USB_PENC2),
 	PINMUX_IPSR_MODSEL_DATA(IP0_2_0, SCK0, SEL_SCIF0_0),
 	PINMUX_IPSR_DATA(IP0_2_0, PWM1),
-- 
1.8.1.5


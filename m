From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:20 +0000
Subject: [PATCH 06/13] pinctrl: sh-pfc: checker: Improve pin checks
Message-Id: <20200110131927.1029-7-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Improve the checks for pin descriptors:
  1. Introduce local variables for the current pin, to make the checks
     easier to read,
  2. Pins must have a name,
  3. Fix double printing of identical pin names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index f82f483b98a25da5..6ff0f19403dc7813 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -860,25 +860,27 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 
 	/* Check pins */
 	for (i = 0; i < info->nr_pins; i++) {
+		const struct sh_pfc_pin *pin = &info->pins[i];
+
+		if (!pin->name) {
+			sh_pfc_err("empty pin %u\n", i);
+			continue;
+		}
 		for (j = 0; j < i; j++) {
-			if (same_name(info->pins[i].name, info->pins[j].name))
-				sh_pfc_err("pin %s/%s: name conflict\n",
-					   info->pins[i].name,
-					   info->pins[j].name);
+			const struct sh_pfc_pin *pin2 = &info->pins[j];
+
+			if (same_name(pin->name, pin2->name))
+				sh_pfc_err("pin %s: name conflict\n",
+					   pin->name);
 
-			if (info->pins[i].pin != (u16)-1 &&
-			    info->pins[i].pin = info->pins[j].pin)
+			if (pin->pin != (u16)-1 && pin->pin = pin2->pin)
 				sh_pfc_err("pin %s/%s: pin %u conflict\n",
-					   info->pins[i].name,
-					   info->pins[j].name,
-					   info->pins[i].pin);
+					   pin->name, pin2->name, pin->pin);
 
-			if (info->pins[i].enum_id &&
-			    info->pins[i].enum_id = info->pins[j].enum_id)
+			if (pin->enum_id && pin->enum_id = pin2->enum_id)
 				sh_pfc_err("pin %s/%s: enum_id %u conflict\n",
-					   info->pins[i].name,
-					   info->pins[j].name,
-					   info->pins[i].enum_id);
+					   pin->name, pin2->name,
+					   pin->enum_id);
 		}
 	}
 
-- 
2.17.1

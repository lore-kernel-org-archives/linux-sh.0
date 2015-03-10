From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Mar 2015 11:06:23 +0000
Subject: [PATCH v2 4/4] pinctrl: sh-pfc: Use u32 to store register addresses
Message-Id: <1425985583-26279-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425985583-26279-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425985583-26279-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently all PFC registers lie in low 32-bit address space. Hence use
u32 instead of unsigned long to store PFC register addresses in pinctrl
tables.  All calculations of virtual addresses use a phys_addr_t
intermediate, so we know where to add an offset if the 32-bit assumption
ever becomes false.

While this doesn't impact 32-bit builds, it would save ca. 7 KiB on a
64-bit shmobile_defconfig kernel.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/pinctrl/sh-pfc/core.c   |  6 +++---
 drivers/pinctrl/sh-pfc/gpio.c   | 12 ++++++++----
 drivers/pinctrl/sh-pfc/sh_pfc.h |  6 +++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index aaf9c7fa742cc9c1..656745f545442d58 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -92,10 +92,10 @@ static int sh_pfc_map_resources(struct sh_pfc *pfc,
 	return 0;
 }
 
-static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
-					 unsigned long address)
+static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc, u32 reg)
 {
 	struct sh_pfc_window *window;
+	phys_addr_t address = reg;
 	unsigned int i;
 
 	/* scan through physical windows and convert address */
@@ -208,7 +208,7 @@ static void sh_pfc_write_config_reg(struct sh_pfc *pfc,
 
 	sh_pfc_config_reg_helper(pfc, crp, field, &mapped_reg, &mask, &pos);
 
-	dev_dbg(pfc->dev, "write_reg addr = %lx, value = 0x%x, field = %u, "
+	dev_dbg(pfc->dev, "write_reg addr = %x, value = 0x%x, field = %u, "
 		"r_width = %u, f_width = %u\n",
 		crp->reg, value, field, crp->reg_width, crp->field_width);
 
diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 5d3a35ce09125a45..ba353735ecf2be9a 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -62,7 +62,8 @@ static void gpio_get_data_reg(struct sh_pfc_chip *chip, unsigned int offset,
 static u32 gpio_read_data_reg(struct sh_pfc_chip *chip,
 			      const struct pinmux_data_reg *dreg)
 {
-	void __iomem *mem = dreg->reg - chip->mem->phys + chip->mem->virt;
+	phys_addr_t address = dreg->reg;
+	void __iomem *mem = address - chip->mem->phys + chip->mem->virt;
 
 	return sh_pfc_read_raw_reg(mem, dreg->reg_width);
 }
@@ -70,7 +71,8 @@ static u32 gpio_read_data_reg(struct sh_pfc_chip *chip,
 static void gpio_write_data_reg(struct sh_pfc_chip *chip,
 				const struct pinmux_data_reg *dreg, u32 value)
 {
-	void __iomem *mem = dreg->reg - chip->mem->phys + chip->mem->virt;
+	phys_addr_t address = dreg->reg;
+	void __iomem *mem = address - chip->mem->phys + chip->mem->virt;
 
 	sh_pfc_write_raw_reg(mem, dreg->reg_width, value);
 }
@@ -340,6 +342,7 @@ sh_pfc_add_gpiochip(struct sh_pfc *pfc, int(*setup)(struct sh_pfc_chip *),
 int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 {
 	struct sh_pfc_chip *chip;
+	phys_addr_t address;
 	unsigned int i;
 	int ret;
 
@@ -351,11 +354,12 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	 * that covers the data registers. In that case don't try to handle
 	 * GPIOs.
 	 */
+	address = pfc->info->data_regs[0].reg;
 	for (i = 0; i < pfc->num_windows; ++i) {
 		struct sh_pfc_window *window = &pfc->windows[i];
 
-		if (pfc->info->data_regs[0].reg >= window->phys &&
-		    pfc->info->data_regs[0].reg < window->phys + window->size)
+		if (address >= window->phys &&
+		    address < window->phys + window->size)
 			break;
 	}
 
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 6aeec8152ea674cf..c7508d5f688613b2 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -69,7 +69,7 @@ struct pinmux_func {
 };
 
 struct pinmux_cfg_reg {
-	unsigned long reg;
+	u32 reg;
 	u8 reg_width, field_width;
 	const u16 *enum_ids;
 	const u8 *var_field_width;
@@ -86,7 +86,7 @@ struct pinmux_cfg_reg {
 	.enum_ids = (const u16 [])
 
 struct pinmux_data_reg {
-	unsigned long reg;
+	u32 reg;
 	u8 reg_width;
 	const u16 *enum_ids;
 };
@@ -150,7 +150,7 @@ struct sh_pfc_soc_info {
 	const struct pinmux_irq *gpio_irq;
 	unsigned int gpio_irq_size;
 
-	unsigned long unlock_reg;
+	u32 unlock_reg;
 };
 
 /* -----------------------------------------------------------------------------
-- 
1.9.1


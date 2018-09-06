From: Boris Brezillon <boris.brezillon@bootlin.com>
Date: Thu, 06 Sep 2018 22:38:51 +0000
Subject: [PATCH 19/19] mtd: rawnand: Move JEDEC code to nand_jedec.c
Message-Id: <20180906223851.6964-20-boris.brezillon@bootlin.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180906223851.6964-1-boris.brezillon@bootlin.com>
In-Reply-To: <20180906223851.6964-1-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Boris Brezillon <boris.brezillon@bootlin.com>, Richard Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>, linux-mtd@lists.infradead.org
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Hartley Sweeten <hsweeten@visionengravers.com>, Ryan Mallon <rmallon@gmail.com>, Alexander Shiyan <shc_work@mail.ru>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Alexander Clouter <alex@digriz.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org

This moves ONFI related code to nand_onfi.c and ONFI related
struct/macros to include/linux/mtd/onfi.h.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/nand/raw/Makefile     |   1 +
 drivers/mtd/nand/raw/internals.h  |   3 +
 drivers/mtd/nand/raw/nand_base.c  |  98 +--------------------------------
 drivers/mtd/nand/raw/nand_jedec.c | 113 ++++++++++++++++++++++++++++++++++=
++++
 include/linux/mtd/jedec.h         |  91 ++++++++++++++++++++++++++++++
 include/linux/mtd/rawnand.h       |  79 +-------------------------
 6 files changed, 210 insertions(+), 175 deletions(-)
 create mode 100644 drivers/mtd/nand/raw/nand_jedec.c
 create mode 100644 include/linux/mtd/jedec.h

diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
index cc9f50f3ad1b..be2c17863ee5 100644
--- a/drivers/mtd/nand/raw/Makefile
+++ b/drivers/mtd/nand/raw/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MTD_NAND_TEGRA)		+=3D tegra_nand.o
=20
 nand-objs :=3D nand_base.o nand_legacy.o nand_bbt.o nand_timings.o nand_id=
s.o
 nand-objs +=3D nand_onfi.o
+nand-objs +=3D nand_jedec.o
 nand-objs +=3D nand_amd.o
 nand-objs +=3D nand_hynix.o
 nand-objs +=3D nand_macronix.o
diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/intern=
als.h
index 1ce720a8d756..88b5da620e7d 100644
--- a/drivers/mtd/nand/raw/internals.h
+++ b/drivers/mtd/nand/raw/internals.h
@@ -108,4 +108,7 @@ int nand_legacy_check_hooks(struct nand_chip *chip);
 u16 onfi_crc16(u16 crc, u8 const *p, size_t len);
 int nand_onfi_detect(struct nand_chip *chip);
=20
+/* JEDEC functions */
+int nand_jedec_detect(struct nand_chip *chip);
+
 #endif /* __LINUX_RAWNAND_INTERNALS */
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index 812e8bd6ad82..dc3955da0426 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -4387,102 +4387,6 @@ void sanitize_string(uint8_t *s, size_t len)
 	strim(s);
 }
=20
-/*
- * Check if the NAND chip is JEDEC compliant, returns 1 if it is, 0 otherw=
ise.
- */
-static int nand_flash_detect_jedec(struct nand_chip *chip)
-{
-	struct mtd_info *mtd =3D nand_to_mtd(chip);
-	struct nand_jedec_params *p;
-	struct jedec_ecc_info *ecc;
-	int jedec_version =3D 0;
-	char id[5];
-	int i, val, ret;
-
-	/* Try JEDEC for unknown chip or LP */
-	ret =3D nand_readid_op(chip, 0x40, id, sizeof(id));
-	if (ret || strncmp(id, "JEDEC", sizeof(id)))
-		return 0;
-
-	/* JEDEC chip: allocate a buffer to hold its parameter page */
-	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-
-	ret =3D nand_read_param_page_op(chip, 0x40, NULL, 0);
-	if (ret) {
-		ret =3D 0;
-		goto free_jedec_param_page;
-	}
-
-	for (i =3D 0; i < 3; i++) {
-		ret =3D nand_read_data_op(chip, p, sizeof(*p), true);
-		if (ret) {
-			ret =3D 0;
-			goto free_jedec_param_page;
-		}
-
-		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 510) =3D
-				le16_to_cpu(p->crc))
-			break;
-	}
-
-	if (i =3D 3) {
-		pr_err("Could not find valid JEDEC parameter page; aborting\n");
-		goto free_jedec_param_page;
-	}
-
-	/* Check version */
-	val =3D le16_to_cpu(p->revision);
-	if (val & (1 << 2))
-		jedec_version =3D 10;
-	else if (val & (1 << 1))
-		jedec_version =3D 1; /* vendor specific version */
-
-	if (!jedec_version) {
-		pr_info("unsupported JEDEC version: %d\n", val);
-		goto free_jedec_param_page;
-	}
-
-	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
-	sanitize_string(p->model, sizeof(p->model));
-	chip->parameters.model =3D kstrdup(p->model, GFP_KERNEL);
-	if (!chip->parameters.model) {
-		ret =3D -ENOMEM;
-		goto free_jedec_param_page;
-	}
-
-	mtd->writesize =3D le32_to_cpu(p->byte_per_page);
-
-	/* Please reference to the comment for nand_flash_detect_onfi. */
-	mtd->erasesize =3D 1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
-	mtd->erasesize *=3D mtd->writesize;
-
-	mtd->oobsize =3D le16_to_cpu(p->spare_bytes_per_page);
-
-	/* Please reference to the comment for nand_flash_detect_onfi. */
-	chip->chipsize =3D 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
-	chip->chipsize *=3D (uint64_t)mtd->erasesize * p->lun_count;
-	chip->bits_per_cell =3D p->bits_per_cell;
-
-	if (le16_to_cpu(p->features) & JEDEC_FEATURE_16_BIT_BUS)
-		chip->options |=3D NAND_BUSWIDTH_16;
-
-	/* ECC info */
-	ecc =3D &p->ecc_info[0];
-
-	if (ecc->codeword_size >=3D 9) {
-		chip->ecc_strength_ds =3D ecc->ecc_bits;
-		chip->ecc_step_ds =3D 1 << ecc->codeword_size;
-	} else {
-		pr_warn("Invalid codeword size\n");
-	}
-
-free_jedec_param_page:
-	kfree(p);
-	return ret;
-}
-
 /*
  * nand_id_has_period - Check if an ID string has a given wraparound period
  * @id_data: the ID string
@@ -4795,7 +4699,7 @@ static int nand_detect(struct nand_chip *chip, struct=
 nand_flash_dev *type)
 			goto ident_done;
=20
 		/* Check if the chip is JEDEC compliant */
-		ret =3D nand_flash_detect_jedec(chip);
+		ret =3D nand_jedec_detect(chip);
 		if (ret < 0)
 			return ret;
 		else if (ret)
diff --git a/drivers/mtd/nand/raw/nand_jedec.c b/drivers/mtd/nand/raw/nand_=
jedec.c
new file mode 100644
index 000000000000..5c26492c841d
--- /dev/null
+++ b/drivers/mtd/nand/raw/nand_jedec.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Copyright (C) 2000 Steven J. Hill (sjhill@realitydiluted.com)
+ *		  2002-2006 Thomas Gleixner (tglx@linutronix.de)
+ *
+ *  Credits:
+ *	David Woodhouse for adding multichip support
+ *
+ *	Aleph One Ltd. and Toby Churchill Ltd. for supporting the
+ *	rework for 2K page size chips
+ *
+ * This file contains all ONFI helpers.
+ */
+
+#include <linux/slab.h>
+
+#include "internals.h"
+
+/*
+ * Check if the NAND chip is JEDEC compliant, returns 1 if it is, 0 otherw=
ise.
+ */
+int nand_jedec_detect(struct nand_chip *chip)
+{
+	struct mtd_info *mtd =3D nand_to_mtd(chip);
+	struct nand_jedec_params *p;
+	struct jedec_ecc_info *ecc;
+	int jedec_version =3D 0;
+	char id[5];
+	int i, val, ret;
+
+	/* Try JEDEC for unknown chip or LP */
+	ret =3D nand_readid_op(chip, 0x40, id, sizeof(id));
+	if (ret || strncmp(id, "JEDEC", sizeof(id)))
+		return 0;
+
+	/* JEDEC chip: allocate a buffer to hold its parameter page */
+	p =3D kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	ret =3D nand_read_param_page_op(chip, 0x40, NULL, 0);
+	if (ret) {
+		ret =3D 0;
+		goto free_jedec_param_page;
+	}
+
+	for (i =3D 0; i < 3; i++) {
+		ret =3D nand_read_data_op(chip, p, sizeof(*p), true);
+		if (ret) {
+			ret =3D 0;
+			goto free_jedec_param_page;
+		}
+
+		if (onfi_crc16(ONFI_CRC_BASE, (uint8_t *)p, 510) =3D
+				le16_to_cpu(p->crc))
+			break;
+	}
+
+	if (i =3D 3) {
+		pr_err("Could not find valid JEDEC parameter page; aborting\n");
+		goto free_jedec_param_page;
+	}
+
+	/* Check version */
+	val =3D le16_to_cpu(p->revision);
+	if (val & (1 << 2))
+		jedec_version =3D 10;
+	else if (val & (1 << 1))
+		jedec_version =3D 1; /* vendor specific version */
+
+	if (!jedec_version) {
+		pr_info("unsupported JEDEC version: %d\n", val);
+		goto free_jedec_param_page;
+	}
+
+	sanitize_string(p->manufacturer, sizeof(p->manufacturer));
+	sanitize_string(p->model, sizeof(p->model));
+	chip->parameters.model =3D kstrdup(p->model, GFP_KERNEL);
+	if (!chip->parameters.model) {
+		ret =3D -ENOMEM;
+		goto free_jedec_param_page;
+	}
+
+	mtd->writesize =3D le32_to_cpu(p->byte_per_page);
+
+	/* Please reference to the comment for nand_flash_detect_onfi. */
+	mtd->erasesize =3D 1 << (fls(le32_to_cpu(p->pages_per_block)) - 1);
+	mtd->erasesize *=3D mtd->writesize;
+
+	mtd->oobsize =3D le16_to_cpu(p->spare_bytes_per_page);
+
+	/* Please reference to the comment for nand_flash_detect_onfi. */
+	chip->chipsize =3D 1 << (fls(le32_to_cpu(p->blocks_per_lun)) - 1);
+	chip->chipsize *=3D (uint64_t)mtd->erasesize * p->lun_count;
+	chip->bits_per_cell =3D p->bits_per_cell;
+
+	if (le16_to_cpu(p->features) & JEDEC_FEATURE_16_BIT_BUS)
+		chip->options |=3D NAND_BUSWIDTH_16;
+
+	/* ECC info */
+	ecc =3D &p->ecc_info[0];
+
+	if (ecc->codeword_size >=3D 9) {
+		chip->ecc_strength_ds =3D ecc->ecc_bits;
+		chip->ecc_step_ds =3D 1 << ecc->codeword_size;
+	} else {
+		pr_warn("Invalid codeword size\n");
+	}
+
+free_jedec_param_page:
+	kfree(p);
+	return ret;
+}
diff --git a/include/linux/mtd/jedec.h b/include/linux/mtd/jedec.h
new file mode 100644
index 000000000000..0b6b59f7cfbd
--- /dev/null
+++ b/include/linux/mtd/jedec.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright =C2=A9 2000-2010 David Woodhouse <dwmw2@infradead.org>
+ *			 Steven J. Hill <sjhill@realitydiluted.com>
+ *			 Thomas Gleixner <tglx@linutronix.de>
+ *
+ * Contains all JEDEC related definitions
+ */
+
+#ifndef __LINUX_MTD_JEDEC_H
+#define __LINUX_MTD_JEDEC_H
+
+struct jedec_ecc_info {
+	u8 ecc_bits;
+	u8 codeword_size;
+	__le16 bb_per_lun;
+	__le16 block_endurance;
+	u8 reserved[2];
+} __packed;
+
+/* JEDEC features */
+#define JEDEC_FEATURE_16_BIT_BUS	(1 << 0)
+
+struct nand_jedec_params {
+	/* rev info and features block */
+	/* 'J' 'E' 'S' 'D'  */
+	u8 sig[4];
+	__le16 revision;
+	__le16 features;
+	u8 opt_cmd[3];
+	__le16 sec_cmd;
+	u8 num_of_param_pages;
+	u8 reserved0[18];
+
+	/* manufacturer information block */
+	char manufacturer[12];
+	char model[20];
+	u8 jedec_id[6];
+	u8 reserved1[10];
+
+	/* memory organization block */
+	__le32 byte_per_page;
+	__le16 spare_bytes_per_page;
+	u8 reserved2[6];
+	__le32 pages_per_block;
+	__le32 blocks_per_lun;
+	u8 lun_count;
+	u8 addr_cycles;
+	u8 bits_per_cell;
+	u8 programs_per_page;
+	u8 multi_plane_addr;
+	u8 multi_plane_op_attr;
+	u8 reserved3[38];
+
+	/* electrical parameter block */
+	__le16 async_sdr_speed_grade;
+	__le16 toggle_ddr_speed_grade;
+	__le16 sync_ddr_speed_grade;
+	u8 async_sdr_features;
+	u8 toggle_ddr_features;
+	u8 sync_ddr_features;
+	__le16 t_prog;
+	__le16 t_bers;
+	__le16 t_r;
+	__le16 t_r_multi_plane;
+	__le16 t_ccs;
+	__le16 io_pin_capacitance_typ;
+	__le16 input_pin_capacitance_typ;
+	__le16 clk_pin_capacitance_typ;
+	u8 driver_strength_support;
+	__le16 t_adl;
+	u8 reserved4[36];
+
+	/* ECC and endurance block */
+	u8 guaranteed_good_blocks;
+	__le16 guaranteed_block_endurance;
+	struct jedec_ecc_info ecc_info[4];
+	u8 reserved5[29];
+
+	/* reserved */
+	u8 reserved6[148];
+
+	/* vendor */
+	__le16 vendor_rev_num;
+	u8 reserved7[88];
+
+	/* CRC for Parameter Page */
+	__le16 crc;
+} __packed;
+
+#endif /* __LINUX_MTD_JEDEC_H */
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index f4fc0cce7c55..68d09e01fa56 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -21,6 +21,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/flashchip.h>
 #include <linux/mtd/bbm.h>
+#include <linux/mtd/jedec.h>
 #include <linux/mtd/onfi.h>
 #include <linux/of.h>
 #include <linux/types.h>
@@ -205,84 +206,6 @@ enum nand_ecc_algo {
 #define NAND_CI_CELLTYPE_MSK	0x0C
 #define NAND_CI_CELLTYPE_SHIFT	2
=20
-struct jedec_ecc_info {
-	u8 ecc_bits;
-	u8 codeword_size;
-	__le16 bb_per_lun;
-	__le16 block_endurance;
-	u8 reserved[2];
-} __packed;
-
-/* JEDEC features */
-#define JEDEC_FEATURE_16_BIT_BUS	(1 << 0)
-
-struct nand_jedec_params {
-	/* rev info and features block */
-	/* 'J' 'E' 'S' 'D'  */
-	u8 sig[4];
-	__le16 revision;
-	__le16 features;
-	u8 opt_cmd[3];
-	__le16 sec_cmd;
-	u8 num_of_param_pages;
-	u8 reserved0[18];
-
-	/* manufacturer information block */
-	char manufacturer[12];
-	char model[20];
-	u8 jedec_id[6];
-	u8 reserved1[10];
-
-	/* memory organization block */
-	__le32 byte_per_page;
-	__le16 spare_bytes_per_page;
-	u8 reserved2[6];
-	__le32 pages_per_block;
-	__le32 blocks_per_lun;
-	u8 lun_count;
-	u8 addr_cycles;
-	u8 bits_per_cell;
-	u8 programs_per_page;
-	u8 multi_plane_addr;
-	u8 multi_plane_op_attr;
-	u8 reserved3[38];
-
-	/* electrical parameter block */
-	__le16 async_sdr_speed_grade;
-	__le16 toggle_ddr_speed_grade;
-	__le16 sync_ddr_speed_grade;
-	u8 async_sdr_features;
-	u8 toggle_ddr_features;
-	u8 sync_ddr_features;
-	__le16 t_prog;
-	__le16 t_bers;
-	__le16 t_r;
-	__le16 t_r_multi_plane;
-	__le16 t_ccs;
-	__le16 io_pin_capacitance_typ;
-	__le16 input_pin_capacitance_typ;
-	__le16 clk_pin_capacitance_typ;
-	u8 driver_strength_support;
-	__le16 t_adl;
-	u8 reserved4[36];
-
-	/* ECC and endurance block */
-	u8 guaranteed_good_blocks;
-	__le16 guaranteed_block_endurance;
-	struct jedec_ecc_info ecc_info[4];
-	u8 reserved5[29];
-
-	/* reserved */
-	u8 reserved6[148];
-
-	/* vendor */
-	__le16 vendor_rev_num;
-	u8 reserved7[88];
-
-	/* CRC for Parameter Page */
-	__le16 crc;
-} __packed;
-
 /**
  * struct nand_parameters - NAND generic parameters from the parameter page
  * @model: Model name
--=20
2.14.1

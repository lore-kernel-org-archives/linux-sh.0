From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 20 Oct 2008 08:17:44 +0000
Subject: [PATCH] mtd: sh_flctl: fix compile error
Message-Id: <48FC3EA8.6000205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dwmw2@infradead.org
Cc: linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Fix compile error because the first patch was broken.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 drivers/mtd/nand/sh_flctl.c |  577 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 577 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 600a76f..821acb0 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -299,3 +299,580 @@ static void set_cmd_regs(struct mtd_info *mtd, uint32_t cmd, uint32_t flcmcdr_va
 		break;
 	case NAND_CMD_PAGEPROG:
 		addr_len_bytes = flctl->rw_ADRCNT;
+		flcmdcr_val |= DOCMD2_E | CDSRC_E | SELRW;
+		break;
+	case NAND_CMD_READID:
+		flcmncr_val &= ~SNAND_E;
+		addr_len_bytes = ADRCNT_1;
+		break;
+	case NAND_CMD_STATUS:
+	case NAND_CMD_RESET:
+		flcmncr_val &= ~SNAND_E;
+		flcmdcr_val &= ~(DOADR_E | DOSR_E);
+		break;
+	default:
+		break;
+	}
+
+	/* Set address bytes parameter */
+	flcmdcr_val |= addr_len_bytes;
+
+	/* Now actually write */
+	writel(flcmncr_val, FLCMNCR(flctl));
+	writel(flcmdcr_val, FLCMDCR(flctl));
+	writel(flcmcdr_val, FLCMCDR(flctl));
+}
+
+static int flctl_read_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+				uint8_t *buf)
+{
+	int i, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	uint8_t *p = buf;
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+
+	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
+		chip->read_buf(mtd, p, eccsize);
+
+	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize) {
+		if (flctl->hwecc_cant_correct[i])
+			mtd->ecc_stats.failed++;
+		else
+			mtd->ecc_stats.corrected += 0;
+	}
+
+	return 0;
+}
+
+static void flctl_write_page_hwecc(struct mtd_info *mtd, struct nand_chip *chip,
+				   const uint8_t *buf)
+{
+	int i, eccsize = chip->ecc.size;
+	int eccbytes = chip->ecc.bytes;
+	int eccsteps = chip->ecc.steps;
+	const uint8_t *p = buf;
+
+	for (i = 0; eccsteps; eccsteps--, i += eccbytes, p += eccsize)
+		chip->write_buf(mtd, p, eccsize);
+}
+
+static void execmd_read_page_sector(struct mtd_info *mtd, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int sector, page_sectors;
+
+	if (flctl->page_size)
+		page_sectors = 4;
+	else
+		page_sectors = 1;
+
+	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE | _4ECCCORRECT,
+		 FLCMNCR(flctl));
+
+	set_cmd_regs(mtd, NAND_CMD_READ0,
+		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
+
+	for (sector = 0; sector < page_sectors; sector++) {
+		int ret;
+
+		empty_fifo(flctl);
+		writel(readl(FLCMDCR(flctl)) | 1, FLCMDCR(flctl));
+		writel(page_addr << 2 | sector, FLADR(flctl));
+
+		start_translation(flctl);
+		read_fiforeg(flctl, 512, 512 * sector);
+
+		ret = read_ecfiforeg(flctl,
+			&flctl->done_buff[mtd->writesize + 16 * sector]);
+
+		if (ret)
+			flctl->hwecc_cant_correct[sector] = 1;
+
+		writel(0x0, FL4ECCCR(flctl));
+		wait_completion(flctl);
+	}
+	writel(readl(FLCMNCR(flctl)) & ~(ACM_SACCES_MODE | _4ECCCORRECT),
+			FLCMNCR(flctl));
+}
+
+static void execmd_read_oob(struct mtd_info *mtd, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+
+	set_cmd_regs(mtd, NAND_CMD_READ0,
+		(NAND_CMD_READSTART << 8) | NAND_CMD_READ0);
+
+	empty_fifo(flctl);
+	if (flctl->page_size) {
+		int i;
+		/* In case that the page size is 2k */
+		for (i = 0; i < 16 * 3; i++)
+			flctl->done_buff[i] = 0xFF;
+
+		set_addr(mtd, 3 * 528 + 512, page_addr);
+		writel(16, FLDTCNTR(flctl));
+
+		start_translation(flctl);
+		read_fiforeg(flctl, 16, 16 * 3);
+		wait_completion(flctl);
+	} else {
+		/* In case that the page size is 512b */
+		set_addr(mtd, 512, page_addr);
+		writel(16, FLDTCNTR(flctl));
+
+		start_translation(flctl);
+		read_fiforeg(flctl, 16, 0);
+		wait_completion(flctl);
+	}
+}
+
+static void execmd_write_page_sector(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int i, page_addr = flctl->seqin_page_addr;
+	int sector, page_sectors;
+
+	if (flctl->page_size)
+		page_sectors = 4;
+	else
+		page_sectors = 1;
+
+	writel(readl(FLCMNCR(flctl)) | ACM_SACCES_MODE, FLCMNCR(flctl));
+
+	set_cmd_regs(mtd, NAND_CMD_PAGEPROG,
+			(NAND_CMD_PAGEPROG << 8) | NAND_CMD_SEQIN);
+
+	for (sector = 0; sector < page_sectors; sector++) {
+		empty_fifo(flctl);
+		writel(readl(FLCMDCR(flctl)) | 1, FLCMDCR(flctl));
+		writel(page_addr << 2 | sector, FLADR(flctl));
+
+		start_translation(flctl);
+		write_fiforeg(flctl, 512, 512 * sector);
+
+		for (i = 0; i < 4; i++) {
+			wait_wecfifo_ready(flctl); /* wait for write ready */
+			writel(0xFFFFFFFF, FLECFIFO(flctl));
+		}
+		wait_completion(flctl);
+	}
+
+	writel(readl(FLCMNCR(flctl)) & ~ACM_SACCES_MODE, FLCMNCR(flctl));
+}
+
+static void execmd_write_oob(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int page_addr = flctl->seqin_page_addr;
+	int sector, page_sectors;
+
+	if (flctl->page_size) {
+		sector = 3;
+		page_sectors = 4;
+	} else {
+		sector = 0;
+		page_sectors = 1;
+	}
+
+	set_cmd_regs(mtd, NAND_CMD_PAGEPROG,
+			(NAND_CMD_PAGEPROG << 8) | NAND_CMD_SEQIN);
+
+	for (; sector < page_sectors; sector++) {
+		empty_fifo(flctl);
+		set_addr(mtd, sector * 528 + 512, page_addr);
+		writel(16, FLDTCNTR(flctl));	/* set read size */
+
+		start_translation(flctl);
+		write_fiforeg(flctl, 16, 16 * sector);
+		wait_completion(flctl);
+	}
+}
+
+static void flctl_cmdfunc(struct mtd_info *mtd, unsigned int command,
+			int column, int page_addr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	uint32_t read_cmd = 0;
+
+	flctl->read_bytes = 0;
+	if (command != NAND_CMD_PAGEPROG)
+		flctl->index = 0;
+
+	switch (command) {
+	case NAND_CMD_READ1:
+	case NAND_CMD_READ0:
+		if (flctl->hwecc) {
+			/* read page with hwecc */
+			execmd_read_page_sector(mtd, page_addr);
+			break;
+		}
+		empty_fifo(flctl);
+		if (flctl->page_size)
+			set_cmd_regs(mtd, command, (NAND_CMD_READSTART << 8)
+				| command);
+		else
+			set_cmd_regs(mtd, command, command);
+
+		set_addr(mtd, 0, page_addr);
+
+		flctl->read_bytes = mtd->writesize + mtd->oobsize;
+		flctl->index += column;
+		goto read_normal_exit;
+
+	case NAND_CMD_READOOB:
+		if (flctl->hwecc) {
+			/* read page with hwecc */
+			execmd_read_oob(mtd, page_addr);
+			break;
+		}
+
+		empty_fifo(flctl);
+		if (flctl->page_size) {
+			set_cmd_regs(mtd, command, (NAND_CMD_READSTART << 8)
+				| NAND_CMD_READ0);
+			set_addr(mtd, mtd->writesize, page_addr);
+		} else {
+			set_cmd_regs(mtd, command, command);
+			set_addr(mtd, 0, page_addr);
+		}
+		flctl->read_bytes = mtd->oobsize;
+		goto read_normal_exit;
+
+	case NAND_CMD_READID:
+		empty_fifo(flctl);
+		set_cmd_regs(mtd, command, command);
+		set_addr(mtd, 0, 0);
+
+		flctl->read_bytes = 4;
+		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
+		start_translation(flctl);
+		read_datareg(flctl, 0);	/* read and end */
+		break;
+
+	case NAND_CMD_ERASE1:
+		flctl->erase1_page_addr = page_addr;
+		break;
+
+	case NAND_CMD_ERASE2:
+		set_cmd_regs(mtd, NAND_CMD_ERASE1,
+			(command << 8) | NAND_CMD_ERASE1);
+		set_addr(mtd, -1, flctl->erase1_page_addr);
+		start_translation(flctl);
+		wait_completion(flctl);
+		break;
+
+	case NAND_CMD_SEQIN:
+		if (!flctl->page_size) {
+			/* output read command */
+			if (column >= mtd->writesize) {
+				column -= mtd->writesize;
+				read_cmd = NAND_CMD_READOOB;
+			} else if (column < 256) {
+				read_cmd = NAND_CMD_READ0;
+			} else {
+				column -= 256;
+				read_cmd = NAND_CMD_READ1;
+			}
+		}
+		flctl->seqin_column = column;
+		flctl->seqin_page_addr = page_addr;
+		flctl->seqin_read_cmd = read_cmd;
+		break;
+
+	case NAND_CMD_PAGEPROG:
+		empty_fifo(flctl);
+		if (!flctl->page_size) {
+			set_cmd_regs(mtd, NAND_CMD_SEQIN,
+					flctl->seqin_read_cmd);
+			set_addr(mtd, -1, -1);
+			writel(0, FLDTCNTR(flctl));	/* set 0 size */
+			start_translation(flctl);
+			wait_completion(flctl);
+		}
+		if (flctl->hwecc) {
+			/* write page with hwecc */
+			if (flctl->seqin_column = mtd->writesize)
+				execmd_write_oob(mtd);
+			else if (!flctl->seqin_column)
+				execmd_write_page_sector(mtd);
+			else
+				printk(KERN_ERR "Invalid address !?\n");
+			break;
+		}
+		set_cmd_regs(mtd, command, (command << 8) | NAND_CMD_SEQIN);
+		set_addr(mtd, flctl->seqin_column, flctl->seqin_page_addr);
+		writel(flctl->index, FLDTCNTR(flctl));	/* set write size */
+		start_translation(flctl);
+		write_fiforeg(flctl, flctl->index, 0);
+		wait_completion(flctl);
+		break;
+
+	case NAND_CMD_STATUS:
+		set_cmd_regs(mtd, command, command);
+		set_addr(mtd, -1, -1);
+
+		flctl->read_bytes = 1;
+		writel(flctl->read_bytes, FLDTCNTR(flctl)); /* set read size */
+		start_translation(flctl);
+		read_datareg(flctl, 0); /* read and end */
+		break;
+
+	case NAND_CMD_RESET:
+		set_cmd_regs(mtd, command, command);
+		set_addr(mtd, -1, -1);
+
+		writel(0, FLDTCNTR(flctl));	/* set 0 size */
+		start_translation(flctl);
+		wait_completion(flctl);
+		break;
+
+	default:
+		break;
+	}
+	return;
+
+read_normal_exit:
+	writel(flctl->read_bytes, FLDTCNTR(flctl));	/* set read size */
+	start_translation(flctl);
+	read_fiforeg(flctl, flctl->read_bytes, 0);
+	wait_completion(flctl);
+	return;
+}
+
+static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	uint32_t flcmncr_val = readl(FLCMNCR(flctl));
+
+	switch (chipnr) {
+	case -1:
+		flcmncr_val &= ~CE0_ENABLE;
+		writel(flcmncr_val, FLCMNCR(flctl));
+		break;
+	case 0:
+		flcmncr_val |= CE0_ENABLE;
+		writel(flcmncr_val, FLCMNCR(flctl));
+		break;
+	default:
+		BUG();
+	}
+}
+
+static void flctl_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int i, index = flctl->index;
+
+	for (i = 0; i < len; i++)
+		flctl->done_buff[index + i] = buf[i];
+	flctl->index += len;
+}
+
+static uint8_t flctl_read_byte(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int index = flctl->index;
+	uint8_t data;
+
+	data = flctl->done_buff[index];
+	flctl->index++;
+	return data;
+}
+
+static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		buf[i] = flctl_read_byte(mtd);
+}
+
+static int flctl_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i++)
+		if (buf[i] != flctl_read_byte(mtd))
+			return -EFAULT;
+	return 0;
+}
+
+static void flctl_register_init(struct sh_flctl *flctl, unsigned long val)
+{
+	writel(val, FLCMNCR(flctl));
+}
+
+static int flctl_chip_init_tail(struct mtd_info *mtd)
+{
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	struct nand_chip *chip = &flctl->chip;
+
+	if (mtd->writesize = 512) {
+		flctl->page_size = 0;
+		if (chip->chipsize > (32 << 20)) {
+			/* big than 32MB */
+			flctl->rw_ADRCNT = ADRCNT_4;
+			flctl->erase_ADRCNT = ADRCNT_3;
+		} else if (chip->chipsize > (2 << 16)) {
+			/* big than 128KB */
+			flctl->rw_ADRCNT = ADRCNT_3;
+			flctl->erase_ADRCNT = ADRCNT_2;
+		} else {
+			flctl->rw_ADRCNT = ADRCNT_2;
+			flctl->erase_ADRCNT = ADRCNT_1;
+		}
+	} else {
+		flctl->page_size = 1;
+		if (chip->chipsize > (128 << 20)) {
+			/* big than 128MB */
+			flctl->rw_ADRCNT = ADRCNT2_E;
+			flctl->erase_ADRCNT = ADRCNT_3;
+		} else if (chip->chipsize > (8 << 16)) {
+			/* big than 512KB */
+			flctl->rw_ADRCNT = ADRCNT_4;
+			flctl->erase_ADRCNT = ADRCNT_2;
+		} else {
+			flctl->rw_ADRCNT = ADRCNT_3;
+			flctl->erase_ADRCNT = ADRCNT_1;
+		}
+	}
+
+	if (flctl->hwecc) {
+		if (mtd->writesize = 512) {
+			chip->ecc.layout = &flctl_4secc_oob_16;
+			chip->badblock_pattern = &flctl_4secc_smallpage;
+		} else {
+			chip->ecc.layout = &flctl_4secc_oob_64;
+			chip->badblock_pattern = &flctl_4secc_largepage;
+		}
+
+		chip->ecc.size = 512;
+		chip->ecc.bytes = 10;
+		chip->ecc.read_page = flctl_read_page_hwecc;
+		chip->ecc.write_page = flctl_write_page_hwecc;
+		chip->ecc.mode = NAND_ECC_HW;
+
+		/* 4 symbols ECC enabled */
+		writel(readl(FLCMNCR(flctl)) | _4ECCEN | ECCPOS2 | ECCPOS_02,
+				FLCMNCR(flctl));
+	} else {
+		chip->ecc.mode = NAND_ECC_SOFT;
+	}
+
+	return 0;
+}
+
+static int __init flctl_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	struct sh_flctl *flctl;
+	struct mtd_info *flctl_mtd;
+	struct nand_chip *nand;
+	struct sh_flctl_platform_data *pdata;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata = NULL) {
+		printk(KERN_ERR "sh_flctl platform_data not found.\n");
+		return -ENODEV;
+	}
+
+	flctl = kzalloc(sizeof(struct sh_flctl), GFP_KERNEL);
+	if (!flctl) {
+		printk(KERN_ERR "Unable to allocate NAND MTD dev structure.\n");
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		printk(KERN_ERR "%s: resource not found.\n", __func__);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	flctl->reg = ioremap(res->start, res->end - res->start + 1);
+	if (flctl->reg = NULL) {
+		printk(KERN_ERR "%s: ioremap error.\n", __func__);
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	platform_set_drvdata(pdev, flctl);
+	flctl_mtd = &flctl->mtd;
+	nand = &flctl->chip;
+	flctl_mtd->priv = nand;
+	flctl->hwecc = pdata->has_hwecc;
+
+	flctl_register_init(flctl, pdata->flcmncr_val);
+
+	nand->options = NAND_NO_AUTOINCR;
+
+	/* Set address of hardware control function */
+	/* 20 us command delay time */
+	nand->chip_delay = 20;
+
+	nand->read_byte = flctl_read_byte;
+	nand->write_buf = flctl_write_buf;
+	nand->read_buf = flctl_read_buf;
+	nand->verify_buf = flctl_verify_buf;
+	nand->select_chip = flctl_select_chip;
+	nand->cmdfunc = flctl_cmdfunc;
+
+	ret = nand_scan_ident(flctl_mtd, 1);
+	if (ret)
+		goto err;
+
+	ret = flctl_chip_init_tail(flctl_mtd);
+	if (ret)
+		goto err;
+
+	ret = nand_scan_tail(flctl_mtd);
+	if (ret)
+		goto err;
+
+	add_mtd_partitions(flctl_mtd, pdata->parts, pdata->nr_parts);
+
+	return 0;
+
+err:
+	kfree(flctl);
+	return ret;
+}
+
+static int __exit flctl_remove(struct platform_device *pdev)
+{
+	struct sh_flctl *flctl = platform_get_drvdata(pdev);
+
+	nand_release(&flctl->mtd);
+	kfree(flctl);
+
+	return 0;
+}
+
+static struct platform_driver flctl_driver = {
+	.probe		= flctl_probe,
+	.remove		= flctl_remove,
+	.driver = {
+		.name	= "sh_flctl",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init flctl_nand_init(void)
+{
+	return platform_driver_register(&flctl_driver);
+}
+
+static void __exit flctl_nand_cleanup(void)
+{
+	platform_driver_unregister(&flctl_driver);
+}
+
+module_init(flctl_nand_init);
+module_exit(flctl_nand_cleanup);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yoshihiro Shimoda");
+MODULE_DESCRIPTION("SuperH FLCTL driver");
+MODULE_ALIAS("platform:sh_flctl");
-- 
1.5.5


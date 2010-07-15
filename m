From: Markus Pietrek <markus.pietrek@emtrion.de>
Date: Thu, 15 Jul 2010 12:50:59 +0000
Subject: [PATCH] drivers/mfd/sh_mobile_sdhi.c: uses optimized block transfer
Message-Id: <4C3F0433.8010005@emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


On the SH7723, these settings improve PIO reads from 4MB/s to 13MB/s and wr=
ites from 1MB/s to 4.1MB/s

Signed-off-by: Markus Pietrek <markus.pietrek@emtrion.de>
---
 drivers/mfd/sh_mobile_sdhi.c |    9 +++++++++
 drivers/mmc/host/tmio_mmc.c  |   14 ++++++++++++++
 include/linux/mfd/tmio.h     |    9 +++++++++
 3 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/sh_mobile_sdhi.c b/drivers/mfd/sh_mobile_sdhi.c
index cd16459..0bd80a3 100644
--- a/drivers/mfd/sh_mobile_sdhi.c
+++ b/drivers/mfd/sh_mobile_sdhi.c
@@ -107,6 +107,15 @@ static int __init sh_mobile_sdhi_probe(struct platform=
_device *pdev)
        mmc_data->hclk =3D clk_get_rate(priv->clk);
        mmc_data->set_pwr =3D sh_mobile_sdhi_set_pwr;
        mmc_data->capabilities =3D MMC_CAP_MMC_HIGHSPEED;
+
+       /* values are taken from the firmware based sh_sdhi.c driver */
+       mmc_data->max_hw_segs   =3D 32;
+       mmc_data->max_phys_segs =3D 32;
+       mmc_data->max_blk_count =3D 65535; /* actually it's 65536, but the =
value 65536 is handled differently and we want to keep the code simple */
+       mmc_data->max_req_size  =3D 131072;
+       mmc_data->max_seg_size  =3D mmc_data->max_req_size;
+       mmc_data->max_blk_size  =3D mmc_data->max_blk_size;
+
        if (p) {
                mmc_data->flags =3D p->tmio_flags;
                mmc_data->ocr_mask =3D p->tmio_ocr_mask;
diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index ee7d0a5..cdb3a6a 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -847,6 +847,20 @@ static int __devinit tmio_mmc_probe(struct platform_de=
vice *dev)
        mmc->caps |=3D pdata->capabilities;
        mmc->f_max =3D pdata->hclk;
        mmc->f_min =3D mmc->f_max / 512;
+
+       if (pdata->max_hw_segs)
+               mmc->max_hw_segs =3D pdata->max_hw_segs;
+       if (pdata->max_phys_segs)
+               mmc->max_phys_segs =3D pdata->max_phys_segs;
+       if (pdata->max_seg_size)
+               mmc->max_seg_size =3D pdata->max_seg_size;
+       if (pdata->max_req_size)
+               mmc->max_req_size =3D pdata->max_req_size;
+       if (pdata->max_blk_size)
+               mmc->max_blk_size =3D pdata->max_blk_size;
+       if (pdata->max_blk_count)
+               mmc->max_blk_count =3D pdata->max_blk_count;
+
        if (pdata->ocr_mask)
                mmc->ocr_avail =3D pdata->ocr_mask;
        else
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index f07425b..4eb7358 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -71,6 +71,15 @@ struct tmio_mmc_data {
        unsigned long                   capabilities;
        unsigned long                   flags;
        u32                             ocr_mask;       /* available voltag=
es */
+
+       /* overrides for "struct mmc_host" variables */
+       unsigned int            max_seg_size;
+       unsigned short          max_hw_segs;
+       unsigned short          max_phys_segs;
+       unsigned int            max_req_size;
+       unsigned int            max_blk_size;
+       unsigned int            max_blk_count;
+
        struct tmio_mmc_dma             *dma;
        void (*set_pwr)(struct platform_device *host, int state);
        void (*set_clk_div)(struct platform_device *host, int state);
--
1.7.0.4


_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or other=
wise confidential information.
- If you have received this e-mail in error, you are hereby notified that a=
ny review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.

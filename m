From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 03:08:34 +0000
Subject: Re: [PATCH v2 1/4] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <20130423.120834.239982915.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <201304200231.31802.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304200231.31802.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sergei.shtylyov@cogentembedded.com
Cc: g.liakhovetski@gmx.de, mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com, vladimir.barinov@cogentembedded.com, mukawa@igel.co.jp


Hi Sergei,

Thanks for the patch.

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 20 Apr 2013 02:31:31 +0400

> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>=20
> Add Renesas R-Car VIN (Video In) V4L2 driver.
>=20
> Based on the patch by Phil Edworthy <phil.edworthy@renesas.com>.
>=20
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> [Sergei: removed deprecated IRQF_DISABLED flag.]
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>=20
> ---
> Changes since the original posting:
> - added IRQF_SHARED flag in devm_request_irq() call (since on R8A7778 VIN=
0/1
>   share the same IRQ) and removed deprecated IRQF_DISABLED flag.
>=20
>  drivers/media/platform/soc_camera/Kconfig    |    7=20
>  drivers/media/platform/soc_camera/Makefile   |    1=20
>  drivers/media/platform/soc_camera/rcar_vin.c | 1784 ++++++++++++++++++++=
+++++++
>  include/linux/platform_data/camera-rcar.h    |   25=20
>  4 files changed, 1817 insertions(+)
>=20
> Index: renesas/drivers/media/platform/soc_camera/Kconfig
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- renesas.orig/drivers/media/platform/soc_ca=
mera/Kconfig
> +++ renesas/drivers/media/platform/soc_camera/Kconfig
> @@ -45,6 +45,13 @@ config VIDEO_PXA27x
>  	---help---
>  	  This is a v4l2 driver for the PXA27x Quick Capture Interface
> =20
> +config VIDEO_RCAR_VIN
> +	tristate "R-Car Video Input (VIN) support"
> +	depends on VIDEO_DEV && SOC_CAMERA && (ARCH_R8A7778 || ARCH_R8A7779)
> +	select VIDEOBUF2_DMA_CONTIG
> +	---help---
> +	  This is a v4l2 driver for the R-Car VIN Interface
> +
>  config VIDEO_SH_MOBILE_CSI2
>  	tristate "SuperH Mobile MIPI CSI-2 Interface driver"
>  	depends on VIDEO_DEV && SOC_CAMERA && HAVE_CLK
> Index: renesas/drivers/media/platform/soc_camera/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- renesas.orig/drivers/media/platform/soc_ca=
mera/Makefile
> +++ renesas/drivers/media/platform/soc_camera/Makefile
> @@ -10,5 +10,6 @@ obj-$(CONFIG_VIDEO_OMAP1)		+=3D omap1_came
>  obj-$(CONFIG_VIDEO_PXA27x)		+=3D pxa_camera.o
>  obj-$(CONFIG_VIDEO_SH_MOBILE_CEU)	+=3D sh_mobile_ceu_camera.o
>  obj-$(CONFIG_VIDEO_SH_MOBILE_CSI2)	+=3D sh_mobile_csi2.o
> +obj-$(CONFIG_VIDEO_RCAR_VIN)		+=3D rcar_vin.o
> =20
>  ccflags-y +=3D -I$(srctree)/drivers/media/i2c/soc_camera
> Index: renesas/drivers/media/platform/soc_camera/rcar_vin.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null
> +++ renesas/drivers/media/platform/soc_camera/rcar_vin.c
> @@ -0,0 +1,1784 @@
> +/*
> + * SoC-camera host driver for Renesas R-Car VIN unit
> + *
> + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> + *
> + * Based on V4L2 Driver for SuperH Mobile CEU interface "sh_mobile_ceu_c=
amera.c"
> + *
> + * Copyright (C) 2008 Magnus Damm
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_data/camera-rcar.h>
> +
> +#include <media/videobuf2-dma-contig.h>
> +#include <media/soc_camera.h>
> +#include <media/soc_mediabus.h>
> +
> +#define DRV_NAME "rcar_vin"
> +
> +/* Register offsets for R-=F3ar VIN */

Are you using a 2-byte character in the string 'R-Car'?

> +#define VNMC_REG	0x00	/* Video n Main Control Register */
> +#define VNMS_REG	0x04	/* Video n Module Status Register */
> +#define VNFC_REG	0x08	/* Video n Frame Capture Register */
> +#define VNSLPRC_REG	0x0C	/* Video n Start Line Pre-Clip Register */
> +#define VNELPRC_REG	0x10	/* Video n End Line Pre-Clip Register */
> +#define VNSPPRC_REG	0x14	/* Video n Start Pixel Pre-Clip Register */
> +#define VNEPPRC_REG	0x18	/* Video n End Pixel Pre-Clip Register */
> +#define VNSLPOC_REG	0x1C	/* Video n Start Line Post-Clip Register */
> +#define VNELPOC_REG	0x20	/* Video n End Line Post-Clip Register */
> +#define VNSPPOC_REG	0x24	/* Video n Start Pixel Post-Clip Register */
> +#define VNEPPOC_REG	0x28	/* Video n End Pixel Post-Clip Register */
> +#define VNIS_REG	0x2C	/* Video n Image Stride Register */
> +#define VNMB_REG(m)	(0x30 + ((m) << 2)) /* Video n Memory Base m Registe=
r */
> +#define VNIE_REG	0x40	/* Video n Interrupt Enable Register */
> +#define VNINTS_REG	0x44	/* Video n Interrupt Status Register */
> +#define VNSI_REG	0x48	/* Video n Scanline Interrupt Register */
> +#define VNMTC_REG	0x4C	/* Video n Memory Transfer Control Register */
> +#define VNYS_REG	0x50	/* Video n Y Scale Register */
> +#define VNXS_REG	0x54	/* Video n X Scale Register */
> +#define VNDMR_REG	0x58	/* Video n Data Mode Register */
> +#define VNDMR2_REG	0x5C	/* Video n Data Mode Register 2 */
> +#define VNUVAOF_REG	0x60	/* Video n UV Address Offset Register */
> +
> +/* Register bit fields for R-=F3ar VIN */

s/R-=F3ar/R-Car/

> +/* Video n Main Control Register bits */
> +#define VNMC_FOC		(1 << 21)
> +#define VNMC_YCAL		(1 << 19)
> +#define VNMC_INF_YUV8_BT656	(0 << 16)
> +#define VNMC_INF_YUV8_BT601	(1 << 16)
> +#define VNMC_INF_YUV16		(5 << 16)
> +#define VNMC_VUP		(1 << 10)
> +#define VNMC_IM_ODD		(0 << 3)
> +#define VNMC_IM_ODD_EVEN	(1 << 3)
> +#define VNMC_IM_EVEN		(2 << 3)
> +#define VNMC_IM_FULL		(3 << 3)
> +#define VNMC_BPS		(1 << 1)
> +#define VNMC_ME			(1 << 0)
> +
> +/* Video n Module Status Register bits */
> +#define VNMS_FBS_MASK		(3 << 3)
> +#define VNMS_FBS_SHIFT		3
> +#define VNMS_AV			(1 << 1)
> +#define VNMS_CA			(1 << 0)
> +
> +/* Video n Frame Capture Register bits */
> +#define VNFC_C_FRAME		(1 << 1)
> +#define VNFC_S_FRAME		(1 << 0)
> +
> +/* Video n Interrupt Enable Register bits */
> +#define VNIE_FIE		(1 << 4)
> +#define VNIE_EFE		(1 << 1)
> +
> +/* Video n Data Mode Register bits */
> +#define VNDMR_EXRGB		(1 << 8)
> +#define VNDMR_BPSM		(1 << 4)
> +#define VNDMR_DTMD_YCSEP	(1 << 1)
> +#define VNDMR_DTMD_ARGB1555	(1 << 0)
> +
> +/* Video n Data Mode Register 2 bits */
> +#define VNDMR2_VPS		(1 << 30)
> +#define VNDMR2_HPS		(1 << 29)
> +#define VNDMR2_FTEV		(1 << 17)
> +
> +#define VIN_MAX_WIDTH		2048
> +#define VIN_MAX_HEIGHT		2048
> +
> +enum rcar_vin_state {
> +	STOPPED =3D 0,
> +	RUNNING,
> +	STOPPING,
> +};
> +
> +struct rcar_vin_priv {
> +	void __iomem			*base;
> +	spinlock_t			lock;
> +	int				sequence;
> +	/* State of the VIN module in capturing mode */
> +	enum rcar_vin_state		state;
> +	struct rcar_vin_platform_data	*pdata;
> +	struct soc_camera_host		ici;
> +	struct soc_camera_device	*icd;
> +	struct list_head		capture;
> +#define MAX_BUFFER_NUM			3
> +	struct vb2_buffer		*queue_buf[MAX_BUFFER_NUM];
> +	struct vb2_alloc_ctx		*alloc_ctx;
> +	enum v4l2_field			field;
> +	bool				data_through;
> +	unsigned int			vb_count;
> +	unsigned int			nr_hw_slots;
> +	bool				request_to_stop;
> +	struct completion		capture_stop;
> +};
> +
> +#define is_continuous_transfer(priv)	(priv->vb_count > MAX_BUFFER_NUM ? \
> +					 true : false)
> +
> +struct rcar_vin_buffer {
> +	struct vb2_buffer		vb;
> +	struct list_head		list;
> +};
> +
> +#define to_buf_list(vb2_buffer)		(&(container_of((vb2_buffer), \
> +						struct rcar_vin_buffer, \
> +						vb))->list)
> +
> +struct rcar_vin_cam {
> +	/* VIN offsets within the camera output, before the VIN scaler */
> +	unsigned int			vin_left;
> +	unsigned int			vin_top;
> +	/* Client output, as seen by the VIN */
> +	unsigned int			width;
> +	unsigned int			height;
> +	/*
> +	 * User window from S_CROP / G_CROP, produced by client cropping and
> +	 * scaling, VIN scaling and VIN cropping, mapped back onto the client
> +	 * input window
> +	 */
> +	struct v4l2_rect		subrect;
> +	/* Camera cropping rectangle */
> +	struct v4l2_rect		rect;
> +	const struct soc_mbus_pixelfmt	*extra_fmt;
> +	enum v4l2_mbus_pixelcode	code;
> +};
> +
> +/*
> + * .queue_setup() is called to check whether the driver can accept the
> + *		  requested number of buffers and to fill in plane sizes
> + *		  for the current frame format if required
> + */
> +static int rcar_vin_videobuf_setup(struct vb2_queue *vq,
> +				   const struct v4l2_format *fmt,
> +				   unsigned int *count,
> +				   unsigned int *num_planes,
> +				   unsigned int sizes[], void *alloc_ctxs[])
> +{
> +	struct soc_camera_device *icd =3D soc_camera_from_vb2q(vq);
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	s32 bytes_per_line;
> +	unsigned int height;
> +
> +	if (fmt) {
> +		const struct soc_camera_format_xlate *xlate;
> +
> +		xlate =3D soc_camera_xlate_by_fourcc(icd,
> +						   fmt->fmt.pix.pixelformat);
> +		if (!xlate)
> +			return -EINVAL;
> +		bytes_per_line =3D soc_mbus_bytes_per_line(fmt->fmt.pix.width,
> +							 xlate->host_fmt);
> +		height =3D fmt->fmt.pix.height;
> +	} else {
> +		/* Called from VIDIOC_REQBUFS or in compatibility mode */
> +		bytes_per_line =3D soc_mbus_bytes_per_line(icd->user_width,
> +						icd->current_fmt->host_fmt);
> +		height =3D icd->user_height;
> +	}
> +	if (bytes_per_line < 0)
> +		return bytes_per_line;
> +
> +	sizes[0] =3D bytes_per_line * height;
> +	alloc_ctxs[0] =3D priv->alloc_ctx;
> +
> +	if (!vq->num_buffers)
> +		priv->sequence =3D 0;
> +
> +	if (!*count)
> +		*count =3D 2;
> +	priv->vb_count =3D *count;
> +
> +	*num_planes =3D 1;
> +
> +	/* Number of hardware slots */
> +	if (priv->vb_count > MAX_BUFFER_NUM)

You can use the is_continuous_transfer() macro here.

> +		priv->nr_hw_slots =3D MAX_BUFFER_NUM;
> +	else
> +		priv->nr_hw_slots =3D 1;
> +
> +	dev_dbg(icd->parent, "count=3D%d, size=3D%u\n", *count, sizes[0]);
> +
> +	return 0;
> +}
> +
> +static void rcar_vin_setup(struct rcar_vin_priv *priv)
> +{
> +	struct soc_camera_device *icd =3D priv->icd;
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	u32 vnmc, dmr, interrupts;
> +	int progressive =3D 0, input_is_yuv =3D 0, output_is_yuv =3D 0;
> +
> +	switch (priv->field) {
> +	case V4L2_FIELD_TOP:
> +		vnmc =3D VNMC_IM_ODD;
> +		break;
> +	case V4L2_FIELD_BOTTOM:
> +		vnmc =3D VNMC_IM_EVEN;
> +		break;
> +	case V4L2_FIELD_INTERLACED:
> +	case V4L2_FIELD_INTERLACED_TB:
> +		vnmc =3D VNMC_IM_FULL;
> +		break;
> +	case V4L2_FIELD_INTERLACED_BT:
> +		vnmc =3D VNMC_IM_FULL | VNMC_FOC;
> +		break;
> +	case V4L2_FIELD_NONE:
> +		if (is_continuous_transfer(priv)) {
> +			vnmc =3D VNMC_IM_ODD_EVEN;
> +			progressive =3D 1;
> +		} else
> +			vnmc =3D VNMC_IM_ODD;
> +		break;
> +	default:
> +		vnmc =3D VNMC_IM_ODD;
> +		break;
> +	}
> +
> +	/* input interface */
> +	switch (icd->current_fmt->code) {
> +	case V4L2_MBUS_FMT_YUYV8_1X16:
> +		/* BT.601/BT.1358 16bit YCbCr422 */
> +		vnmc |=3D VNMC_INF_YUV16;
> +		input_is_yuv =3D 1;
> +		break;
> +	case V4L2_MBUS_FMT_YUYV8_2X8:
> +		input_is_yuv =3D 1;
> +		/* BT.656 8bit YCbCr422 or BT.601 8bit YCbCr422 */
> +		vnmc |=3D priv->pdata->flags & RCAR_VIN_BT656 ?
> +			VNMC_INF_YUV8_BT656 : VNMC_INF_YUV8_BT601;
> +	default:
> +		break;
> +	}

Does this (first) implemenation unsupport RGB inputs yet
though the h/w supports them?
If so, 'is_input_yuv' could be useless since it must
be set to 1 in any case.

> +
> +	/* output format */
> +	switch (icd->current_fmt->host_fmt->fourcc) {
> +	case V4L2_PIX_FMT_NV16:
> +		iowrite32(((cam->width * cam->height) + 0x7f) & ~0x7f,
> +			  priv->base + VNUVAOF_REG);
> +		dmr =3D VNDMR_DTMD_YCSEP;
> +		output_is_yuv =3D 1;
> +		break;
> +	case V4L2_PIX_FMT_YUYV:
> +		dmr =3D VNDMR_BPSM;
> +		output_is_yuv =3D 1;
> +		break;
> +	case V4L2_PIX_FMT_UYVY:
> +		dmr =3D 0;
> +		output_is_yuv =3D 1;
> +		break;
> +	case V4L2_PIX_FMT_RGB555X:
> +		dmr =3D VNDMR_DTMD_ARGB1555;
> +		break;
> +	case V4L2_PIX_FMT_RGB565:
> +		dmr =3D 0;
> +		break;
> +	case V4L2_PIX_FMT_RGB32:
> +		dmr =3D VNDMR_EXRGB;
> +		break;

VIN in R8A7778(R-CarM1A) does not support the RGB32 output,
but R8A7779(R-CarH1) and uPD35004(R-CarE1) ones support it.
=20
> +	default:
> +		dev_warn(icd->parent, "Invalid fourcc format (0x%x)\n",
> +			 icd->current_fmt->host_fmt->fourcc);
> +		dmr =3D ioread32(priv->base + VNDMR_REG);
> +		vnmc =3D ioread32(priv->base + VNMC_REG);
> +		break;
> +	}
> +
> +	/* Always update on field change */
> +	vnmc |=3D VNMC_VUP;
> +
> +	/* If input and output use the same colorspace, use bypass mode */
> +	if (input_is_yuv =3D output_is_yuv)
> +		vnmc |=3D VNMC_BPS;
> +
> +	/* progressive or interlaced mode */
> +	interrupts =3D progressive ? VNIE_FIE | VNIE_EFE : VNIE_EFE;
> +
> +	/* ack interrupts */
> +	iowrite32(interrupts, priv->base + VNINTS_REG);
> +	/* enable interrupts */
> +	iowrite32(interrupts, priv->base + VNIE_REG);
> +	/* start capturing */
> +	iowrite32(dmr, priv->base + VNDMR_REG);
> +	iowrite32(vnmc | VNMC_ME, priv->base + VNMC_REG);
> +}
> +
> +static void rcar_vin_capture(struct rcar_vin_priv *priv)
> +{
> +	if (is_continuous_transfer(priv))
> +		/* Continuous Frame Capture Mode */
> +		iowrite32(VNFC_C_FRAME, priv->base + VNFC_REG);
> +	else
> +		/* Single Frame Capture Mode */
> +		iowrite32(VNFC_S_FRAME, priv->base + VNFC_REG);
> +}
> +
> +static void rcar_vin_request_capture_stop(struct rcar_vin_priv *priv)
> +{
> +	priv->state =3D STOPPING;
> +
> +	/* set continuous & single transfer off */
> +	iowrite32(0, priv->base + VNFC_REG);
> +	/* disable capture (release DMA buffer), reset */
> +	iowrite32(ioread32(priv->base + VNMC_REG) & ~VNMC_ME,
> +		  priv->base + VNMC_REG);
> +
> +	/* update the status if stopped already */
> +	if (!(ioread32(priv->base + VNMS_REG) & VNMS_CA))
> +		priv->state =3D STOPPED;
> +}
> +
> +static int rcar_vin_get_free_hw_slot(struct rcar_vin_priv *priv)
> +{
> +	int slot;
> +
> +	for (slot =3D 0; slot < priv->nr_hw_slots; slot++)
> +		if (priv->queue_buf[slot] =3D NULL)
> +			return slot;
> +
> +	return -1;
> +}
> +
> +static int rcar_vin_hw_ready(struct rcar_vin_priv *priv)
> +{
> +	/* Ensure all HW slots are filled */
> +	return rcar_vin_get_free_hw_slot(priv) < 0 ? 1 : 0;
> +}
> +
> +/* Moves a buffer from the queue to the HW slots */
> +static int rcar_vin_fill_hw_slot(struct rcar_vin_priv *priv)
> +{
> +	struct vb2_buffer *vb;
> +	dma_addr_t phys_addr_top;
> +	int slot;
> +
> +	if (list_empty(&priv->capture))
> +		return 0;
> +
> +	/* Find a free HW slot */
> +	slot =3D rcar_vin_get_free_hw_slot(priv);
> +	if (slot < 0)
> +		return 0;
> +
> +	vb =3D &list_entry(priv->capture.next, struct rcar_vin_buffer, list)->v=
b;
> +	list_del_init(to_buf_list(vb));
> +	priv->queue_buf[slot] =3D vb;
> +	phys_addr_top =3D vb2_dma_contig_plane_dma_addr(vb, 0);
> +	iowrite32(phys_addr_top, priv->base + VNMB_REG(slot));
> +
> +	return 1;
> +}
> +
> +static void rcar_vin_videobuf_queue(struct vb2_buffer *vb)
> +{
> +	struct soc_camera_device *icd =3D soc_camera_from_vb2q(vb->vb2_queue);
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	unsigned long size;
> +	unsigned long flags;
> +	int bytes_per_line;
> +
> +	bytes_per_line =3D soc_mbus_bytes_per_line(icd->user_width,
> +						 icd->current_fmt->host_fmt);
> +	if (bytes_per_line < 0)
> +		goto error;
> +
> +	size =3D icd->user_height * bytes_per_line;
> +
> +	if (vb2_plane_size(vb, 0) < size) {
> +		dev_err(icd->parent, "Buffer #%d too small (%lu < %lu)\n",
> +			vb->v4l2_buf.index, vb2_plane_size(vb, 0), size);
> +		goto error;
> +	}
> +
> +	vb2_set_plane_payload(vb, 0, size);
> +
> +	dev_dbg(icd->parent, "%s (vb=3D0x%p) 0x%p %lu\n", __func__,
> +		vb, vb2_plane_vaddr(vb, 0), vb2_get_plane_payload(vb, 0));
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	list_add_tail(to_buf_list(vb), &priv->capture);
> +	rcar_vin_fill_hw_slot(priv);
> +
> +	/* If we weren't running, and have enough buffers, start capturing! */
> +	if (priv->state !=3D RUNNING && rcar_vin_hw_ready(priv)) {
> +		priv->request_to_stop =3D false;
> +		init_completion(&priv->capture_stop);
> +		priv->state =3D RUNNING;
> +		rcar_vin_setup(priv);
> +		rcar_vin_capture(priv);
> +	}
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return;
> +
> +error:
> +	vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
> +}
> +
> +static void rcar_vin_videobuf_release(struct vb2_buffer *vb)
> +{
> +	struct soc_camera_device *icd =3D soc_camera_from_vb2q(vb->vb2_queue);
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	unsigned int i;
> +	unsigned long flags;
> +	int buf_in_use =3D 0;
> +
> +	spin_lock_irqsave(&priv->lock, flags);
> +
> +	/* Is the buffer in use by the VIN hardware? */
> +	for (i =3D 0; i < MAX_BUFFER_NUM; i++) {
> +		if (priv->queue_buf[i] =3D vb) {
> +			buf_in_use =3D 1;
> +			break;
> +		}
> +	}
> +
> +	if (buf_in_use) {
> +		while (priv->state !=3D STOPPED) {
> +
> +			/* issue stop if running */
> +			if (priv->state =3D RUNNING)
> +				rcar_vin_request_capture_stop(priv);
> +
> +			/* wait until capturing has been stopped */
> +			if (priv->state =3D STOPPING) {
> +				priv->request_to_stop =3D true;
> +				spin_unlock_irqrestore(&priv->lock, flags);
> +				wait_for_completion(&priv->capture_stop);
> +				spin_lock_irqsave(&priv->lock, flags);
> +			}
> +		}
> +		/*
> +		 * Capturing has now stopped. The buffer we have been asked
> +		 * to release could be any of the current buffers in use, so
> +		 * release all buffers that are in use by HW
> +		 */
> +		for (i =3D 0; i < MAX_BUFFER_NUM; i++) {
> +			if (priv->queue_buf[i]) {
> +				vb2_buffer_done(priv->queue_buf[i],
> +					VB2_BUF_STATE_ERROR);
> +				priv->queue_buf[i] =3D NULL;
> +			}
> +		}
> +	} else if (to_buf_list(vb)->next)
> +		list_del_init(to_buf_list(vb));
> +
> +	spin_unlock_irqrestore(&priv->lock, flags);
> +}
> +
> +static int rcar_vin_videobuf_init(struct vb2_buffer *vb)
> +{
> +	INIT_LIST_HEAD(to_buf_list(vb));
> +	return 0;
> +}
> +
> +static int rcar_vin_stop_streaming(struct vb2_queue *vq)
> +{
> +	struct soc_camera_device *icd =3D soc_camera_from_vb2q(vq);
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	struct list_head *buf_head, *tmp;
> +
> +	spin_lock_irq(&priv->lock);
> +	list_for_each_safe(buf_head, tmp, &priv->capture)
> +		list_del_init(buf_head);
> +	spin_unlock_irq(&priv->lock);
> +
> +	return 0;
> +}
> +
> +static struct vb2_ops rcar_vin_vb2_ops =3D {
> +	.queue_setup	=3D rcar_vin_videobuf_setup,
> +	.buf_init	=3D rcar_vin_videobuf_init,
> +	.buf_cleanup	=3D rcar_vin_videobuf_release,
> +	.buf_queue	=3D rcar_vin_videobuf_queue,
> +	.stop_streaming	=3D rcar_vin_stop_streaming,
> +	.wait_prepare	=3D soc_camera_unlock,
> +	.wait_finish	=3D soc_camera_lock,
> +};
> +
> +static irqreturn_t rcar_vin_irq(int irq, void *data)
> +{
> +	struct rcar_vin_priv *priv =3D data;
> +	u32 int_status;
> +	bool can_run =3D false, hw_stopped;
> +	int slot;
> +	unsigned int handled =3D 0;
> +
> +	spin_lock(&priv->lock);
> +
> +	int_status =3D ioread32(priv->base + VNINTS_REG);
> +	if (!int_status)
> +		goto done;
> +	/* ack interrupts */
> +	iowrite32(int_status, priv->base + VNINTS_REG);
> +	handled =3D 1;
> +
> +	/* nothing to do if capture status is 'STOPPED' */
> +	if (priv->state =3D STOPPED)
> +		goto done;
> +
> +	hw_stopped =3D !(ioread32(priv->base + VNMS_REG) & VNMS_CA);
> +
> +	if (!priv->request_to_stop) {
> +		if (is_continuous_transfer(priv))
> +			slot =3D (ioread32(priv->base + VNMS_REG) &
> +				VNMS_FBS_MASK) >> VNMS_FBS_SHIFT;
> +		else
> +			slot =3D 0;
> +
> +		priv->queue_buf[slot]->v4l2_buf.field =3D priv->field;
> +		priv->queue_buf[slot]->v4l2_buf.sequence =3D priv->sequence++;
> +		do_gettimeofday(&priv->queue_buf[slot]->v4l2_buf.timestamp);
> +		vb2_buffer_done(priv->queue_buf[slot], VB2_BUF_STATE_DONE);
> +		priv->queue_buf[slot] =3D NULL;
> +
> +		if (priv->state !=3D STOPPING)
> +			can_run =3D rcar_vin_fill_hw_slot(priv);
> +
> +		if (hw_stopped || !can_run)
> +			priv->state =3D STOPPED;

The continuous capturing should require an explicit stop
operation when there is no buffer to be set into the MBx
register because the h/w can keep running even if no more
buffers are supplied.

> +		else
> +			rcar_vin_capture(priv);
> +
> +	} else if (hw_stopped) {
> +		priv->state =3D STOPPED;
> +		priv->request_to_stop =3D false;
> +		complete(&priv->capture_stop);
> +	}
> +
> +done:
> +	spin_unlock(&priv->lock);
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +static int rcar_vin_add_device(struct soc_camera_device *icd)
> +{
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	int i;
> +
> +	if (priv->icd)
> +		return -EBUSY;
> +
> +	for (i =3D 0; i < MAX_BUFFER_NUM; i++)
> +		priv->queue_buf[i] =3D NULL;
> +
> +	pm_runtime_get_sync(ici->v4l2_dev.dev);
> +	priv->icd =3D icd;
> +
> +	dev_dbg(icd->parent, "R-Car VIN driver attached to camera %d\n",
> +		icd->devnum);
> +
> +	return 0;
> +}
> +
> +static void rcar_vin_remove_device(struct soc_camera_device *icd)
> +{
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	struct vb2_buffer *vb;
> +	int i;
> +
> +	BUG_ON(icd !=3D priv->icd);
> +
> +	/* disable capture, disable interrupts */
> +	iowrite32(ioread32(priv->base + VNMC_REG) & ~VNMC_ME,
> +		  priv->base + VNMC_REG);
> +	iowrite32(0, priv->base + VNIE_REG);
> +
> +	priv->state =3D STOPPED;
> +	priv->request_to_stop =3D false;
> +
> +	/* make sure active buffer is cancelled */
> +	spin_lock_irq(&priv->lock);
> +	for (i =3D 0; i < MAX_BUFFER_NUM; i++) {
> +		vb =3D priv->queue_buf[i];
> +		if (vb) {
> +			list_del_init(to_buf_list(vb));
> +			vb2_buffer_done(vb, VB2_BUF_STATE_ERROR);
> +			vb =3D NULL;
> +		}
> +	}
> +	spin_unlock_irq(&priv->lock);
> +
> +	pm_runtime_put_sync(ici->v4l2_dev.dev);
> +	priv->icd =3D NULL;
> +
> +	dev_dbg(icd->parent, "R-Car VIN driver detached from camera %d\n",
> +		icd->devnum);
> +}
> +
> +static unsigned int size_dst(unsigned int src, unsigned int scale)
> +{
> +	unsigned int mant_pre =3D scale >> 12;
> +
> +	if (!src || !scale)
> +		return src;
> +	return ((mant_pre + 2 * (src - 1)) / (2 * mant_pre) - 1) *
> +		(mant_pre << 12) / scale + 1;
> +}
> +
> +static u16 calc_scale(unsigned int src, unsigned int *dst)
> +{
> +	u16 scale;
> +
> +	if (src =3D *dst)
> +		return 0;
> +
> +	scale =3D (src * 4096 / *dst) & ~7;
> +
> +	while (scale > 4096 && size_dst(src, scale) < *dst)
> +		scale -=3D 8;
> +
> +	*dst =3D size_dst(src, scale);
> +
> +	return scale;
> +}
> +
> +/* rect is guaranteed to not exceed the scaled camera rectangle */
> +static int rcar_vin_set_rect(struct soc_camera_device *icd)
> +{
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	unsigned int left_offset, top_offset;
> +	unsigned char dsize;
> +	struct v4l2_rect *cam_subrect =3D &cam->subrect;
> +
> +	dev_dbg(icd->parent, "Crop %ux%u@%u:%u\n",
> +		icd->user_width, icd->user_height, cam->vin_left, cam->vin_top);
> +
> +	left_offset =3D cam->vin_left;
> +	top_offset =3D cam->vin_top;
> +
> +	dsize =3D priv->data_through ? true : false;
> +
> +	dev_dbg(icd->parent, "Cam %ux%u@%u:%u\n",
> +		cam->width, cam->height, cam->vin_left, cam->vin_top);
> +	dev_dbg(icd->parent, "Cam subrect %ux%u@%u:%u\n",
> +		cam_subrect->width, cam_subrect->height,
> +		cam_subrect->left, cam_subrect->top);
> +
> +	/* Set Start/End Pixel/Line Pre-Clip */
> +	iowrite32(left_offset << dsize, priv->base + VNSPPRC_REG);
> +	iowrite32((left_offset + cam->width - 1) << dsize,
> +		  priv->base + VNEPPRC_REG);

The 'data through' mode could exist only in R-CarE1's VIN.
So values for clipping do not have to be doubled
in case of M1A and H1.

> +	switch (priv->field) {
> +	case V4L2_FIELD_INTERLACED:
> +	case V4L2_FIELD_INTERLACED_TB:
> +	case V4L2_FIELD_INTERLACED_BT:
> +		iowrite32(top_offset / 2, priv->base + VNSLPRC_REG);
> +		iowrite32((top_offset + cam->height) / 2 - 1,
> +			  priv->base + VNELPRC_REG);
> +		break;
> +	default:
> +		iowrite32(top_offset, priv->base + VNSLPRC_REG);
> +		iowrite32(top_offset + cam->height - 1,
> +			  priv->base + VNELPRC_REG);
> +		break;
> +	}
> +
> +	/* Set Start/End Pixel/Line Post-Clip */
> +	iowrite32(0, priv->base + VNSPPOC_REG);
> +	iowrite32(0, priv->base + VNSLPOC_REG);
> +	iowrite32((cam_subrect->width - 1) << dsize, priv->base + VNEPPOC_REG);
> +	switch (priv->field) {
> +	case V4L2_FIELD_INTERLACED:
> +	case V4L2_FIELD_INTERLACED_TB:
> +	case V4L2_FIELD_INTERLACED_BT:
> +		iowrite32(cam_subrect->height / 2 - 1,
> +			  priv->base + VNELPOC_REG);
> +		break;
> +	default:
> +		iowrite32(cam_subrect->height - 1, priv->base + VNELPOC_REG);
> +		break;
> +	}
> +
> +	iowrite32((cam->width + 0xf) & ~0xf, priv->base + VNIS_REG);
> +
> +	return 0;
> +}
> +
> +static void capture_stop_preserve(struct rcar_vin_priv *priv, u32 *vnmc)
> +{
> +	*vnmc =3D ioread32(priv->base + VNMC_REG);
> +	/* module disable */
> +	iowrite32(*vnmc & ~VNMC_ME, priv->base + VNMC_REG);
> +}
> +
> +static void capture_restore(struct rcar_vin_priv *priv, u32 vnmc)
> +{
> +	unsigned long timeout =3D jiffies + 10 * HZ;
> +
> +	if (!(vnmc & ~VNMC_ME))
> +		/* Nothing to restore */
> +		return;
> +
> +	/*
> +	 * Wait until the end of the current frame. It can take a long time,
> +	 * but if it has been aborted by a MRST1 reset, it should exit sooner.
> +	 */
> +	while ((ioread32(priv->base + VNMS_REG) & VNMS_AV) &&
> +		time_before(jiffies, timeout))
> +		msleep(1);
> +
> +	if (time_after(jiffies, timeout)) {
> +		dev_err(priv->ici.v4l2_dev.dev,
> +			"Timeout waiting for frame end! Interface problem?\n");
> +		return;
> +	}
> +
> +	iowrite32(vnmc, priv->base + VNMC_REG);
> +}
> +
> +#define VIN_MBUS_FLAGS	(V4L2_MBUS_MASTER |		\
> +			 V4L2_MBUS_PCLK_SAMPLE_RISING |	\
> +			 V4L2_MBUS_HSYNC_ACTIVE_HIGH |	\
> +			 V4L2_MBUS_HSYNC_ACTIVE_LOW |	\
> +			 V4L2_MBUS_VSYNC_ACTIVE_HIGH |	\
> +			 V4L2_MBUS_VSYNC_ACTIVE_LOW |	\
> +			 V4L2_MBUS_DATA_ACTIVE_HIGH)
> +
> +static int rcar_vin_set_bus_param(struct soc_camera_device *icd)
> +{
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct v4l2_mbus_config cfg =3D {.type =3D V4L2_MBUS_PARALLEL,};
> +	unsigned long common_flags;
> +	u32 vnmc;
> +	u32 val;
> +	int ret;
> +
> +	capture_stop_preserve(priv, &vnmc);
> +
> +	ret =3D v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
> +	if (!ret) {
> +		common_flags =3D soc_mbus_config_compatible(&cfg, VIN_MBUS_FLAGS);
> +		if (!common_flags) {
> +			dev_warn(icd->parent,
> +				 "MBUS flags incompatible: camera 0x%x, host 0x%x\n",
> +				 cfg.flags, VIN_MBUS_FLAGS);
> +			return -EINVAL;
> +		}
> +	} else if (ret !=3D -ENOIOCTLCMD) {
> +		return ret;
> +	} else {
> +		common_flags =3D VIN_MBUS_FLAGS;
> +	}
> +
> +	/* Make choises, based on platform preferences */
> +	if ((common_flags & V4L2_MBUS_HSYNC_ACTIVE_HIGH) &&
> +	    (common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW)) {
> +		if (priv->pdata->flags & RCAR_VIN_HSYNC_ACTIVE_LOW)
> +			common_flags &=3D ~V4L2_MBUS_HSYNC_ACTIVE_HIGH;
> +		else
> +			common_flags &=3D ~V4L2_MBUS_HSYNC_ACTIVE_LOW;
> +	}
> +
> +	if ((common_flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH) &&
> +	    (common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW)) {
> +		if (priv->pdata->flags & RCAR_VIN_VSYNC_ACTIVE_LOW)
> +			common_flags &=3D ~V4L2_MBUS_VSYNC_ACTIVE_HIGH;
> +		else
> +			common_flags &=3D ~V4L2_MBUS_VSYNC_ACTIVE_LOW;
> +	}
> +
> +	cfg.flags =3D common_flags;
> +	ret =3D v4l2_subdev_call(sd, video, s_mbus_config, &cfg);
> +	if (ret < 0 && ret !=3D -ENOIOCTLCMD)
> +		return ret;
> +
> +	val =3D priv->field =3D V4L2_FIELD_NONE ? VNDMR2_FTEV : 0;
> +	if (!(common_flags & V4L2_MBUS_VSYNC_ACTIVE_LOW))
> +		val |=3D VNDMR2_VPS;
> +	if (!(common_flags & V4L2_MBUS_HSYNC_ACTIVE_LOW))
> +		val |=3D VNDMR2_HPS;
> +	iowrite32(val, priv->base + VNDMR2_REG);
> +
> +	ret =3D rcar_vin_set_rect(icd);
> +	if (ret < 0)
> +		return ret;
> +
> +	capture_restore(priv, vnmc);
> +
> +	return 0;
> +}
> +
> +static int rcar_vin_try_bus_param(struct soc_camera_device *icd,
> +				  unsigned char buswidth)
> +{
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct v4l2_mbus_config cfg =3D {.type =3D V4L2_MBUS_PARALLEL,};
> +	int ret;
> +
> +	ret =3D v4l2_subdev_call(sd, video, g_mbus_config, &cfg);
> +	if (ret =3D -ENOIOCTLCMD)
> +		return 0;
> +	else if (ret)
> +		return ret;
> +
> +	/* check is there common mbus flags */
> +	ret =3D soc_mbus_config_compatible(&cfg, VIN_MBUS_FLAGS);
> +	if (ret)
> +		return 0;
> +
> +	dev_warn(icd->parent,
> +		"MBUS flags incompatible: camera 0x%x, host 0x%x\n",
> +		 cfg.flags, VIN_MBUS_FLAGS);
> +
> +	return -EINVAL;
> +}
> +
> +static const struct soc_mbus_pixelfmt rcar_vin_formats[] =3D {
> +	{
> +		.fourcc			=3D V4L2_PIX_FMT_NV16,
> +		.name			=3D "NV16",
> +		.bits_per_sample	=3D 16,
> +		.packing		=3D SOC_MBUS_PACKING_NONE,
> +		.order			=3D SOC_MBUS_ORDER_LE,
> +	},
> +	{
> +		.fourcc			=3D V4L2_PIX_FMT_YUYV,
> +		.name			=3D "YUYV",
> +		.bits_per_sample	=3D 16,
> +		.packing		=3D SOC_MBUS_PACKING_NONE,
> +		.order			=3D SOC_MBUS_ORDER_LE,
> +	},
> +	{
> +		.fourcc			=3D V4L2_PIX_FMT_UYVY,
> +		.name			=3D "UYVY",
> +		.bits_per_sample	=3D 16,
> +		.packing		=3D SOC_MBUS_PACKING_NONE,
> +		.order			=3D SOC_MBUS_ORDER_LE,
> +	},
> +	{
> +		.fourcc			=3D V4L2_PIX_FMT_RGB565,
> +		.name			=3D "RGB565",
> +		.bits_per_sample	=3D 16,
> +		.packing		=3D SOC_MBUS_PACKING_NONE,
> +		.order			=3D SOC_MBUS_ORDER_LE,
> +	},
> +	{
> +		.fourcc			=3D V4L2_PIX_FMT_RGB555X,
> +		.name			=3D "ARGB1555",
> +		.bits_per_sample	=3D 16,
> +		.packing		=3D SOC_MBUS_PACKING_NONE,
> +		.order			=3D SOC_MBUS_ORDER_LE,
> +	},
> +	{
> +		.fourcc			=3D V4L2_PIX_FMT_RGB32,
> +		.name			=3D "RGB888",
> +		.bits_per_sample	=3D 32,
> +		.packing		=3D SOC_MBUS_PACKING_NONE,
> +		.order			=3D SOC_MBUS_ORDER_LE,
> +	},
> +};
> +
> +static int client_g_rect(struct v4l2_subdev *sd, struct v4l2_rect *rect);
> +
> +static int rcar_vin_get_formats(struct soc_camera_device *icd, unsigned =
int idx,
> +				struct soc_camera_format_xlate *xlate)
> +{
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct device *dev =3D icd->parent;
> +	int ret, k, n;
> +	int formats =3D 0;
> +	struct rcar_vin_cam *cam;
> +	enum v4l2_mbus_pixelcode code;
> +	const struct soc_mbus_pixelfmt *fmt;
> +
> +	ret =3D v4l2_subdev_call(sd, video, enum_mbus_fmt, idx, &code);
> +	if (ret < 0)
> +		return 0;
> +
> +	fmt =3D soc_mbus_get_fmtdesc(code);
> +	if (!fmt) {
> +		dev_err(icd->parent,
> +			"Invalid format code #%u: %d\n", idx, code);
> +		return -EINVAL;
> +	}
> +
> +	ret =3D rcar_vin_try_bus_param(icd, fmt->bits_per_sample);
> +	if (ret < 0)
> +		return 0;
> +
> +	if (!icd->host_priv) {
> +		struct v4l2_mbus_framefmt mf;
> +		struct v4l2_rect rect;
> +		struct device *dev =3D icd->parent;
> +		int shift;
> +
> +		/* Cache current client geometry */
> +		ret =3D client_g_rect(sd, &rect);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D v4l2_subdev_call(sd, video, g_mbus_fmt, &mf);
> +		if (ret < 0)
> +			return ret;
> +
> +		/*
> +		 * If sensor proposes too large format then try smaller ones:
> +		 * 1280x960, 640x480, 320x240
> +		 */
> +		for (shift =3D 0; shift < 3; shift++) {
> +			if (mf.width <=3D VIN_MAX_WIDTH &&
> +			    mf.height <=3D VIN_MAX_HEIGHT)
> +				break;
> +
> +			mf.width =3D 1280 >> shift;
> +			mf.height =3D 960 >> shift;
> +			ret =3D v4l2_device_call_until_err(sd->v4l2_dev,
> +							 soc_camera_grp_id(icd),
> +							 video, s_mbus_fmt,
> +							 &mf);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		if (shift =3D 3) {
> +			dev_err(dev,
> +				"Failed to configure the client below %ux%x\n",
> +				mf.width, mf.height);
> +			return -EIO;
> +		}
> +
> +		dev_dbg(dev, "camera fmt %ux%u\n", mf.width, mf.height);
> +
> +		cam =3D kzalloc(sizeof(*cam), GFP_KERNEL);
> +		if (!cam)
> +			return -ENOMEM;
> +		/*
> +		 * We are called with current camera crop,
> +		 * initialise subrect with it
> +		 */
> +		cam->rect =3D rect;
> +		cam->subrect =3D rect;
> +		cam->width =3D mf.width;
> +		cam->height =3D mf.height;
> +
> +		icd->host_priv =3D cam;
> +	} else {
> +		cam =3D icd->host_priv;
> +	}
> +
> +	/* Beginning of a pass */
> +	if (!idx)
> +		cam->extra_fmt =3D NULL;
> +
> +	switch (code) {
> +	case V4L2_MBUS_FMT_YUYV8_1X16:
> +	case V4L2_MBUS_FMT_YUYV8_2X8:
> +		if (cam->extra_fmt)
> +			break;
> +
> +		/* Add all our formats that can be generated by VIN */
> +		cam->extra_fmt =3D rcar_vin_formats;
> +
> +		n =3D ARRAY_SIZE(rcar_vin_formats);
> +		formats +=3D n;
> +		for (k =3D 0; xlate && k < n; k++, xlate++) {
> +			xlate->host_fmt =3D &rcar_vin_formats[k];
> +			xlate->code =3D code;
> +			dev_dbg(dev, "Providing format %s using code %d\n",
> +				rcar_vin_formats[k].name, code);
> +		}
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	return formats;
> +}
> +
> +static void rcar_vin_put_formats(struct soc_camera_device *icd)
> +{
> +	kfree(icd->host_priv);
> +	icd->host_priv =3D NULL;
> +}
> +
> +/* Check if any dimension of r1 is smaller than respective one of r2 */
> +static bool is_smaller(struct v4l2_rect *r1, struct v4l2_rect *r2)
> +{
> +	return r1->width < r2->width || r1->height < r2->height;
> +}
> +
> +/* Check if r1 fails to cover r2 */
> +static bool is_inside(struct v4l2_rect *r1, struct v4l2_rect *r2)
> +{
> +	return r1->left > r2->left || r1->top > r2->top ||
> +	       r1->left + r1->width < r2->left + r2->width ||
> +	       r1->top + r1->height < r2->top + r2->height;
> +}
> +
> +static unsigned int scale_down(unsigned int size, unsigned int scale)
> +{
> +	return (size * 4096 + scale / 2) / scale;
> +}
> +
> +static unsigned int calc_generic_scale(unsigned int input, unsigned int =
output)
> +{
> +	return (input * 4096 + output / 2) / output;
> +}
> +
> +/* Get and store current client crop */
> +static int client_g_rect(struct v4l2_subdev *sd, struct v4l2_rect *rect)
> +{
> +	struct v4l2_crop crop;
> +	struct v4l2_cropcap cap;
> +	int ret;
> +
> +	crop.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +
> +	ret =3D v4l2_subdev_call(sd, video, g_crop, &crop);
> +	if (!ret) {
> +		*rect =3D crop.c;
> +		return ret;
> +	}
> +
> +	/* Camera driver doesn't support .g_crop(), assume default rectangle */
> +	cap.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +
> +	ret =3D v4l2_subdev_call(sd, video, cropcap, &cap);
> +	if (!ret)
> +		*rect =3D cap.defrect;
> +
> +	return ret;
> +}
> +
> +/*
> + * Client crop has changed, update our sub-rectangle to remain within th=
e area
> + */
> +static void update_subrect(struct rcar_vin_cam *cam)
> +{
> +	struct v4l2_rect *rect =3D &cam->rect, *subrect =3D &cam->subrect;
> +
> +	if (rect->width < subrect->width)
> +		subrect->width =3D rect->width;
> +
> +	if (rect->height < subrect->height)
> +		subrect->height =3D rect->height;
> +
> +	if (rect->left > subrect->left)
> +		subrect->left =3D rect->left;
> +	else if (rect->left + rect->width > subrect->left + subrect->width)
> +		subrect->left =3D rect->left + rect->width - subrect->width;
> +
> +	if (rect->top > subrect->top)
> +		subrect->top =3D rect->top;
> +	else if (rect->top + rect->height > subrect->top + subrect->height)
> +		subrect->top =3D rect->top + rect->height - subrect->height;
> +}
> +
> +/*
> + * The common for both scaling and cropping iterative approach is:
> + * 1. try if the client can produce exactly what requested by the user
> + * 2. if (1) failed, try to double the client image until we get one big=
 enough
> + * 3. if (2) failed, try to request the maximum image
> + */
> +static int client_s_crop(struct soc_camera_device *icd, struct v4l2_crop=
 *crop,
> +			 struct v4l2_crop *cam_crop)
> +{
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct v4l2_rect *rect =3D &crop->c, *cam_rect =3D &cam_crop->c;
> +	struct device *dev =3D sd->v4l2_dev->dev;
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct v4l2_cropcap cap;
> +	int ret;
> +	unsigned int width, height;
> +
> +	v4l2_subdev_call(sd, video, s_crop, crop);
> +	ret =3D client_g_rect(sd, cam_rect);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Now cam_crop contains the current camera input rectangle, and it must
> +	 * be within camera cropcap bounds
> +	 */
> +	if (!memcmp(rect, cam_rect, sizeof(*rect))) {
> +		/* Even if camera S_CROP failed, but camera rectangle matches */
> +		dev_dbg(dev, "Camera S_CROP successful for %dx%d@%d:%d\n",
> +			rect->width, rect->height, rect->left, rect->top);
> +		cam->rect =3D *cam_rect;
> +		return 0;
> +	}
> +
> +	/* Try to fix cropping, that camera hasn't managed to set */
> +	dev_dbg(dev, "Fix camera S_CROP for %dx%d@%d:%d to %dx%d@%d:%d\n",
> +		cam_rect->width, cam_rect->height,
> +		cam_rect->left, cam_rect->top,
> +		rect->width, rect->height, rect->left, rect->top);
> +
> +	/* We need sensor maximum rectangle */
> +	ret =3D v4l2_subdev_call(sd, video, cropcap, &cap);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Popular special case - some cameras can only handle fixed sizes like
> +	 * QVGA, VGA,... Take care to avoid infinite loop.
> +	 */
> +	width =3D max(cam_rect->width, 2);
> +	height =3D max(cam_rect->height, 2);
> +
> +	/*
> +	 * Loop as long as sensor is not covering the requested rectangle and
> +	 * is still within its bounds
> +	 */
> +	while (!ret && (is_smaller(cam_rect, rect) ||
> +			is_inside(cam_rect, rect)) &&
> +	       (cap.bounds.width > width || cap.bounds.height > height)) {
> +
> +		width <<=3D 1;
> +		height <<=3D 1;
> +
> +		cam_rect->width =3D width;
> +		cam_rect->height =3D height;
> +
> +		/*
> +		 * We do not know what capabilities the camera has to set up
> +		 * left and top borders. We could try to be smarter in iterating
> +		 * them, e.g. if camera current left is to the right of the
> +		 * target left, set it to the middle point between the current
> +		 * left and minimum left. But that would add too much
> +		 * complexity: we would have to iterate each border separately.
> +		 * Instead we just drop to the left and top bounds.
> +		 */
> +		if (cam_rect->left > rect->left)
> +			cam_rect->left =3D cap.bounds.left;
> +
> +		if (cam_rect->left + cam_rect->width < rect->left + rect->width)
> +			cam_rect->width =3D rect->left + rect->width -
> +				cam_rect->left;
> +
> +		if (cam_rect->top > rect->top)
> +			cam_rect->top =3D cap.bounds.top;
> +
> +		if (cam_rect->top + cam_rect->height < rect->top + rect->height)
> +			cam_rect->height =3D rect->top + rect->height -
> +				cam_rect->top;
> +
> +		v4l2_subdev_call(sd, video, s_crop, cam_crop);
> +		ret =3D client_g_rect(sd, cam_rect);
> +		dev_dbg(dev, "Camera S_CROP %d for %dx%d@%d:%d\n", ret,
> +			cam_rect->width, cam_rect->height,
> +			cam_rect->left, cam_rect->top);
> +	}
> +
> +	/* S_CROP must not modify the rectangle */
> +	if (is_smaller(cam_rect, rect) || is_inside(cam_rect, rect)) {
> +		/*
> +		 * The camera failed to configure a suitable cropping,
> +		 * we cannot use the current rectangle, set to max
> +		 */
> +		*cam_rect =3D cap.bounds;
> +		v4l2_subdev_call(sd, video, s_crop, cam_crop);
> +		ret =3D client_g_rect(sd, cam_rect);
> +		dev_dbg(dev, "Camera S_CROP %d for max %dx%d@%d:%d\n", ret,
> +			cam_rect->width, cam_rect->height,
> +			cam_rect->left, cam_rect->top);
> +	}
> +
> +	if (!ret) {
> +		cam->rect =3D *cam_rect;
> +
> +		dev_dbg(dev, "Update subrect for %dx%d@%d:%d to %dx%d@%d:%d\n",
> +			cam->subrect.width, cam->subrect.height,
> +			cam->subrect.left, cam->subrect.top,
> +			cam->rect.width, cam->rect.height,
> +			cam->rect.left, cam->rect.top);
> +
> +		update_subrect(cam);
> +	}
> +
> +	return ret;
> +}
> +
> +/* Iterative s_mbus_fmt, also updates cached client crop on success */
> +static int client_s_fmt(struct soc_camera_device *icd,
> +			struct v4l2_mbus_framefmt *mf, bool vin_can_scale)
> +{
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct device *dev =3D icd->parent;
> +	unsigned int width =3D mf->width, height =3D mf->height, tmp_w, tmp_h;
> +	unsigned int max_width, max_height;
> +	struct v4l2_cropcap cap;
> +	int ret;
> +
> +	ret =3D v4l2_device_call_until_err(sd->v4l2_dev,
> +					 soc_camera_grp_id(icd), video,
> +					 s_mbus_fmt, mf);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "camera scaled to %ux%u\n", mf->width, mf->height);
> +
> +	if ((width =3D mf->width && height =3D mf->height) || !vin_can_scale)
> +		goto update_cache;
> +
> +	cap.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +
> +	ret =3D v4l2_subdev_call(sd, video, cropcap, &cap);
> +	if (ret < 0)
> +		return ret;
> +
> +	max_width =3D min(cap.bounds.width, VIN_MAX_WIDTH);
> +	max_height =3D min(cap.bounds.height, VIN_MAX_HEIGHT);
> +
> +	/* Camera set a format, but geometry is not precise, try to improve */
> +	tmp_w =3D mf->width;
> +	tmp_h =3D mf->height;
> +
> +	/* width <=3D max_width && height <=3D max_height - guaranteed by try_f=
mt */
> +	while ((width > tmp_w || height > tmp_h) &&
> +	       tmp_w < max_width && tmp_h < max_height) {
> +		tmp_w =3D min(2 * tmp_w, max_width);
> +		tmp_h =3D min(2 * tmp_h, max_height);
> +		mf->width =3D tmp_w;
> +		mf->height =3D tmp_h;
> +		ret =3D v4l2_subdev_call(sd, video, s_mbus_fmt, mf);
> +		if (ret < 0) {
> +			/* This shouldn't happen */
> +			dev_err(dev, "Client failed to set format: %d\n", ret);
> +			return ret;
> +		}
> +		dev_dbg(dev, "Camera scaled to %ux%u\n", mf->width, mf->height);
> +	}
> +
> +update_cache:
> +	ret =3D client_g_rect(sd, &cam->rect);
> +	if (ret < 0)
> +		return ret;
> +
> +	update_subrect(cam);
> +
> +	return 0;
> +}
> +
> +/*
> + * width - on output: user width, mapped back to input
> + * height - on output: user height, mapped back to input
> + * mf - in-/output: camera output window
> + */
> +static int client_scale(struct soc_camera_device *icd,
> +			struct v4l2_mbus_framefmt *mf,
> +			unsigned int *width, unsigned int *height,
> +			bool vin_can_scale)
> +{
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct device *dev =3D icd->parent;
> +	struct v4l2_mbus_framefmt mf_tmp =3D *mf;
> +	unsigned int scale_h, scale_v;
> +	int ret;
> +
> +	/*
> +	 * Apply iterative camera S_FMT for camera user window (also updates
> +	 * client crop cache and the imaginary sub-rectangle).
> +	 */
> +	ret =3D client_s_fmt(icd, &mf_tmp, vin_can_scale);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "camera scaled to %ux%u\n",
> +		mf_tmp.width, mf_tmp.height);
> +
> +	/* Calculate new client scales. */
> +	scale_h =3D calc_generic_scale(cam->rect.width, mf_tmp.width);
> +	scale_v =3D calc_generic_scale(cam->rect.height, mf_tmp.height);
> +
> +	mf->width =3D mf_tmp.width;
> +	mf->height =3D mf_tmp.height;
> +	mf->colorspace =3D mf_tmp.colorspace;
> +
> +	/*
> +	 * Calculate new VIN crop - apply camera scales to previously
> +	 * updated "effective" crop.
> +	 */
> +	*width =3D scale_down(cam->subrect.width, scale_h);
> +	*height =3D scale_down(cam->subrect.height, scale_v);
> +
> +	dev_dbg(dev, "new client sub-window %ux%u\n", *width, *height);
> +
> +	return 0;
> +}
> +
> +static int rcar_vin_set_crop(struct soc_camera_device *icd,
> +			     const struct v4l2_crop *a)
> +{
> +	struct v4l2_crop a_writable =3D *a;
> +	const struct v4l2_rect *rect =3D &a_writable.c;
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	struct v4l2_crop cam_crop;
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct v4l2_rect *cam_rect =3D &cam_crop.c;
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct device *dev =3D icd->parent;
> +	struct v4l2_mbus_framefmt mf;
> +	u32 vnmc;
> +	int ret, i;
> +
> +	dev_dbg(dev, "S_CROP(%ux%u@%u:%u)\n", rect->width, rect->height,
> +		rect->left, rect->top);
> +
> +	/* During camera cropping its output window can change too, stop VIN */
> +	capture_stop_preserve(priv, &vnmc);
> +	dev_dbg(dev, "VNMC_REG 0x%x\n", vnmc);
> +
> +	/* Apply iterative camera S_CROP for new input window. */
> +	ret =3D client_s_crop(icd, &a_writable, &cam_crop);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(dev, "camera cropped to %ux%u@%u:%u\n",
> +		cam_rect->width, cam_rect->height,
> +		cam_rect->left, cam_rect->top);
> +
> +	/* On success cam_crop contains current camera crop */
> +
> +	/* Retrieve camera output window */
> +	ret =3D v4l2_subdev_call(sd, video, g_mbus_fmt, &mf);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (mf.width > VIN_MAX_WIDTH || mf.height > VIN_MAX_HEIGHT)
> +		return -EINVAL;
> +
> +	/* Cache camera output window */
> +	cam->width =3D mf.width;
> +	cam->height =3D mf.height;
> +
> +	icd->user_width  =3D cam->width;
> +	icd->user_height =3D cam->height;
> +
> +	cam->vin_left =3D rect->left & ~1;
> +	cam->vin_top =3D rect->top & ~1;
> +
> +	/* Use VIN cropping to crop to the new window. */
> +	ret =3D rcar_vin_set_rect(icd);
> +	if (ret < 0)
> +		return ret;
> +
> +	cam->subrect =3D *rect;
> +
> +	dev_dbg(dev, "VIN cropped to %ux%u@%u:%u\n",
> +		icd->user_width, icd->user_height,
> +		cam->vin_left, cam->vin_top);
> +
> +	/* Restore capture */
> +	for (i =3D 0; i < MAX_BUFFER_NUM; i++) {
> +		if (priv->queue_buf[i] && priv->state =3D STOPPED) {
> +			vnmc |=3D VNMC_ME;
> +			break;
> +		}
> +	}
> +	capture_restore(priv, vnmc);
> +
> +	/* Even if only camera cropping succeeded */
> +	return ret;
> +}
> +
> +static int rcar_vin_get_crop(struct soc_camera_device *icd,
> +			     struct v4l2_crop *a)
> +{
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +
> +	a->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	a->c =3D cam->subrect;
> +
> +	return 0;
> +}
> +
> +/*
> + * Calculate real client output window by applying new scales to the cur=
rent
> + * client crop. New scales are calculated from the requested output form=
at and
> + * VIN crop, mapped backed onto the client input (subrect).
> + */
> +static void calculate_client_output(struct soc_camera_device *icd,
> +				    struct v4l2_pix_format *pix,
> +				    struct v4l2_mbus_framefmt *mf)
> +{
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct device *dev =3D icd->parent;
> +	struct v4l2_rect *cam_subrect =3D &cam->subrect;
> +	unsigned int scale_v, scale_h;
> +
> +	if (cam_subrect->width =3D cam->rect.width &&
> +	    cam_subrect->height =3D cam->rect.height) {
> +		/* No sub-cropping */
> +		mf->width =3D pix->width;
> +		mf->height =3D pix->height;
> +		return;
> +	}
> +
> +	/* Current camera scales and subwin - cached */
> +
> +	dev_dbg(dev, "subwin %ux%u@%u:%u\n",
> +		cam_subrect->width, cam_subrect->height,
> +		cam_subrect->left, cam_subrect->top);
> +
> +	/*
> +	 * Calculate new combined scales from input sub-window to requested
> +	 * user window
> +	 */
> +
> +	scale_h =3D calc_generic_scale(cam_subrect->width, pix->width);
> +	scale_v =3D calc_generic_scale(cam_subrect->height, pix->height);
> +
> +	dev_dbg(dev, "scales %u:%u\n", scale_h, scale_v);
> +
> +	/*
> +	 * Calculate client output window by applying combined scales to real
> +	 * input window
> +	 */
> +	mf->width =3D scale_down(cam->rect.width, scale_h);
> +	mf->height =3D scale_down(cam->rect.height, scale_v);
> +}
> +
> +/* Similar to set_crop multistage iterative algorithm */
> +static int rcar_vin_set_fmt(struct soc_camera_device *icd,
> +			    struct v4l2_format *f)
> +{
> +	struct soc_camera_host *ici =3D to_soc_camera_host(icd->parent);
> +	struct rcar_vin_priv *priv =3D ici->priv;
> +	struct rcar_vin_cam *cam =3D icd->host_priv;
> +	struct v4l2_pix_format *pix =3D &f->fmt.pix;
> +	struct v4l2_mbus_framefmt mf;
> +	struct device *dev =3D icd->parent;
> +	__u32 pixfmt =3D pix->pixelformat;
> +	const struct soc_camera_format_xlate *xlate;
> +	unsigned int vin_sub_width =3D 0, vin_sub_height =3D 0;
> +	u16 scale_v, scale_h;
> +	int ret;
> +	bool can_scale;
> +	bool data_through;
> +	enum v4l2_field field;
> +
> +	dev_dbg(dev, "S_FMT(pix=3D0x%x, %ux%u)\n",
> +		pixfmt, pix->width, pix->height);
> +
> +	switch (pix->field) {
> +	default:
> +		pix->field =3D V4L2_FIELD_NONE;
> +		/* fall-through */
> +	case V4L2_FIELD_NONE:
> +	case V4L2_FIELD_TOP:
> +	case V4L2_FIELD_BOTTOM:
> +	case V4L2_FIELD_INTERLACED_TB:
> +	case V4L2_FIELD_INTERLACED_BT:
> +		field =3D pix->field;
> +		break;
> +	case V4L2_FIELD_INTERLACED:
> +		field =3D V4L2_FIELD_INTERLACED_TB;
> +		break;
> +	}
> +
> +	xlate =3D soc_camera_xlate_by_fourcc(icd, pixfmt);
> +	if (!xlate) {
> +		dev_warn(dev, "Format %x not found\n", pixfmt);
> +		return -EINVAL;
> +	}
> +	/* Calculate client output geometry */
> +	calculate_client_output(icd, &f->fmt.pix, &mf);
> +	mf.field =3D pix->field;
> +	mf.colorspace =3D pix->colorspace;
> +	mf.code	 =3D xlate->code;
> +
> +	data_through =3D pixfmt =3D V4L2_PIX_FMT_RGB32;
> +	can_scale =3D !data_through && pixfmt !=3D V4L2_PIX_FMT_NV16;

As mentioned above, there must be no such restriction for scaling
in case of M1A and H1.

> +
> +	dev_dbg(dev, "request camera output %ux%u\n", mf.width, mf.height);
> +
> +	ret =3D client_scale(icd, &mf, &vin_sub_width, &vin_sub_height,
> +			   can_scale);
> +
> +	/* Done with the camera. Now see if we can improve the result */
> +	dev_dbg(dev, "Camera %d fmt %ux%u, requested %ux%u\n",
> +		ret, mf.width, mf.height, pix->width, pix->height);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (mf.code !=3D xlate->code)
> +		return -EINVAL;
> +
> +	/* Prepare VIN crop */
> +	cam->width =3D mf.width;
> +	cam->height =3D mf.height;
> +
> +	/* Use VIN scaling to scale to the requested user window. */
> +
> +	/* We cannot scale up */
> +	if (pix->width > vin_sub_width)
> +		vin_sub_width =3D pix->width;
> +
> +	if (pix->height > vin_sub_height)
> +		vin_sub_height =3D pix->height;
> +
> +	pix->colorspace =3D mf.colorspace;
> +
> +	if (can_scale) {
> +		/* Scale pix->{width x height} down to width x height */
> +		scale_h =3D calc_scale(vin_sub_width, &pix->width);
> +		scale_v =3D calc_scale(vin_sub_height, &pix->height);
> +	} else {
> +		pix->width =3D vin_sub_width;
> +		pix->height =3D vin_sub_height;
> +		scale_h =3D 0;
> +		scale_v =3D 0;
> +	}
> +
> +	/*
> +	 * We have calculated CFLCR, the actual configuration will be performed
> +	 * in rcar_vin_set_bus_param()
> +	 */
> +
> +	dev_dbg(dev, "W: %u : 0x%x =3D %u, H: %u : 0x%x =3D %u\n",
> +		vin_sub_width, scale_h, pix->width,
> +		vin_sub_height, scale_v, pix->height);
> +
> +	cam->code =3D xlate->code;
> +	icd->current_fmt =3D xlate;
> +
> +	priv->field =3D field;
> +	priv->data_through =3D data_through;
> +
> +	return 0;
> +}
> +
> +static int rcar_vin_try_fmt(struct soc_camera_device *icd,
> +			    struct v4l2_format *f)
> +{
> +	const struct soc_camera_format_xlate *xlate;
> +	struct v4l2_pix_format *pix =3D &f->fmt.pix;
> +	struct v4l2_subdev *sd =3D soc_camera_to_subdev(icd);
> +	struct v4l2_mbus_framefmt mf;
> +	__u32 pixfmt =3D pix->pixelformat;
> +	int width, height;
> +	int ret;
> +
> +	xlate =3D soc_camera_xlate_by_fourcc(icd, pixfmt);
> +	if (!xlate) {
> +		dev_warn(icd->parent, "Format %x not found\n", pixfmt);
> +		return -EINVAL;
> +	}
> +
> +	/* FIXME: calculate using depth and bus width */
> +	v4l_bound_align_image(&pix->width, 2, VIN_MAX_WIDTH, 1,
> +			      &pix->height, 4, VIN_MAX_HEIGHT, 2, 0);
> +
> +	width =3D pix->width;
> +	height =3D pix->height;
> +
> +	pix->bytesperline =3D soc_mbus_bytes_per_line(width, xlate->host_fmt);
> +	if ((int)pix->bytesperline < 0)
> +		return pix->bytesperline;
> +	pix->sizeimage =3D height * pix->bytesperline;
> +
> +	/* limit to sensor capabilities */
> +	mf.width =3D pix->width;
> +	mf.height =3D pix->height;
> +	mf.field =3D pix->field;
> +	mf.code =3D xlate->code;
> +	mf.colorspace =3D pix->colorspace;
> +
> +	ret =3D v4l2_device_call_until_err(sd->v4l2_dev, soc_camera_grp_id(icd),
> +					 video, try_mbus_fmt, &mf);
> +	if (ret < 0)
> +		return ret;
> +
> +	pix->width =3D mf.width;
> +	pix->height =3D mf.height;
> +	pix->field =3D mf.field;
> +	pix->colorspace =3D mf.colorspace;
> +
> +	if (pixfmt =3D V4L2_PIX_FMT_NV16) {
> +		/* FIXME: check against rect_max after converting soc-camera */
> +		/* We can scale precisely, need a bigger image from camera */
> +		if (pix->width < width || pix->height < height) {
> +			/*
> +			 * We presume, the sensor behaves sanely, i.e. if
> +			 * requested a bigger rectangle, it will not return a
> +			 * smaller one.
> +			 */
> +			mf.width =3D VIN_MAX_WIDTH;
> +			mf.height =3D VIN_MAX_HEIGHT;
> +			ret =3D v4l2_device_call_until_err(sd->v4l2_dev,
> +							 soc_camera_grp_id(icd),
> +							 video, try_mbus_fmt,
> +							 &mf);
> +			if (ret < 0) {
> +				dev_err(icd->parent,
> +					"client try_fmt() =3D %d\n", ret);
> +				return ret;
> +			}
> +		}
> +		/* We will scale exactly */
> +		if (mf.width > width)
> +			pix->width =3D width;
> +		if (mf.height > height)
> +			pix->height =3D height;
> +	}
> +
> +	return ret;
> +}
> +
> +static unsigned int rcar_vin_poll(struct file *file, poll_table *pt)
> +{
> +	struct soc_camera_device *icd =3D file->private_data;
> +
> +	return vb2_poll(&icd->vb2_vidq, file, pt);
> +}
> +
> +static int rcar_vin_querycap(struct soc_camera_host *ici,
> +			     struct v4l2_capability *cap)
> +{
> +	strlcpy(cap->card, "R_Car_VIN", sizeof(cap->card));
> +	cap->capabilities =3D V4L2_CAP_VIDEO_CAPTURE | V4L2_CAP_STREAMING;
> +	return 0;
> +}
> +
> +static int rcar_vin_init_videobuf2(struct vb2_queue *vq,
> +				   struct soc_camera_device *icd)
> +{
> +	vq->type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE;
> +	vq->io_modes =3D VB2_MMAP | VB2_USERPTR;
> +	vq->drv_priv =3D icd;
> +	vq->ops =3D &rcar_vin_vb2_ops;
> +	vq->mem_ops =3D &vb2_dma_contig_memops;
> +	vq->buf_struct_size =3D sizeof(struct rcar_vin_buffer);
> +
> +	return vb2_queue_init(vq);
> +}
> +
> +static struct soc_camera_host_ops rcar_vin_host_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.add		=3D rcar_vin_add_device,
> +	.remove		=3D rcar_vin_remove_device,
> +	.get_formats	=3D rcar_vin_get_formats,
> +	.put_formats	=3D rcar_vin_put_formats,
> +	.get_crop	=3D rcar_vin_get_crop,
> +	.set_crop	=3D rcar_vin_set_crop,
> +	.try_fmt	=3D rcar_vin_try_fmt,
> +	.set_fmt	=3D rcar_vin_set_fmt,
> +	.poll		=3D rcar_vin_poll,
> +	.querycap	=3D rcar_vin_querycap,
> +	.set_bus_param	=3D rcar_vin_set_bus_param,
> +	.init_videobuf2	=3D rcar_vin_init_videobuf2,
> +};
> +
> +static int rcar_vin_probe(struct platform_device *pdev)
> +{
> +	struct rcar_vin_priv *priv;
> +	struct resource *mem;
> +	struct rcar_vin_platform_data *pdata;
> +	int irq, ret;
> +
> +	pdata =3D pdev->dev.platform_data;
> +	if (!pdata || !pdata->flags) {
> +		dev_err(&pdev->dev, "platform data not set\n");
> +		return -EINVAL;
> +	}
> +
> +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (mem =3D NULL)
> +		return -EINVAL;
> +
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq <=3D 0)
> +		return -EINVAL;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct rcar_vin_priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->base =3D devm_ioremap_resource(&pdev->dev, mem);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +
> +	ret =3D devm_request_irq(&pdev->dev, irq, rcar_vin_irq, IRQF_SHARED,
> +			       dev_name(&pdev->dev), priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->alloc_ctx =3D vb2_dma_contig_init_ctx(&pdev->dev);
> +	if (IS_ERR(priv->alloc_ctx))
> +		return PTR_ERR(priv->alloc_ctx);
> +
> +	priv->ici.priv =3D priv;
> +	priv->ici.v4l2_dev.dev =3D &pdev->dev;
> +	priv->ici.nr =3D pdev->id;
> +	priv->ici.drv_name =3D dev_name(&pdev->dev);
> +	priv->ici.ops =3D &rcar_vin_host_ops;
> +
> +	priv->pdata =3D pdata;
> +	spin_lock_init(&priv->lock);
> +	INIT_LIST_HEAD(&priv->capture);
> +
> +	priv->state =3D STOPPED;
> +
> +	pm_suspend_ignore_children(&pdev->dev, true);
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_resume(&pdev->dev);
> +
> +	ret =3D soc_camera_host_register(&priv->ici);
> +	if (ret)
> +		goto cleanup;
> +
> +	return 0;
> +
> +cleanup:
> +	pm_runtime_disable(&pdev->dev);
> +	vb2_dma_contig_cleanup_ctx(priv->alloc_ctx);
> +
> +	return ret;
> +}
> +
> +static int rcar_vin_remove(struct platform_device *pdev)
> +{
> +	struct soc_camera_host *soc_host =3D to_soc_camera_host(&pdev->dev);
> +	struct rcar_vin_priv *priv =3D container_of(soc_host,
> +						  struct rcar_vin_priv, ici);
> +
> +	soc_camera_host_unregister(soc_host);
> +	pm_runtime_disable(&pdev->dev);
> +	vb2_dma_contig_cleanup_ctx(priv->alloc_ctx);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver rcar_vin_driver =3D {
> +	.probe		=3D rcar_vin_probe,
> +	.remove		=3D rcar_vin_remove,
> +	.driver		=3D {
> +		.name		=3D DRV_NAME,
> +		.owner		=3D THIS_MODULE,
> +	},
> +};
> +
> +module_platform_driver(rcar_vin_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:rcar_vin");
> +MODULE_DESCRIPTION("Renesas R-Car VIN camera host driver");
> Index: renesas/include/linux/platform_data/camera-rcar.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null
> +++ renesas/include/linux/platform_data/camera-rcar.h
> @@ -0,0 +1,25 @@
> +/*
> + * Platform data for Renesas R-Car VIN soc-camera driver
> + *
> + * Copyright (C) 2011-2013 Renesas Solutions Corp.
> + * Copyright (C) 2013 Cogent Embedded, Inc., <source@cogentembedded.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify=
 it
> + * under  the terms of  the GNU General  Public License as published by =
the
> + * Free Software Foundation;  either version 2 of the  License, or (at y=
our
> + * option) any later version.
> + */
> +
> +#ifndef __CAMERA_RCAR_H_
> +#define __CAMERA_RCAR_H_
> +
> +#define RCAR_VIN_HSYNC_ACTIVE_LOW	(1 << 0)
> +#define RCAR_VIN_VSYNC_ACTIVE_LOW	(1 << 1)
> +#define RCAR_VIN_BT601			(1 << 2)
> +#define RCAR_VIN_BT656			(1 << 3)
> +
> +struct rcar_vin_platform_data {
> +	unsigned int flags;
> +};
> +
> +#endif /* __CAMERA_RCAR_H_ */

I am concern that there could be some difference of VIN
functionalities that I mentioned above in between R-Car SoC series;
uPD35004(R-CarE1), R8A7778(R-CarM1A), and R8A7779(R-CarH1).
Some flags can be added for the platform data to let the driver
know such the difference.

Thanks,
---
 Katsuya Matsubara / IGEL Co., Ltd
 matsu@igel.co.jp

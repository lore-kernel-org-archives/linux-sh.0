From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Thu, 14 Jan 2016 13:30:12 +0000
Subject: [RFC 1/5] [media] rcar-vin: add skeleton
Message-Id: <1452778216-31978-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This is the skeleton for a rcar-vin driver that do not depend on
soc_camera.
---
 drivers/media/platform/rcar-vin.c | 149 ++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 149 insertions(+)
 create mode 100644 drivers/media/platform/rcar-vin.c

diff --git a/drivers/media/platform/rcar-vin.c b/drivers/media/platform/rca=
r-vin.c
new file mode 100644
index 0000000..834ef2c
--- /dev/null
+++ b/drivers/media/platform/rcar-vin.c
@@ -0,0 +1,149 @@
+/*
+ * Driver for Renesas R-Car VIN unit
+ *
+ * Copyright (C) 2016 Renesas Solutions Corp.
+ *
+ * Based on SoC-camera Driver for the same device "soc_camera/rcar_vin.c"
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <media/v4l2-device.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-event.h>
+#include <media/v4l2-ioctl.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ctrls.h>
+#include <media/videobuf2-v4l2.h>
+#include <media/videobuf2-dma-contig.h>
+
+enum chip_id {
+	RCAR_GEN2,
+	RCAR_H1,
+	RCAR_M1,
+	RCAR_E1,
+};
+
+struct rcar_vin {
+	void __iomem *base;
+
+	struct platform_device *pdev;
+	struct v4l2_device v4l2_dev;
+	struct mutex lock;
+};
+
+static irqreturn_t rcar_vin_irq(int irq, void *dev_id)
+{
+	/* TODO */
+	return IRQ_HANDLED;
+}
+
+/* -----------------------------------------------------------------------=
------
+ * Platform Device Driver
+ */
+
+static int rcar_vin_probe(struct platform_device *pdev)
+{
+	struct rcar_vin *vin;
+	struct resource *mem;
+	int irq, ret;
+
+	/* Allocate a new instance */
+	vin =3D devm_kzalloc(&pdev->dev, sizeof(*vin), GFP_KERNEL);
+	if (!vin)
+		return -ENOMEM;
+
+	vin->pdev =3D pdev;
+
+	/* Enable Device */
+	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (mem =3D NULL)
+		return -EINVAL;
+
+	vin->base =3D devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(vin->base))
+		return PTR_ERR(vin->base);
+
+	/* Allocate the interrupt */
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq <=3D 0)
+		return -EINVAL;
+
+	ret =3D devm_request_irq(&pdev->dev, irq,
+			rcar_vin_irq, IRQF_SHARED, KBUILD_MODNAME, vin);
+	if (ret) {
+		dev_err(&pdev->dev, "request_irq failed\n");
+		goto disable_dev;
+
+	}
+
+	/* Fill in the initial format-related settings */
+	/* TODO */
+
+	/* Initialize the top-level structure */
+	ret =3D v4l2_device_register(&pdev->dev, &vin->v4l2_dev);
+	if (ret)
+		goto disable_dev;
+
+	mutex_init(&vin->lock);
+
+	/* Add the controls */
+	/* TODO */
+
+	/* Initialize the vb2 queue */
+	/* TODO */
+
+	/* Initialize the video_device structure */
+	/* TODO */
+
+	platform_set_drvdata(pdev, vin);
+
+	return 0;
+
+disable_dev:
+	return ret;
+}
+
+static int rcar_vin_remove(struct platform_device *pdev)
+{
+	struct rcar_vin *vin =3D platform_get_drvdata(pdev);
+
+	v4l2_device_unregister(&vin->v4l2_dev);
+	return 0;
+}
+
+static const struct of_device_id rcar_vin_of_id_table[] =3D {
+	{ .compatible =3D "renesas,vin-r8a7794", .data =3D (void *)RCAR_GEN2 },
+	{ .compatible =3D "renesas,vin-r8a7793", .data =3D (void *)RCAR_GEN2 },
+	{ .compatible =3D "renesas,vin-r8a7791", .data =3D (void *)RCAR_GEN2 },
+	{ .compatible =3D "renesas,vin-r8a7790", .data =3D (void *)RCAR_GEN2 },
+	{ .compatible =3D "renesas,vin-r8a7779", .data =3D (void *)RCAR_H1 },
+	{ .compatible =3D "renesas,vin-r8a7778", .data =3D (void *)RCAR_M1 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rcar_vin_of_id_table);
+
+static struct platform_driver rcar_vin_driver =3D {
+	.driver =3D {
+		.name =3D "rcar-vin",
+		.of_match_table =3D rcar_vin_of_id_table,
+	},
+	.probe =3D rcar_vin_probe,
+	.remove =3D rcar_vin_remove,
+};
+
+module_platform_driver(rcar_vin_driver);
+
+MODULE_AUTHOR("Niklas S=C3=B6derlund <niklas.soderlund@ragnatech.se>");
+MODULE_DESCRIPTION("Renesas R-Car VIN camera host driver");
+MODULE_LICENSE("GPL v2");
--=20
2.7.0


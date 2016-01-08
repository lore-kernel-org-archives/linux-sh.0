From: "=?UTF-8?q?Niklas=20S=C3=B6derlund?=" <niklas.soderlund@ragnatech.se>
Date: Fri, 08 Jan 2016 08:23:04 +0000
Subject: [RFC 2/4] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1452241386-22830-3-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Enable slave transfers over IPMMU by mapping the slave addresses to the
DMAC device iommu domain. The mapping is done directly when the slave
device is configured and is never unmapped.

The mapping is permanent for the device since there might be more then
one channel that maps the same area. Think a rx/tx pair that operates on
the same address but from separate channels. This makes it hard to map
and unmap the addresses from device_alloc_chan_resources and
device_free_chan_resources since all channels share the same iommu
domain.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/dma/sh/rcar-dmac.c | 50 ++++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7820d07..c1138a1 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/interrupt.h>
+#include <linux/iommu.h>
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -1101,10 +1102,49 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dm=
a_addr_t buf_addr,
 	return desc;
 }
=20
+static int rcar_dmac_iommu_map(struct dma_chan *chan, phys_addr_t addr,
+			       size_t size)
+{
+	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
+	struct iommu_domain *domain;
+	phys_addr_t base;
+	size_t min_pagesz, sz =3D 0;
+	int ret;
+
+	if (!addr)
+		return 0;
+
+	domain =3D iommu_get_domain_for_dev(chan->device->dev);
+	if (!domain)
+		return 0;
+
+	/* do nothing if the address  is already mapped to the domain */
+	/* FIXME: what happens if size is larger for the new mapping? */
+	if (iommu_iova_to_phys(domain, addr))
+		return 0;
+
+	min_pagesz =3D iommu_min_pgsize(domain);
+
+	/* align the address with the min page size */
+	base =3D addr & ~(min_pagesz - 1);
+
+	/* recalculate size for aligned address */
+	while (sz < size + addr - base)
+		sz +=3D min_pagesz;
+
+	ret =3D iommu_map(domain, base, base, sz, IOMMU_READ | IOMMU_WRITE);
+	if (ret)
+		dev_err(chan->device->dev, "chan%u: failed to map %pap",
+				rchan->index, &addr);
+
+	return ret;
+}
+
 static int rcar_dmac_device_config(struct dma_chan *chan,
 				   struct dma_slave_config *cfg)
 {
 	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
+	int ret =3D 0;
=20
 	/*
 	 * We could lock this, but you shouldn't be configuring the
@@ -1115,7 +1155,15 @@ static int rcar_dmac_device_config(struct dma_chan *=
chan,
 	rchan->src_xfer_size =3D cfg->src_addr_width;
 	rchan->dst_xfer_size =3D cfg->dst_addr_width;
=20
-	return 0;
+	ret =3D rcar_dmac_iommu_map(chan, rchan->src_slave_addr,
+			rchan->src_xfer_size);
+	if (ret)
+		return ret;
+
+	ret =3D rcar_dmac_iommu_map(chan, rchan->dst_slave_addr,
+			rchan->dst_xfer_size);
+
+	return ret;
 }
=20
 static int rcar_dmac_chan_terminate_all(struct dma_chan *chan)
--=20
2.6.4


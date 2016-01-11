From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Mon, 11 Jan 2016 02:17:46 +0000
Subject: [PATCH 1/2] dmaengine: rcar-dmac: add iommu support for slave transfers
Message-Id: <1452478667-30966-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Enable slave transfers to devices behind IPMMU:s by mapping the slave
addresses using the dma-mapping API.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
---
 drivers/dma/sh/rcar-dmac.c | 64 ++++++++++++++++++++++++++++++++++++++++++=
+---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 7820d07..da94809 100644
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
@@ -1101,6 +1102,24 @@ rcar_dmac_prep_dma_cyclic(struct dma_chan *chan, dma=
_addr_t buf_addr,
 	return desc;
 }
=20
+static dma_addr_t __rcar_dmac_dma_map(struct dma_chan *chan, phys_addr_t a=
ddr,
+		size_t size, enum dma_data_direction dir)
+{
+	struct rcar_dmac_chan *rchan =3D to_rcar_dmac_chan(chan);
+	struct page *page =3D phys_to_page(addr);
+	size_t offset =3D addr - page_to_phys(page);
+	dma_addr_t map =3D dma_map_page(chan->device->dev, page, offset, size,
+			dir);
+
+	if (dma_mapping_error(chan->device->dev, map)) {
+		dev_err(chan->device->dev, "chan%u: failed to map %zx@%pap",
+				rchan->index, size, &addr);
+		return 0;
+	}
+
+	return map;
+}
+
 static int rcar_dmac_device_config(struct dma_chan *chan,
 				   struct dma_slave_config *cfg)
 {
@@ -1110,10 +1129,47 @@ static int rcar_dmac_device_config(struct dma_chan =
*chan,
 	 * We could lock this, but you shouldn't be configuring the
 	 * channel, while using it...
 	 */
-	rchan->src_slave_addr =3D cfg->src_addr;
-	rchan->dst_slave_addr =3D cfg->dst_addr;
-	rchan->src_xfer_size =3D cfg->src_addr_width;
-	rchan->dst_xfer_size =3D cfg->dst_addr_width;
+
+	/* If we don't have a iommu domain no idea to trying to use it */
+	if (!iommu_get_domain_for_dev(chan->device->dev)) {
+		rchan->src_slave_addr =3D cfg->src_addr;
+		rchan->dst_slave_addr =3D cfg->dst_addr;
+		rchan->src_xfer_size =3D cfg->src_addr_width;
+		rchan->dst_xfer_size =3D cfg->dst_addr_width;
+		return 0;
+	}
+
+	/* unmap old */
+	if (rchan->src_slave_addr) {
+		dma_unmap_page(chan->device->dev, rchan->src_slave_addr,
+				rchan->src_xfer_size, DMA_FROM_DEVICE);
+		rchan->src_slave_addr =3D 0;
+		rchan->src_xfer_size =3D 0;
+	}
+
+	if (rchan->dst_slave_addr) {
+		dma_unmap_page(chan->device->dev, rchan->dst_slave_addr,
+				rchan->dst_xfer_size, DMA_TO_DEVICE);
+		rchan->dst_slave_addr =3D 0;
+		rchan->dst_xfer_size =3D 0;
+	}
+
+	/* map new */
+	if (cfg->src_addr) {
+		rchan->src_slave_addr =3D __rcar_dmac_dma_map(chan, cfg->src_addr,
+				cfg->src_addr_width, DMA_FROM_DEVICE);
+		if (!rchan->src_slave_addr)
+			return -EIO;
+		rchan->src_xfer_size =3D cfg->src_addr_width;
+	}
+
+	if (cfg->dst_addr) {
+		rchan->dst_slave_addr =3D __rcar_dmac_dma_map(chan, cfg->dst_addr,
+				cfg->dst_addr_width, DMA_TO_DEVICE);
+		if (!rchan->dst_slave_addr)
+			return -EIO;
+		rchan->dst_xfer_size =3D cfg->dst_addr_width;
+	}
=20
 	return 0;
 }
--=20
2.7.0


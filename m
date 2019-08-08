From: Christoph Hellwig <hch@lst.de>
Date: Thu, 08 Aug 2019 16:00:02 +0000
Subject: [PATCH 5/8] ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Message-Id: <20190808160005.10325-6-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190808160005.10325-1-hch@lst.de>
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

Replace the local hack with the dma_can_mmap helper to check if
a given device supports mapping DMA allocations to userspace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 703857aab00f..9763c18e176a 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -220,13 +220,12 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 {
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
-	/* architecture supports dma_mmap_coherent()? */
-#if defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP) || !defined(CONFIG_HAS_DMA)
-	if (!substream->ops->mmap &&
-	    substream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV)
-		return false;
-#endif
-	return true;
+
+	if (substream->ops->mmap ||
+	    substream->dma_buffer.dev.type != SNDRV_DMA_TYPE_DEV)
+		return true;
+
+	return dma_can_mmap(substream->dma_buffer.dev.dev);
 }
 
 static int constrain_mask_params(struct snd_pcm_substream *substream,
-- 
2.20.1

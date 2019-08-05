From: Christoph Hellwig <hch@lst.de>
Date: Mon, 05 Aug 2019 09:11:56 +0000
Subject: [PATCH 4/7] ALSA: pcm: use dma_can_mmap() to check if a device supports dma_mmap_*
Message-Id: <20190805091159.7826-5-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Replace the local hack with the dma_can_mmap helper to check if
a given device supports mapping DMA allocations to userspace.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 sound/core/pcm_native.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 703857aab00f..81c82c3ee8a2 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -220,12 +220,11 @@ static bool hw_support_mmap(struct snd_pcm_substream *substream)
 {
 	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
 		return false;
-	/* architecture supports dma_mmap_coherent()? */
-#if defined(CONFIG_ARCH_NO_COHERENT_DMA_MMAP) || !defined(CONFIG_HAS_DMA)
+	if (!dma_can_mmap(substream->dma_buffer.dev.dev))
+		return false;
 	if (!substream->ops->mmap &&
 	    substream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV)
 		return false;
-#endif
 	return true;
 }
 
-- 
2.20.1

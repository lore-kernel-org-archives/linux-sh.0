From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 17 Aug 2015 13:08:55 +0000
Subject: [PATCH] dmaengine: Stricter legacy checking in dma_request_slave_channel_compat()
Message-Id: <1439816935-27554-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Matt Porter <mporter@kernel.crashing.org>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

dma_request_slave_channel_compat() is meant for drivers that support
both DT and legacy platform device based probing: if DT channel DMA
setup fails, it will fall back to platform data based DMA channel setup,
using hardcoded DMA channel IDs and a filter function.

However, if the DTS doesn't provide a "dmas" property for the device,
the fallback is also used. If the legacy filter function is not
hardcoded in the DMA slave driver, but comes from platform data, it will
be NULL. Then dma_request_slave_channel_compat() will succeed
incorrectly, and return a DMA channel, as a NULL legacy filter function
actually means "all channels are OK", not "do not match".

Later, when trying to use that DMA channel, it will fail with:

    rcar-dmac e6700000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=-22

To fix this, ensure that both the filter function and the DMA channel ID
are not NULL before using the legacy fallback.

Note that some DMA slave drivers can handle this failure, and will fall
back to PIO.

See also commit 056f6c87028544de ("dmaengine: shdma: Make dummy
shdma_chan_filter() always return false"), which fixed the same issue
for the case where shdma_chan_filter() is hardcoded in a DMA slave
driver.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/dmaengine.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bdae84ab305bca59..6a22cf1b63c24ffb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1197,6 +1197,9 @@ static inline struct dma_chan
 	if (chan)
 		return chan;
 
+	if (!fn || !fn_param)
+		return NULL;
+
 	return __dma_request_channel(mask, fn, fn_param);
 }
 #endif /* DMAENGINE_H */
-- 
1.9.1


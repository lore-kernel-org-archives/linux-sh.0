From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 22 Jul 2014 12:33:46 +0000
Subject: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor list support
Message-Id: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch set implements support for hardware descriptor lists in the R-Car
Gen2 DMAC driver.

The DMAC supports reconfiguring itself after every chunk from a list of
hardware transfer descriptors in physically contiguous memory. This reduces
the number of interrupts required for processing a DMA transfer.

In theory the transfer throughput can be slightly increased and the CPU load
slightly decreased, but in practice the gain might not be significant as most
DMAC users, if not all, perform small DMA transfers to physically contiguous
memory, resulting in a single chunk per transfer. I'll perform performance
tests and will post results shortly.

The code has been tested by artificially lowering the maximum chunk size to
4096 bytes and running dmatest, which completed sucessfully. Morimoto-san, is
there an easy way to test cyclic transfers with your audio driver ?

The patches apply on top of the "[PATCH v2 0/8] R-Car Gen2 DMA Controller
driver" series previously posted to the dmaengine and linux-sh mailing list.

The RFC status of this series comes from the way hardware descriptors memory
is allocated. The DMAC has an internal descriptor memory of 128 entries shared
between all channels and also supports storing descriptors in system memory.
Using the DMAC internal descriptor memory speeds descriptor fetch operations
up compared to system memory.

Several options are thus possible :

1. Allocate one descriptor list with the DMA coherent allocation API per DMA
transfer request. This is the currently implementated option. The upside is
simplicity, the downsides are slower descriptor fetch operations (compared to
using internal memory) and higher memory usage as dma_alloc_coherent() can't
allocate less than one page. Memory allocation and free also introduce an
overhead, but that's partly alleviated by caching memory (patch 5/5).

2. Allocate pages of physically contiguous memory using the DMA coherent
allocation API as a backend, and manually allocate descriptor lists from
within those pages. The upside is a lower memory usage, the dowsides are
slower descriptor fetch operations (compared to using internal memory) and
higher complexity. As memory will be preallocated the overhead at transfer
descriptor preparation time will be negligible, except when the driver runs
out of preallocated memory and needs to perform a new allocation.

3. Manually allocate descriptor lists from the DMAC internal memory. This has
the upside of speeding descriptor fetch operations up, and the downside of
limiting the total number of descriptors in use at any given time to 128 at
most (and possibly less in practice due to fragmentation). Note that failures
to allocate descriptors memory are not fatal, the driver falls back to not
using hardware descriptors lists in that case.

4. A mix of options 2 and 3, allocating descriptors from internal memory when
available, and falling back to system memory otherwise. This is the most
efficient option from a descriptor fetch point of view, but is also the most
complex to implement.

My gut feeling is that the overhead introduced by fetching descriptors from
external memory will not be significant, but that's just a gut feeling.
Comments and ideas will be appreciated. I plan to keep the current
implementation for now unless someone strongly believes it needs to be
changed.

Laurent Pinchart (5):
  dmaengine: rcar-dmac: Rename rcar_dmac_hw_desc to rcar_dmac_xfer_chunk
  dmaengine: rcar-dmac: Fix typo in register definition
  dmaengine: rcar-dmac: Compute maximum chunk size at runtime
  dmaengine: rcar-dmac: Implement support for hardware descriptor lists
  dmaengine: rcar-dmac: Cache hardware descriptors memory

 drivers/dma/sh/rcar-dmac.c | 432 +++++++++++++++++++++++++++++++++------------
 1 file changed, 324 insertions(+), 108 deletions(-)

-- 
Regards,

Laurent Pinchart


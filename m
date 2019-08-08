From: Christoph Hellwig <hch@lst.de>
Date: Thu, 08 Aug 2019 15:59:57 +0000
Subject: remove default fallbacks in dma_map_ops v3
Message-Id: <20190808160005.10325-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190805091159.7826-1-hch@lst.de>
In-Reply-To: <20190805091159.7826-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org

Hi all,

we have a few places where the DMA mapping layer has non-trivial default
actions that are questionable and/or dangerous.

This series instead wires up the mmap, get_sgtable and get_required_mask
methods explicitly and cleans up some surrounding areas.  This also means
we could get rid of the ARCH_NO_COHERENT_DMA_MMAP kconfig option, as we
now require a mmap method wired up, or in case of non-coherent dma-direct
the presence of the arch_dma_coherent_to_pfn hook.  The only interesting
case is that the sound code also checked the ARCH_NO_COHERENT_DMA_MMAP
symbol in somewhat odd ways, so I'd like to see a review of the sound
situation before going forward with that patch.

Changes since v2:
 - fix use of dma_can_mmap in alsa
 - improve the CONFIG_* mess a little more

Changes since v1:
 - add a dma_can_mmap helper for alsa

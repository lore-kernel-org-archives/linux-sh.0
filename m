From: Christoph Hellwig <hch@lst.de>
Date: Thu, 29 Aug 2019 15:38:23 +0000
Subject: Re: remove default fallbacks in dma_map_ops v3
Message-Id: <20190829153823.GA20459@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190808160005.10325-1-hch@lst.de>
In-Reply-To: <20190808160005.10325-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, Vladimir Murzin <vladimir.murzin@arm.com>, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Robin Murphy <robin.murphy@arm.com>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org

I've applied this to the dma-mapping for-next tree now.

If there are any issues with the parisc patch I'll happily take
incremental patches.

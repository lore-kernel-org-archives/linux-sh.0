From: Philipp Zabel <philipp.zabel@gmail.com>
Date: Fri, 07 Mar 2014 10:49:44 +0000
Subject: Re: [PATCH] drm/cma: Use dma_mmap_writecombine() to mmap buffer
Message-Id: <CA+gwMceZTG1-GvR5V5=FwSSub2JMo7vGoLzzGbumOSL7rVzkqQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393787388-17395-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393787388-17395-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

On Sun, Mar 2, 2014 at 8:09 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The GEM CMA helpers uses a custom mmap implementation based on
> remap_pfn_range(). While this works when the buffer DMA and physical
> addresses are identical, it fails to take IOMMU into account and tries
> to mmap the buffer to userspace using the DMA virtual address instead of
> the physical address. This results in mapping random physical pages when
> the device is behind an IOMMU.
>
> Use the DMA mapping dma_mmap_writecombine() function instead.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Tested-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp

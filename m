From: Christoph Hellwig <hch@lst.de>
Date: Wed, 14 Aug 2019 13:46:14 +0000
Subject: convert sh to the generic dma remap allocator
Message-Id: <20190814134615.29442-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Hi Rich and Yoshinori,

can you take a quick look at this patch that moves sh over to the
generic DMA remap allocator?  I've been trying to slowly get all
architectures over to the generic code, and I'd like merge this one
for 5.4 now that it has been posted a handful of times without any
feedback.

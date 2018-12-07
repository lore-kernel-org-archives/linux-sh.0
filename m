From: Christoph Hellwig <hch@lst.de>
Date: Fri, 07 Dec 2018 15:34:32 +0000
Subject: dma_declare_coherent_memory on main memory
Message-Id: <20181207153432.GA24917@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hi all,

the ARM imx27/31 ports and various sh boards use
dma_declare_coherent_memory on main memory taken from the memblock
allocator.

Is there any good reason these couldn't be switched to CMA areas?
Getting rid of these magic dma_declare_coherent_memory area would
help making the dma allocator a lot simpler.

From: Rob Landley <rob@landley.net>
Date: Sat, 08 Dec 2018 21:25:50 +0000
Subject: Re: dma_declare_coherent_memory on main memory
Message-Id: <994d5106-8f7b-bfb3-4cd5-e190c0035722@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207153432.GA24917@lst.de>
In-Reply-To: <20181207153432.GA24917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org, linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 12/7/18 9:34 AM, Christoph Hellwig wrote:
> Hi all,
> 
> the ARM imx27/31 ports and various sh boards use
> dma_declare_coherent_memory on main memory taken from the memblock
> allocator.
> 
> Is there any good reason these couldn't be switched to CMA areas?
> Getting rid of these magic dma_declare_coherent_memory area would
> help making the dma allocator a lot simpler.

Not that I know of?

Rob

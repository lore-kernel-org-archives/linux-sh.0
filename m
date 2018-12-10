From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 10 Dec 2018 07:26:48 +0000
Subject: Re: dma_declare_coherent_memory on main memory
Message-Id: <20181210072648.ore6xttedsgpndi4@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207153432.GA24917@lst.de>
In-Reply-To: <20181207153432.GA24917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-imx@nxp.com, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org

On Fri, Dec 07, 2018 at 04:34:32PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> the ARM imx27/31 ports and various sh boards use
> dma_declare_coherent_memory on main memory taken from the memblock
> allocator.
> 
> Is there any good reason these couldn't be switched to CMA areas?
> Getting rid of these magic dma_declare_coherent_memory area would
> help making the dma allocator a lot simpler.

At least for i.MX27/31 I'd say this predates CMA support, so historical
reasons.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

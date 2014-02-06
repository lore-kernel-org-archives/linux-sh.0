From: Simon Horman <horms@verge.net.au>
Date: Thu, 06 Feb 2014 06:31:17 +0000
Subject: Re: [PATCH] ARM: shmobile: Use 64-bit dma_addr_t on r8a7790/r8a7791
Message-Id: <20140206063115.GA13435@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140205053628.29078.92360.sendpatchset@w520>
In-Reply-To: <20140205053628.29078.92360.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 05, 2014 at 02:36:28PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Some on-chip devices on r8a7790 and r8a7791 can do
> bus mastering and access more than 32-bits of address
> space. Select ARCH_DMA_ADDR_T_64BIT when LPAE is set
> in case of multiplatform and legacy SoC support.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up.

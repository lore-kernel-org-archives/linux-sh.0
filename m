From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Dec 2012 21:50:36 +0000
Subject: Re: [PATCH v2] ARM: sh7372: fix cache clean / invalidate order
Message-Id: <20121228215035.GH8834@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20121211163313.GG16759@mudshark.cambridge.arm.com>
 <20121211163843.GH16759@mudshark.cambridge.arm.com>
 <50C7C16B.7050106@codeaurora.org>
 <20121212103338.GB23022@e102568-lin.cambridge.arm.com>
 <20121212133650.GJ6195@mudshark.cambridge.arm.com>
 <Pine.LNX.4.64.1212130909190.18586@axis700.grange>
 <20121213105109.GB26540@mudshark.cambridge.arm.com>
 <Pine.LNX.4.64.1212131522430.18586@axis700.grange>
 <50C9E8BD.1020501@ti.com>
 <Pine.LNX.4.64.1212281227070.29263@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1212281227070.29263@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 28, 2012 at 12:32:54PM +0100, Guennadi Liakhovetski wrote:
> According to the Cortex A8 TRM the L2 cache should be first cleaned and 
> then disabled. Fix the swapped order on sh7372.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks, applied to the soc branch of the renesas tree.

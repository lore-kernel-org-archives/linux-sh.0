From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 18 Jan 2012 12:40:33 +0000
Subject: Re: [PATCH 1/2] dma: sh_dma: not all SH DMAC implementations support MEMCPY
Message-Id: <20120118124033.GI8182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201181012130.28782@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, linux-sh@vger.kernel.org

On Wed, Jan 18, 2012 at 10:14:25AM +0100, Guennadi Liakhovetski wrote:
> Add a flag to allow platforms to specify, whether a DMAC instance supports
> the MEMCPY operation. To avoid regressions, preserve the current default.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This series looks fine to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>

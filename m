From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Oct 2010 01:42:52 +0000
Subject: Re: [PATCH] ARM: arch-shmobile: Add IMX074 camera sensor data to the AP4EVB platform
Message-Id: <20101025014252.GC2173@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1010201514590.29312@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1010201514590.29312@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 20, 2010 at 03:15:49PM +0200, Guennadi Liakhovetski wrote:
> Add platform data, necessary to use Sony IMX074 camera sensor with AP4EVB.
> Note: this does not work reliably without an API to reserve contiguous and
> coherent memory for V4L DMA buffers. Such memory reservation has to be added as
> soon as a suitable API becomes available.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.

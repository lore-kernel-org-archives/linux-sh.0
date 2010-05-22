From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 22 May 2010 08:10:56 +0000
Subject: Re: [PATCH] sh: fix Oops in the serial SCI driver
Message-Id: <20100522081056.GE17814@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005211728520.8450@axis700.grange> <Pine.LNX.4.64.1005211722410.8450@axis700.grange> <Pine.LNX.4.64.1005211721030.8450@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005211728520.8450@axis700.grange> <Pine.LNX.4.64.1005211722410.8450@axis700.grange> <Pine.LNX.4.64.1005211721030.8450@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>

On Fri, May 21, 2010 at 05:22:40PM +0200, Guennadi Liakhovetski wrote:
> Fix an Oops, triggering, if the DMA buffer allocation for the Rx channel in
> sh-sci.c fails.

On Fri, May 21, 2010 at 05:28:51PM +0200, Guennadi Liakhovetski wrote:
> This prevents the driver from unloading, while it is in use. Unloading of the
> driver, while its DMA channels are held, leads to a kernel Oops.

On Fri, May 21, 2010 at 05:30:12PM +0200, Guennadi Liakhovetski wrote:
> If all descriptors on a channel are terminated or the channel is released,
> update the completed cookie counter to match the last cookie. This prevents
> inconsistency warning on resumed DMA operation.

Applied, thanks.

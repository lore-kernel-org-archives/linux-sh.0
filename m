From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 24 Jun 2011 08:55:52 +0000
Subject: Re: [PATCH/RFC] dma: shdma: transfer based runtime PM
Message-Id: <20110624085551.GA26516@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106010909570.22716@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1106010909570.22716@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 01, 2011 at 09:20:34AM +0200, Guennadi Liakhovetski wrote:
> Currently the shdma dmaengine driver uses runtime PM to save power, when
> no channel on the specific controller is requested by a user. This patch
> switches the driver to count individual DMA transfers. That way the
> controller can be powered down between transfers, even if some of its
> channels are in use.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> I marked this an RFC, because it might make sense to first test it with 
> Rafael's upcoming power-domain code for sh-mobile, before committing.
> 
Any updates on this?

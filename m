From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 07 Jan 2011 01:59:18 +0000
Subject: Re: [PATCH] dma: shdma: don't register the global die notifier multiple times
Message-Id: <20110107015918.GI22477@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1101061759460.1248@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1101061759460.1248@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>, Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org

On Thu, Jan 06, 2011 at 06:04:50PM +0100, Guennadi Liakhovetski wrote:
> A recent patch has added a die notifier to the shdma driver, however, 
> it registers a static die-notifier object in the probe routine, i.e., 
> for each device instance. This is wrong and leads to a system lockup. 
> This patch moves the die notifier registration to module init and 
> exit routines respectively.
> 
> Reported-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> This fixes the lock up on sh7372. Patch against current sh-2.6/master.
> 
Whoops, I suppose I should have tested on a platform with more than one
DMAC :-)

I'll piggyback this on top of the rmobile-latest branch, thanks.

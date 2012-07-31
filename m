From: Vinod Koul <vinod.koul@linux.intel.com>
Date: Tue, 31 Jul 2012 06:56:42 +0000
Subject: Re: [PATCH 0/2] serial: sh-sci: fix compilation breakage (3.6)
Message-Id: <1343717082.1726.14402.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207302114440.28003@axis700.grange>
	 <20120731060754.GB15380@linux-sh.org>
In-Reply-To: <20120731060754.GB15380@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org

On Tue, 2012-07-31 at 15:07 +0900, Paul Mundt wrote:
> On Mon, Jul 30, 2012 at 09:28:18PM +0200, Guennadi Liakhovetski wrote:
> > Hi all
> > 
> > as has been reported in this
> > 
> > http://thread.gmane.org/gmane.linux.kernel/1294256/focus001
> > 
> > thread, currently sh-sci doesn't comiple in the mainline and in -next if 
> > CONFIG_SERIAL_SH_SCI_DMA is enabled. This patch series fixes this 
> > breakage.
> > 
> Looks alright to me. Vinod, how do you want to handle this? I can roll
> both of these patches in to my tree with your Acked-by, or I can provide
> you with mine for the sh-sci bits if you want to take it via yours. I'm
> planning on sending my next round of updates to Linus in the next couple
> of days.
Looks fine to me as well

Acked-by: Vinod Koul <vinod.koul@linux.intel.com>


-- 
~Vinod


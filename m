From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 31 Jul 2012 06:07:55 +0000
Subject: Re: [PATCH 0/2] serial: sh-sci: fix compilation breakage (3.6)
Message-Id: <20120731060754.GB15380@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207302114440.28003@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207302114440.28003@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, "Koul, Vinod" <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org

On Mon, Jul 30, 2012 at 09:28:18PM +0200, Guennadi Liakhovetski wrote:
> Hi all
> 
> as has been reported in this
> 
> http://thread.gmane.org/gmane.linux.kernel/1294256/focus001
> 
> thread, currently sh-sci doesn't comiple in the mainline and in -next if 
> CONFIG_SERIAL_SH_SCI_DMA is enabled. This patch series fixes this 
> breakage.
> 
Looks alright to me. Vinod, how do you want to handle this? I can roll
both of these patches in to my tree with your Acked-by, or I can provide
you with mine for the sh-sci bits if you want to take it via yours. I'm
planning on sending my next round of updates to Linus in the next couple
of days.

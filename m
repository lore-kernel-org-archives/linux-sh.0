From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 17 Jun 2013 15:51:19 +0000
Subject: Re: [PATCH 0/3] dma: add support for DMA multiplexer DT nodes
Message-Id: <201306171751.19984.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
 <20130612092349.GR4107@intel.com>
In-Reply-To: <20130612092349.GR4107-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

On Wednesday 12 June 2013, Vinod Koul wrote:
> On Thu, Jun 06, 2013 at 05:47:22PM +0200, Guennadi Liakhovetski wrote:
> > Next re-send of an earlier work. This series adds support for multiple 
> > compatible DMAC instances, capable of serving the same DMA slaves. 
> > Currently to specify such a configuration in DT, slaves would have to add 
> > DMA tuples for each requested channel for each suitable DMAC. This 
> > needlessly clutters the Device Tree. Instead we group such DMAC DT nodes 
> > together under a common parent. Then slaves can just reference that parent 
> > in their DMA bindings.
> > 
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> wasnt this series Acked by Anrd previosuly.
> 
> Neverthless, Anrd do you mind reviwing this

Sorry about the delay. The binding in patch 3 looks fine, but I have
a few comments about the implementation. Feel free to ignore those
if you think the code is good enough.

Trying to wrap my head around the mux binding now, to see if there
is a better way to do that.

	Arnd

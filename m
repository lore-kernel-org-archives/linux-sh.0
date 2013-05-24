From: Simon Horman <horms@verge.net.au>
Date: Fri, 24 May 2013 03:44:20 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: r8a7790: add SATA support
Message-Id: <20130524034418.GG10536@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1369361184-20862-1-git-send-email-horms+renesas@verge.net.au>
 <878v352kb4.wl%kuninori.morimoto.gx@renesas.com>
 <20130524025940.GA10536@verge.net.au>
 <8761y92htl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761y92htl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, May 23, 2013 at 08:11:05PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Because the lager board only seems to expose SATA1 and I was
> > interested in something I could test.
> > 
> > I am happy to start caring about SATA0 if you think it is
> > a good idea.
> 
> Caring both SATA0/1 are nice IMO :)
> 
> > > Can you use like this ?
> > > 
> > > static __init void r8a7790_register_sata(int id);
> > 
> > Sure, but I'm unsure how you want r8a7790_register_sata to handle id.
> > 
> > Is it just for the id field of struct platform_device_info pdevinfo?
> > Or also to switch between resources somehow?
> 
> can you check r8a7778_sdhi_init(int id, xxx) ?
> It is caring both id field and resources.

Thanks, I will look at that.

> > > BTW, we need to decide "driver registration function naming" ?
> > > In r8a7778 case, it is using 
> > > 
> > > 	r8a7778_add_xxx_device()
> > > 	r8a7778_add_xxx_devices()
> > > 
> > > but r8a7778_register_xxx seems nice naming :)
> > 
> > I chose register as it seemed to be consistent with the
> > existing contents of r8a7790_add_standard_devices().
> 
> OK, nice.
> 
> Do you think other chip (= r8a7778) should follow same naming?

I think it is not so important.

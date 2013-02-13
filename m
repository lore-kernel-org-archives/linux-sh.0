From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 08:06:30 +0000
Subject: Re: [PATCH/RFC v2 7/8] ARM: shmobile: parse DT and configure pinmux early on kzm9g-reference
Message-Id: <20130213080629.GQ30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-8-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-8-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 13, 2013 at 07:45:51AM +0100, Guennadi Liakhovetski wrote:
> Hi Simon
> 
> On Wed, 13 Feb 2013, Simon Horman wrote:
> 
> > On Fri, Feb 08, 2013 at 07:38:31PM +0100, Guennadi Liakhovetski wrote:
> > > GPIOs can be provided by the pinctrl subsystem, which can be initialised
> > > by DT. Therefore DT has to be parsed before requesting GPIOs. Also non-DT
> > > pinmux has to be configured early.
> > 
> > Thanks, applied to the boards-kzm9g-reference branch.
> > 
> > I am intending to merge that branch, which includes
> > the basic kzm9g reference code, into v3.10.
> 
> Thanks for merging. However, there's already a gotcha with this patch too: 
> this version is for a stack without sh73a0 DT pinctrl. If that's how 
> you're going to merge this patch - that is ok. However, if it should go on 
> top of DT pinctrl, the sh73a0_pinmux_init() call shouldn't be added, which 
> is also the version, that I've sent to you yesterday. IIUC sh73a0 pinctrl 
> DT isn't going to be in your tree yes, so, this patch should be ok. Then, 
> when merging pinctrl DT we'll have to remember to remove that call again.

Thanks for bringing that to my attention.

I did notice this problem when applying your patches today and my plan is:

* To apply this patch without sh73a0 DT pinctrl.
* Remove the sh73a0_pinmux_init() call as part of the sh73a0 DT pinctrl
  series.

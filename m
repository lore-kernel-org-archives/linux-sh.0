From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 07:59:46 +0000
Subject: Re: [PATCH v4 1/3] ARM: shmobile: ape6evm: add "__initconst" annotations where needed
Message-Id: <20130801075946.GE15265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375342881-2155-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375342881-2155-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 01, 2013 at 09:49:17AM +0200, Guennadi Liakhovetski wrote:
> Hi Simon,
> 
> On Thu, 1 Aug 2013, Simon Horman wrote:
> 
> > On Thu, Aug 01, 2013 at 09:41:19AM +0200, Guennadi Liakhovetski wrote:
> > > This patch adds __initconst markers to the platform data and resources,
> > > used on ape6evm as parameters to platform_device_register_resndata().
> > > The data is duplicated inside that function, therefore original data
> > > can be discarded after initialisation is completed.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > 
> > Hi Guennadi,
> > 
> > I was just in the process of queueing up v3 of this patch.
> > Should I update to v4 or is it the same as v3?
> 
> It is the same. Only patches, that have a "vN: ..." comment in them have 
> been modified.

Thanks, got it.

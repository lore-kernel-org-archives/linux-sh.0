From: Simon Horman <horms@verge.net.au>
Date: Tue, 24 Sep 2013 07:34:01 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: tidyup select SND_SOC_xxx on Kconfig
Message-Id: <20130924073357.GA32450@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8761tqsqs7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761tqsqs7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 23, 2013 at 11:25:03PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > bf622b33d6fd40f720430ec2fe3c62a8aee19ee8
> > > (ARM: shmobile: bockw: add R-Car sound support (PIO))
> > > added R-Car sound support on Bock-W, but the Kconfig
> > > file had comflict.
> > > The necessary settings (select SND_SOC_xxx) was added
> > > on MACH_KZM9D, but it was needed on MACH_BOCKW.
> > > This patch fixes it up.
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > Simon
> > > 
> > > This patch is based on renesas-devel-20130922 tag
> > 
> > Hi Morimoto-san,
> > 
> > is this a fix for v3.12?
> 
> Yes, Bock-W can't use sound without this patch

Hi Morimoto-san,

I looked a little closer and it seems that
bf622b33d6fd40f720430ec2fe3c62a8aee19ee8 is queued up for v3.13
rather than v3.12. (i.e. its not present in v3.12-rc1).

With this in mind I will queue up this patch for v3.13.
This will most likely occur tomorrow.



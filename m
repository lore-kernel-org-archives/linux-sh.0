From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 05:29:31 +0000
Subject: Re: [RFC][PATCH 3/4] ARM: shmobile: r8a7778: Register PFC drivce
Message-Id: <20130410052930.GA4742@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738v0b73z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 10:25:12PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > Actually, scratch that.
> > > > There is a run-time dependency on an earlier patch in the series, right?
> > > 
> > > This patch depends on [1/x] patch, and I will send v2 patch today
> > 
> > Thanks, understood.
> > 
> > Could you note that in the changelog, perhaps under a "---"?
> > It might help me to avoid the same mistake a second time.
> 
> Hmm...
> I guess "[3/4] depends on [1/4]" is normal ?

Yes, I guess so :^)

> But, whole this series depends on Laurent's
> 
> Subject: [PATCH v2 1/3] gpio-rcar: Add RCAR_GP_PIN macro
> Date:	Mon,  8 Apr 2013 12:05:30 +0200
> 
> Please see [0/4] comment

Thanks for clearing up my confusion.

From: Simon Horman <horms@verge.net.au>
Date: Mon, 25 May 2015 05:07:30 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: lager: Enable UHS-I SDR-50
Message-Id: <20150525050727.GA28560@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1431822459.4222.166.camel@xylophone.i.decadent.org.uk>
 <1431823184.4222.180.camel@xylophone.i.decadent.org.uk>
 <20150525010724.GD24690@verge.net.au>
 <87fv6ljokk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv6ljokk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Mon, May 25, 2015 at 04:00:11AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > On Sun, May 17, 2015 at 01:39:44AM +0100, Ben Hutchings wrote:
> > > Add the "1v8" pinctrl state and sd-uhs-sdr50 property to SDHI{0,2}.
> > > 
> > > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > > ---
> > > None of the states includes the CD pins, as they can't be allocated both
> > > through pinctrl and as GPIOs.  But the Lager manual shows these signals
> > > being pulled up to the same variable voltage as the other signals.  This
> > > might possibly lead to spurious card detect interrupts after switching
> > > to 1.8V signalling.
> > 
> > Morimoto-san,
> > 
> > I would appreciate your opinion on this change.
> 
> Ben will send new version patch set if my understanding is correct

Thanks, got it.

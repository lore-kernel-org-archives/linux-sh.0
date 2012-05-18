From: Simon Horman <horms@verge.net.au>
Date: Fri, 18 May 2012 02:55:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0: fixup PINT/IRQ16-IRQ31 irq number conflict
Message-Id: <20120518025547.GA26916@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87pqa48vrn.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pqa48vrn.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, May 17, 2012 at 12:35:42AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, May 16, 2012, Magnus Damm wrote:
> > On Wed, May 16, 2012 at 3:50 PM, Kuninori Morimoto
> > <kuninori.morimoto.gx@renesas.com> wrote:
> > > Current IRQ16-IRQ31 irq number are located around 800 from
> > > 1ee8299a9ec1ce5137a044c7768293007b9a3267
> > > (ARM: mach-shmobile: Use 0x3400 as INTCS vector offset)
> > >
> > > But, the PINT0/1 IRQ number are also located around 800 from
> > > 0df1a838d678fc6ab49f983a19e905f6a42297a0
> > > (ARM: mach-shmobile: sh73a0 PINT IRQ base fix)
> > >
> > > This patch relocates PINT0/1 IRQ number to around 700 where is not used,
> > > and adds current IRQ location table in comment area.
> > >
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > >>> Magnus
> > >
> > > I added IRQ location table on this patch.
> > > Please check it, and please give this patch your acked-by if you can agree this location.
> > 
> > Looking good, thanks for this!
> > 
> > Acked-by: Magnus Damm <damm@opensource.se>
> 
> Applied.

Thanks.

I have verified that this change resolves the problem that I was seeing.

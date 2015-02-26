From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 26 Feb 2015 07:14:40 +0000
Subject: Re: [PATCH 01/28 v3] dmaengine: export symbol of of_dma_request_slave_channel()
Message-Id: <20150226070240.GU5208@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
 <87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
 <87bnkk162d.wl%kuninori.morimoto.gx@renesas.com>
 <20150224162619.GH5208@intel.com>
 <87siduambe.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siduambe.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org

On Wed, Feb 25, 2015 at 12:03:03AM +0000, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> > > Current DMAEngine implementation of DT bindings can't support
> > > DT subnode. This patch export symbols of of_dma_request_slave_channel()
> > > for subnode DMA DT bingings.
> > > 
> > > ex)
> > > 
> > > rcar_sound: rcar_sound@ec500000 {
> > >         ...
> > >         rcar_sound,dvc {
> > >                 dvc0: dvc@0 {
> > >                         dmas = <&audma0 0xbc>;
> > >                         dma-names = "tx";
> > >                 };
> > >                 dvc1: dvc@1 {
> > >                         dmas = <&audma0 0xbe>;
> > >                         dma-names = "tx";
> > >                 };
> > >         };
> > >         ...
> > > };
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > Typically you should post whole series. Anyway, i am okay with this patch,
> > how do you want to merge this, should i pick it up or everything goes thru
> > ASoC tree or something else?
> 
> I don't know detail of maintenance side.
> Which is best ?

I think Mark can take the whole series with my ack on this one so

Acked-by: Vinod Koul <vinod.koul@intel.com>

I need I will pull Marks topic into mine but I think that may not be
required..

-- 
~Vinod


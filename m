From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 02:30:11 +0000
Subject: Re: [PATCH 0/18 v3] arm64: renesas: add sound support
Message-Id: <20151005023009.GI25427@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1xg1oc7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1xg1oc7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Sep 18, 2015 at 09:27:56PM +0900, Simon Horman wrote:
> On Fri, Sep 18, 2015 at 02:01:46AM +0000, Kuninori Morimoto wrote:
> > 
> > Hi Simon
> > 
> > These patches add sound support
> > previous patch-set didn't include SRC/DVC/CTU/MIX, but this time
> > these are included
> > 
> > Kuninori Morimoto (18):
> >       arm64: renesas: tidyup MSTP9 reverse definition order
> >       arm64: renesas: r8a7795: add I2C support
> >       arm64: renesas: r8a7795: add AUDIO_DMAC support
> >       arm64: renesas: r8a7795: Sound SSI PIO support
> >       arm64: renesas: r8a7795: Sound SSI DMA support
> >       arm64: renesas: r8a7795: Sound SRC support
> >       arm64: renesas: r8a7795: Sound DVC support
> >       arm64: renesas: r8a7795: Sound CTU/MIX support
> >       arm64: renesas: salvator-x: enable I2C
> >       arm64: renesas: salvator-x: Sound SSI PIO support
> >       arm64: renesas: salvator-x: Sound SSI DMA support
> >       arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
> >       arm64: renesas: salvator-x: Sound SRC support
> >       arm64: renesas: salvator-x: Sound DVC support
> >       arm64: defconfig: Enable Renesas R-Car I2C Controller
> >       arm64: defconfig: add Renesas sound and AK4613 support
> >       arm64: defconfig: add Renesas R-Car DMAC driver support
> >       arm64: defconfig: add CS2000 driver support

I have taken the liberty of making some minor updates to rebase this series
and add clock-names properties - it seems that is the way to go for now..

> * I have added the MSTP9 tidy-up patch and the 3 I2C patches
>   to topic/r8a7795-i2c-v3 in my renesas tree

    The updated branch is topic/r8a7795-i2c-v3.rebase.

    As I have also updated the GPIO patchset in a similar manner to this
    one I took the opportunity to squash the MSTP9 tidy-up patch into
    that series. The result is in the topic/r8a7795-gpio-v1.rebase2
    branch of my renesas tree.

>   It is based on the topic/r8a7795-gpio-v1.rebase branch
>   as both the i2c and gpio patch-sets update mtsp9.

    The base is now the topic/arm64-rcar-gen3-v10.1 branch of my
    renesas tree which is a tweaked version of
    "[PATCH v10 00/07] Renesas R-Car H3 (r8a7795) integration patches V10".

>   Ulrich (CCed), I think this has come up before; could you consider
>   including/squashing the MSTP9 tidyup in/into your next update
>   of the gpio patchset?
> 
> * I have added the other patches to topic/r8a7795-sound-v3
>   in my renesas tree.
> 
>   It is based on topic/r8a7795-i2c-v3 (above) as
>   "arm64: renesas: salvator-x: Sound SSI PIO support" modifies
>   the i2c2 node added by "arm64: renesas: salvator-x: enable I2C"

   The updated branch is topic/r8a7795-sound-v3.update.rebase.
   Its base is topic/r8a7795-i2c-v3.rebase.

> 
> * The above should take care of all 18 patches in this patch-set.
>   I believe all the other patch-sets in the set of patch-sets with this is
>   part of are driver changes and that Geert intends to handle getting them
>   into topic branches.
> 
> * Please check my work, I may well have made some errors when
>   sifting through conflicts.

Please check!
If there are any problems please consider reposting the i2c and/or
sound series.

Thanks.

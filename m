From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 24 Sep 2015 00:04:07 +0000
Subject: Re: [PATCH 03/18 v3] arm64: renesas: r8a7795: add AUDIO_DMAC support
Message-Id: <87twqkvg9d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878u841o94.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u841o94.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert, Simon

> On Fri, Sep 18, 2015 at 4:03 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > --- a/include/dt-bindings/clock/r8a7795-clock.h
> > +++ b/include/dt-bindings/clock/r8a7795-clock.h
> > @@ -32,6 +32,8 @@
> >  #define R8A7795_CLK_SCIF2              10
> >
> >  /* MSTP5 */
> > +#define R8A7795_CLK_AUDIO_DMAC0                2
> > +#define R8A7795_CLK_AUDIO_DMAC1                1
> 
> Please sort by increasing bit number.
> 
> Sorry for missing this before.

Thanks

>> Simon

I think this patch is already queued to topic branch.
Is it possible to replace to new patch ?
Or is additional patch better ?

Best regards
---
Kuninori Morimoto

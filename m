From: Simon Horman <horms@verge.net.au>
Date: Thu, 24 Sep 2015 05:14:19 +0000
Subject: Re: [PATCH 03/18 v3] arm64: renesas: r8a7795: add AUDIO_DMAC support
Message-Id: <20150924051417.GB3822@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878u841o94.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878u841o94.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 24, 2015 at 12:04:07AM +0000, Kuninori Morimoto wrote:
> 
> Hi Geert, Simon
> 
> > On Fri, Sep 18, 2015 at 4:03 AM, Kuninori Morimoto
> > <kuninori.morimoto.gx@renesas.com> wrote:
> > > --- a/include/dt-bindings/clock/r8a7795-clock.h
> > > +++ b/include/dt-bindings/clock/r8a7795-clock.h
> > > @@ -32,6 +32,8 @@
> > >  #define R8A7795_CLK_SCIF2              10
> > >
> > >  /* MSTP5 */
> > > +#define R8A7795_CLK_AUDIO_DMAC0                2
> > > +#define R8A7795_CLK_AUDIO_DMAC1                1
> > 
> > Please sort by increasing bit number.
> > 
> > Sorry for missing this before.
> 
> Thanks
> 
> >> Simon
> 
> I think this patch is already queued to topic branch.
> Is it possible to replace to new patch ?
> Or is additional patch better ?

If you only wish to change this one patch then I'm happy to try
to update just one patch.

I am also happy for you to post a new series any time.
If so it would help me if you ordered the patches such that
all the i2c patches are followed by all the sound patches
as per what you can see in the following topic branches in my
renesas tree:

topic/r8a7795-sound-v3
topic/r8a7795-i2c-v3

Basing your series on the latest topic/r8a7795-gpio branch
(currently topic/r8a7795-gpio-v1.rebase) would be even better for me.

From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 May 2012 09:11:35 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: tidyup: sound card detection order
Message-Id: <20120529091129.GA26043@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4rmqzd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 29, 2012 at 12:40:08AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon, Paul
> 
> Thank you for checking patch
> 
> > > > Is the problem that a previous patch altered the order of the
> > > > ALSA index of the sound cards? And this patch restores the previous order?
> > > > 
> > > > If so, I wonder if this is really necessary as is should
> > > > be possible to set the index using a module parameter if one
> > > > is relying on it.
> > > > 
> > > One would expect so. What happens if the ALSA drivers are built as
> > > modules and inserted in random order today? If you require persistent
> > > assignment then you will have to deal with it either through module
> > > parameters or udev.
> > 
> > I'm unsure if that was a rhetorical question or not,
> > but I believe the answer is yes.
> 
> Yes.
> The ALSA card list order was same as inserted alsa-module
> order if it was built as module.
> This is very OK.
> And I'm not sure ALSA already has index specification method.
> Sorry for my confusion.
> My problem was deferred probe order on built-in.

I was under the impression that the index could be set for a built-in too.
But poking around in /sys on an armadillo board, that seems not to be the
case.

> 
> Current my issue is...
>   normal probe of ALSA-card.0  -> requests probe deferral
>   normal probe of ALSA-card.1  -> requests probe deferral
>   ...
>   deferred-probe of ALSA-card.1  <= order changed
>   deferred-probe of ALSA-card.0  <= order changed
> 
> Now, I re-checked and noticed that
> the main issue was additional method for deferred_probe_pending_list on dd.c.
> 
> Below patch solved this issue.
> What do you think this ?

It seems reasonable to expect things to be appended not prepended,
so I think your patch makes some sense.

I'm not entirely sure it makes any sense to be relying on the
order of cards being initialised. But I guess the order of
initialisation is relied on in other places too.

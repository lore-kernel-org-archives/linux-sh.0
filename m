From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Wed, 13 Jun 2012 00:33:46 +0000
Subject: Re: [PATCH] driver core: fixup reversed deferred probe order
Message-Id: <20120613003346.GB5321@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120529073313.GA21702@verge.net.au>
 <87k3zvmo4r.wl%kuninori.morimoto.gx@renesas.com>
 <20120529091129.GA26043@verge.net.au>
 <87txyy347i.wl%kuninori.morimoto.gx@renesas.com>
 <87sjei325k.wl%kuninori.morimoto.gx@renesas.com>
 <20120530013056.GA31474@verge.net.au>
 <87r4u2310j.wl%kuninori.morimoto.gx@renesas.com>
 <87pq9m30h1.wl%kuninori.morimoto.gx@renesas.com>
 <20120612231705.GB6177@kroah.com>
 <874nqg84do.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nqg84do.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Paul Mundt <lethal@linux-sh.org>, Rafael <rjw@sisk.pl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On Tue, Jun 12, 2012 at 05:03:38PM -0700, Kuninori Morimoto wrote:
> 
> Hi Greg
> 
> Thank you for checking this patch
> 
> > > If driver requests probe deferral,
> > > it will be added to deferred_probe_pending_list
> > > by driver_deferred_probe_add(), but, it used list_add().
> > > Because of that, deferred probe will be run as reversed order.
> > > This patch uses list_add_tail(), and solved this issue.
> > 
> > Is this causing a problem with 3.5-rc2 on some systems, so it needs to
> > get into 3.5-final, or can it wait for 3.6?
> 
> ALSA SoC sound card detection order was broken by this issue in v3.5-rcX
> (on some board).
> So, I'm happy if it was included in v3.5-final.

Ok, thanks for letting me know, will queue it up for that release.

greg k-h

From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Feb 2014 01:32:08 +0000
Subject: Re: [PATCH] ARM: shmobile: bockw: use wp-gpios instead of WP pin
Message-Id: <87zjm7fyst.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<87zjmc676u.wl%kuninori.morimoto.gx@gmail.com>
	<20140203063549.GD30047@verge.net.au>
In-Reply-To: <20140203063549.GD30047@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org


Hi Simon

> > Latest Renesas Chip has some SDHI channels and the WP pin
> > availability depends on its channel or HW implementation.
> > Thus, this patch decides new policy whch indicates
> > WP is disabled as default.
> > But, we can use wp-gpios property to enable it as
> > other method.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > Simon
> > 
> > This was included on v1 patch series,
> > but no relationship with mmc part patches.
> 
> So I could take this patch into the renesas tree now?

Yes, I guess so

# my PC broken this morning somehow...

Best regards
---
Kuninori Morimoto

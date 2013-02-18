From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Feb 2013 04:35:18 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START
Message-Id: <87vc9qme7x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
 <1360933261-6359-6-git-send-email-horms+renesas@verge.net.au>
 <87621qo2tc.wl%kuninori.morimoto.gx@renesas.com>
 <20130218013238.GB11807@verge.net.au>
In-Reply-To: <20130218013238.GB11807@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon

> > > Remove .init_late and .restart from DT_MACHINE_START
> > > for kzm9g reference as these are not necessary to
> > > bring the board up which is the main aim of kzm9g reference.
> > 
> > Does this mean that we will have "full spec kzm9g DT base" code in the future,
> > and then, "kzm9g reference" code will be deleted ?
> 
> Yes, I think that is the plan.

I see, Thank you.

Best regards
---
Kuninori Morimoto

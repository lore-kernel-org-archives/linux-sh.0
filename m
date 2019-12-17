From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Dec 2019 07:37:05 +0000
Subject: Re: [PATCH] SH: Convert iounmap() macros to inline functions
Message-Id: <87bls7h07z.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87eex3h2g6.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87eex3h2g6.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sam

Thank you for your review

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Macro iounmap() do nothing, but that results in
> > unused variable warnings all over the place.
> > This patch convert it to inline to avoid warning
> 
> To help other people with the same warning it is always a good idea to
> include the warning you fix in the changelog.
>
> With this fixed:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

will fix and post v2, Thanks

Thank you for your help !!
Best regards
---
Kuninori Morimoto

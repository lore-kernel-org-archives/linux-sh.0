From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Mar 2013 08:55:47 +0000
Subject: Re: [PATCH 3/3 v2] ARM: shmobile: add R-Car M1A Bock-W platform support
Message-Id: <87y5dq2wds.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2v5rpck.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2v5rpck.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei

> > +/ {
> > +	model = "bockw";
> > +	compatible = "renesas,bockw", "renesas,r8a7778";
> 
>     Shouldn't the above coincide with the below?
(snip)
> > +static const char *bockw_boards_compat_dt[] __initdata = {
> > +	"renesas,bockw-reference",
> > +	NULL,
> > +};

Thank you for pointing it.
It will be fixed in v2


Best regards
---
Kuninori Morimoto

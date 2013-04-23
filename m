From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 23 Apr 2013 00:32:39 +0000
Subject: Re: [PATCH 1/3 v3] sh-pfc: r8a7778: add common PFC macro helper
Message-Id: <87mwsq5bob.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738un6wwd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738un6wwd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

> On Thursday 18 April 2013 20:07:34 Kuninori Morimoto wrote:
> > pfc-r8a7778 will have many devices pfc support in the future,
> > and current pfc-r8a7778 is using pin/mux definition macro for SCIF.
> > The device definition style using macro is readable code IMO,
> > but creating new macro for each devices is not good sense.
> > This patch adds common SH_PFC_xx() macro for each new feature devices
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
(snip)
> > +#define SH_PFC_MUX4(name, arg1, arg2, arg3, arg4)			\
> > +	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, \
> > +						     arg3##_MARK, arg4##_MARK }
> 
> What's your plan for groups of more than 4 pins ? :-)
> 
> At some point, when the groups get large, I think it's better to define the 
> arrays explicitly.

Yes, I think so.

I am not forcing use of macro here.
If you can use these macros, you can use it.
If it is not match for your new pin, you can use array style.
I don't care so much.
Fortunately, these SCIF/SDHI cases, these can use macro.

Best regards
---
Kuninori Morimoto

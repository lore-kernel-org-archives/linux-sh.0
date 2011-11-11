From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 03:25:33 +0000
Subject: Re: [PATCH 02/20] serial: sh-sci: clean up white space
Message-Id: <877h379w7q.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5vn9y5r.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5vn9y5r.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for checking.

> On Thu, Nov 10, 2011 at 06:43:31PM -0800, Kuninori Morimoto wrote:
> >  #define SCxSR_ERRORS(port)	(to_sci_port(port)->cfg->error_mask)
> >  
> > -#if defined(CONFIG_CPU_SUBTYPE_SH7705) || \
> > -    defined(CONFIG_CPU_SUBTYPE_SH7720) || \
> > -    defined(CONFIG_CPU_SUBTYPE_SH7721) || \
> > -    defined(CONFIG_ARCH_SH73A0) || \
> > -    defined(CONFIG_ARCH_SH7367) || \
> > -    defined(CONFIG_ARCH_SH7377) || \
> > -    defined(CONFIG_ARCH_SH7372)
> > +#if	defined(CONFIG_CPU_SUBTYPE_SH7705) ||\
> > +	defined(CONFIG_CPU_SUBTYPE_SH7720) ||\
> > +	defined(CONFIG_CPU_SUBTYPE_SH7721) ||\
> > +	defined(CONFIG_ARCH_SH73A0) ||\
> > +	defined(CONFIG_ARCH_SH7367) ||\
> > +	defined(CONFIG_ARCH_SH7377) ||\
> > +	defined(CONFIG_ARCH_SH7372)
> >  # define SCxSR_RDxF_CLEAR(port)	 (sci_in(port, SCxSR) & 0xfffc)
> >  # define SCxSR_ERROR_CLEAR(port) (sci_in(port, SCxSR) & 0xfd73)
> >  # define SCxSR_TDxE_CLEAR(port)	 (sci_in(port, SCxSR) & 0xffdf)
> 
> Err, no. I don't see this as an improvement, and I don't really see what
> you think the issue with the first format is, either.

OK. this is not important. please drop it.
but [PATCH 11/20] ARM: mach-shmobile: R-Mobile A1 support.
is depend on this patch.
I will re-post it.

Best regards
---
Kuninori Morimoto

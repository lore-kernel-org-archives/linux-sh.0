From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Apr 2013 02:41:09 +0000
Subject: Re: [PATCH 1/3 v2] sh-pfc: Add r8a7778 pinmux support
Message-Id: <87r4ihrdq6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvyyk9yp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvyyk9yp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent

Thank you for your review

> > +/* Pin numbers for pins without a corresponding GPIO port number are
> > computed + * from the row and column numbers with a 1000 offset to avoid
> > collisions with + * GPIO port numbers.
> > + */
> > +#define PIN_NUMBER(row, col)		(1000+((row)-1)*25+(col)-1)
> > +
> > +/* - SCIF macro
> > ------------------------------------------------------------- */ +#define
> > SCIF_PFC_PIN(name, args...)					\
> > +	static const unsigned int name ##_pins[] = { args }
> > +#define SCIF_PFC_DAT(name, arg1, arg2)					\
> > +	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, }
> 
> I would probably have named the arguments tx and rx instead of arg1 and arg2, 
> but that's up to you.
> 
> > +#define SCIF_PFC_CTR(name, arg1, arg2)					\
> > +	static const unsigned int name ##_mux[]  = { arg1##_MARK, arg2##_MARK, }
> 
> And cts and rts here.
> 
> > +#define SCIF_PFC_CLK(name, arg1)					\
> > +	static const unsigned int name ##_mux[]  = { arg1##_MARK, }
> 
> And sck here (it's still up to you :-)).

Thank you.
I agree it, will fix on v3

> Could you please move HSCIF0 and HSCIF1 above SCIF* to keep the functions 
> alphabetically sorted (here and below in pinmux_groups, pinmux_functions and 
> in the *_groups arrays) ? Otherwise the code will become pretty difficult to 
> navigate when we'll add more functions.

Yes, indeed.
I didn't notice about alphabetically.
will fix on v3

Best regards
---
Kuninori Morimoto

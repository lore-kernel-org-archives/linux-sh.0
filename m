From: takasi-y@ops.dti.ne.jp
Date: Fri, 04 Oct 2013 05:44:43 +0000
Subject: Re: [PATCH 5/6] clk: emev2: Add support for emev2 SMU clocks with DT
Message-Id: <20131004144443.a7590dd81b8901ef264e488f@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
	<20130924131542.f865fad4dec98e024c0d4676@ops.dti.ne.jp>
	<CANqRtoRD35Ei31PK8a_TOp=2uiYPCoaJuDb6tyZtQL8s0PavNw@mail.gmail.com>
In-Reply-To: <CANqRtoRD35Ei31PK8a_TOp=2uiYPCoaJuDb6tyZtQL8s0PavNw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Magnus,
Thank you for your commnets.

> > +obj-$(CONFIG_ARCH_SHMOBILE)    += shmobile/
> > +obj-$(CONFIG_ARCH_SHMOBILE_MULTI)      += shmobile/
> 
> Here I believe it is enough that you only use
> CONFIG_ARCH_SHMOBILE_MULTI. ...

That is because it supports three configuration,
1. MULTI + KZM9D_REFERENCE + COMMON_CLK
2. KZM9D_REFERENCE + COMMON_CLK
3. KZM9D
but,

> ... Building common clocks to coexist with the
> old legacy board code does not make any sense IMO. ...
I think so, too.
And from the view of testing, having smaller variants is better.
# easier :)

> > +ifeq ($(CONFIG_COMMON_CLK), y)
> > +obj-$(CONFIG_ARCH_EMEV2)       += clk-emev2.o
> > +endif
> 
> I don't think you would need the above ifeq/endif wrapper if you only
> used CONFIG_ARCH_SHMOBILE_MULTI above.
Right.

Anyway, because you have make kzm9d-reference things simpler,
now we don't need to worry about it.

Thanks,
/yoshii

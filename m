From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Sep 2013 07:17:17 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: kzm9d-reference:  migrate to common clock framework with DT
Message-Id: <87siwtl69z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
In-Reply-To: <52410F86.4040301-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Takashi Yoshii <takashi.yoshii.zj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi Yoshii-san

> Next one is a proposal document of DT bindings.
> [PATCH 4/6] ARM: shmobile: emev2: Define SMU clock DT bindings
> 
> This is the implementation, and dts which carries clock tree description.
> [PATCH 5/6] clk: emev2: Add support for emev2 SMU clocks with DT

Documentation and implementation in one patch,
and dts in other patch, are normal style IMO

I mean
4/6 + 5/6's implementation part,
5/6's dts part


Best regards
---
Kuninori Morimoto

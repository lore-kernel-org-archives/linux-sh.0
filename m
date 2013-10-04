From: takasi-y@ops.dti.ne.jp
Date: Fri, 04 Oct 2013 01:12:16 +0000
Subject: Re: [PATCH 0/6] ARM: shmobile: kzm9d-reference:  migrate to common clock framework with DT
Message-Id: <20131004101216.5dd1327a1a03171968a09232@ops.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <52410F86.4040301@renesas.com>
	<87siwtl69z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87siwtl69z.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org, Shinya Kuribayashi <shinya.kuribayashi.px-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Paul Mundt <lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,
 
> Documentation and implementation in one patch,
> and dts in other patch, are normal style IMO

That's strange! Considering the nature of DT, it must be wrong.
... was what I thought at first, but you are right.
I found 3/4 (1021 in 1365) of commits (new + change - typo fix)
under Documentation/devicetree/bindings/ has come with .c code.

Thank you for let me know.
/yoshii

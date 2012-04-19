From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Apr 2012 23:58:11 +0000
Subject: Re: ARM: mach-shmobile: remove pointless global clocks
Message-Id: <87ehrjuvea.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
In-Reply-To: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus, Rafael

Thank you for reviewing this

> Perhaps that's what you feel is lazy, but I prefer to have the
> compiler doing the checks for us with global symbols instead of
> relying on run-time checked errors with clk_get(). Also, usually we
> don't have any struct device in the board code, so this means we have
> to use clk_get(NULL, "string" ) which is both ugly and a corner case.
(snip)
> > Hmm... Yes, these are just clean-up.
> > But I don't like many global variable.
> > So, how about just removing "un-used" global variable at this point ?
> > When we use these clocks in the future, we can use clk_get()
> 
> I prefer not to use clk_get(NULL, "string"). And I think the global
> variables are useful too for people that maintain out-of-tree boards.

OK.
These are not super important patches.
(and indeed, clk_get(NULL, "string") is ugly :)

Please drop these patches.

Best regards
---
Kuninori Morimoto

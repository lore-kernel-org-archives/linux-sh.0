From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Apr 2012 01:08:02 +0000
Subject: Re: ARM: mach-shmobile: remove pointless global clocks
Message-Id: <87bomoh6ky.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
In-Reply-To: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for checking patch

> So I remember that we made the root clock symbols global to make it
> easy for board code to override. This is moving it back again.

I forgot detail of that, but the original kernel had global clocks from startup timing.
So I can say it is not moving back.
(I remember we re-name the global clocks. yyy_clk -> shXXXX_yyy_clk)
We could keep these clocks under static,
but we selected lazy solution (= use global) for board settings.

> Perhaps the right way do deal with this is to modify the
> foobar_clock_init() functions to take the board specific frequency as
> paramenters?

Hmm... sorry, but I can't agree this.
Because we have many clocks, and many todo for board clock.
Change parent, frequency, etc etc...
Adding these in foobar_clock_init() paramenters is just difficult/complex.
And, sometimes, we can't select the correct clock settings when foobar_clock_init() timing.

> OTOH, with the common clock framework and upcoming DT bindings and
> whatnot I must say that I prefer not to move things around unless we
> have a technical reason for the change.

Hmm... Yes, these are just clean-up.
But I don't like many global variable.
So, how about just removing "un-used" global variable at this point ?
When we use these clocks in the future, we can use clk_get()

Best regards
---
Kuninori Morimoto

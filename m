From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 19 Apr 2012 08:28:08 +0000
Subject: Re: ARM: mach-shmobile: remove pointless global clocks
Message-Id: <CANqRtoT4P6Ei6T06BszVvGF3vHV-gUzGAo=eWzT9thBHcbEszg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
In-Reply-To: <CANqRtoTkLPRDGUxR9j+wkwuf9vdvu5O6eEUDcB0ST=t+fqrreg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, Apr 19, 2012 at 10:08 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Magnus
>
> Thank you for checking patch
>
>> So I remember that we made the root clock symbols global to make it
>> easy for board code to override. This is moving it back again.
>
> I forgot detail of that, but the original kernel had global clocks from startup timing.
> So I can say it is not moving back.
> (I remember we re-name the global clocks. yyy_clk -> shXXXX_yyy_clk)
> We could keep these clocks under static,
> but we selected lazy solution (= use global) for board settings.

Perhaps that's what you feel is lazy, but I prefer to have the
compiler doing the checks for us with global symbols instead of
relying on run-time checked errors with clk_get(). Also, usually we
don't have any struct device in the board code, so this means we have
to use clk_get(NULL, "string" ) which is both ugly and a corner case.

>> Perhaps the right way do deal with this is to modify the
>> foobar_clock_init() functions to take the board specific frequency as
>> paramenters?
>
> Hmm... sorry, but I can't agree this.
> Because we have many clocks, and many todo for board clock.
> Change parent, frequency, etc etc...
> Adding these in foobar_clock_init() paramenters is just difficult/complex.
> And, sometimes, we can't select the correct clock settings when foobar_clock_init() timing.

I agree that it's not a very good idea.

>> OTOH, with the common clock framework and upcoming DT bindings and
>> whatnot I must say that I prefer not to move things around unless we
>> have a technical reason for the change.
>
> Hmm... Yes, these are just clean-up.
> But I don't like many global variable.
> So, how about just removing "un-used" global variable at this point ?
> When we use these clocks in the future, we can use clk_get()

I prefer not to use clk_get(NULL, "string"). And I think the global
variables are useful too for people that maintain out-of-tree boards.

Cheers,

/ magnus

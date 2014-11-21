From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2014 21:23:12 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <CAMuHMdVFffoA3AHFVxbBuNDVMFu1otD0jY7fWsuu-Kb5rZeDUA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Nov 10, 2014 at 10:14 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Nov 6, 2014 at 7:20 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> On Wednesday 05 November 2014 22:06:38 Geert Uytterhoeven wrote:
>>> On Wed, Nov 5, 2014 at 4:43 PM, Laurent Pinchart wrote:
>>> >> > As Laurent has pointed out before, the LAN controller is not
>>> >> > (directly) hooked up to this clock, but to an external oscillator.
>>> >> > Nonetheless Ethernet won't work unless ZB is on, which I have
>>> >> > determined by trial and error. Maybe that should have been pointed out
>>> >> > in the description...
>>> >>
>>> >> I don't have the schematics for kzm9g, but I guess the LAN controller
>>> >> is hooked up to the BSC (Bus State Controller).
>>> >
>>> > Yes it is. We should probably model the BSC in DT, and add the LAN
>>> > controller as a child of the BSC node. With automatic clock management in
>>> > runtime PM, could we do without a BSC driver entirely ?
>>>
>>> I'm afraid we're gonna need a bus driver to handle that correctly.
>>> Especially when considering the BSC is in a PM domain (A4S).
>>>
>>> Fortunately A4S is always powered when the CPU is talking to Ethernet,
>>> as A4S contains the CPU cores, too.
>>
>> If the BSC DT node references the MSTP clock and the power domain, do you
>> think it would be possible to let core code handle them without requiring a
>> custom driver (obviously with extensions to core code) ?
>
> I'll have to dive a bit deeper to answer that question...

I now believe it can work fine with a really minimal BSC driver, provided the
drivers for the devices hooked up on the bus also have runtime PM support.
I'm sorting out some rough edges, so please stay tuned...

As this minimal BSC driver isn't hardware-specific at all, we may be able to
shove this into core code...

> For now, adding the clocks to the Ethernet node works, as the
> drivers/sh/pm_runtime.c hack works for all platform devices.
> Once we'll have DT PM domains on sh73a0, it'll no longer work, as SoC clocks
> will be managed for devices belonging to an SoC PM domain only.

Please ignore my last comment. As the smsc911x driver manages the clock
explicitly (if it exists), it does not rely on clock management from
drivers/sh/pm_runtime.c or pm-rmobile.c.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

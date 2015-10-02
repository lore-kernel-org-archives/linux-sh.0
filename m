From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 07:12:08 +0000
Subject: Re: [PATCH v8 03/05] clk: shmobile: Add Renesas Module Standby and Reset driver
Message-Id: <CAMuHMdWsWFaefBfh-_TNN2uuVYCpK6i5aciLp4DHECAek7MxVw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151001143717.20618.26365.sendpatchset@little-apple>
	<20151001143748.20618.7279.sendpatchset@little-apple>
	<CAMuHMdV=kKS+R4SFHrmZL5pntpdAP1tR1kRyKKsW0fD1nVrj1w@mail.gmail.com>
	<CANqRtoRgzKKUi0WL=bPqp2B7K065Frco=S4WrYHD0a1dA7mVYQ@mail.gmail.com>
In-Reply-To: <CANqRtoRgzKKUi0WL=bPqp2B7K065Frco=S4WrYHD0a1dA7mVYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Fri, Oct 2, 2015 at 6:10 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Fri, Oct 2, 2015 at 12:28 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Oct 1, 2015 at 4:37 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> From: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Add a driver for the Renesas Module Standby and Software Reset module
>>> found in several Renesas SoCs.
>>>
>>> This driver is based on the existing R-Car MSTP driver, and is intended
>>> to replace it.
>>> The existing driver is limited to Module Standby, and has bindings that
>>> are difficult to extend to more register sets for e.g. reset control.
>>>
>>> TODO:
>>>   - Implement module reset handling,
>>>   - Write binding documentation.
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>
>> Thanks, I'm happy you like it!
>
> Yeah, it looks good!
>
> I'm interested in learning how to tie in the reset functionality via
> DT though, do we need any integration update for that?

Yes, in addition to the "clocks = <&mssr R8A7795_CLK_xxx>" property, every
device node need a "resets = <&mssr R8A7795_CLK_xxx>" property (and an optional
reset-names property). In the case of e.g. DU, it needs multiple resets, just
like it needs multiple clocks.

Cfr. Documentation/devicetree/bindings/reset/reset.txt

Perhaps the R8A7795_CLK_xxx should be renamed to R8A7795_MOD_xxx?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

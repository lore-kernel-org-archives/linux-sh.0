From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 29 Sep 2015 13:43:37 +0000
Subject: Re: [PATCH/RFC v2 4/4] clk: shmobile: rcar-gen2: Switch from old MSTP to new MSSR driver
Message-Id: <CAMuHMdXWONWNBQocy4=PPB93BYvRuz1=3SLH6u6xLOykj+x71w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442936646-30362-1-git-send-email-geert+renesas@glider.be>
	<1442936646-30362-5-git-send-email-geert+renesas@glider.be>
	<CAMuHMdW3o0WCGCXuyYJtd8nC691N62wK7NNTzTQTM7fAvCn8jg@mail.gmail.com>
	<CANqRtoTMgZRU6bmp9VoK6O5xDNKc0zkf-xmepgkY2ZyYXW5-mQ@mail.gmail.com>
In-Reply-To: <CANqRtoTMgZRU6bmp9VoK6O5xDNKc0zkf-xmepgkY2ZyYXW5-mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-clk <linux-clk@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Magnus,

On Tue, Sep 29, 2015 at 3:30 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Tue, Sep 29, 2015 at 9:48 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, Sep 22, 2015 at 5:44 PM, Geert Uytterhoeven
>> <geert+renesas@glider.be> wrote:
>>> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
>>> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
>>> @@ -431,7 +431,7 @@ static void __init rcar_gen2_cpg_clocks_init(struct device_node *np)
>>>
>>>         of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
>>>
>>> -       cpg_mstp_add_clk_domain(np);
>>> +       cpg_mssr_add_clk_domain(np);
>>
>> Of course this should become conditional on the presence of the new
>> "renesas,r8a7791-cpg-mssr" compatible value, to preserve
>> backwards-compatibility with old DTSes.
>
> Yeah, and we should probably link in both clk-mstp.o and clk-mssr.o
> for older SoCs.

Yep, been there, done that (local code updated and working ;-)

The conditional in drivers/sh/pm_runtime.c is getting a bit too gory for my
appetite. I think we should make PM (and thus PM_GENERIC_DOMAINS) mandatory.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 07:30:03 +0000
Subject: Re: [PATCH v2] clk: shmobile: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <CAMuHMdU9B1pkSLUwW0C9_6z+AWUYEMUrFGd82QSjw6HS8A_PRw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150826074309.4298.76147.sendpatchset@little-apple>
	<CAMuHMdVXJ8Te_Rwn2WZCdXdh_+0__S6QEp7ZBzggpY-UgqtqLA@mail.gmail.com>
	<CANqRtoSccKdT9W_xhJ-xNQjbrJBEfGgn4uHaYM7=ieZt3gTT0g@mail.gmail.com>
In-Reply-To: <CANqRtoSccKdT9W_xhJ-xNQjbrJBEfGgn4uHaYM7=ieZt3gTT0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Magnus,

On Wed, Sep 2, 2015 at 8:52 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Aug 26, 2015 at 4:48 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Aug 26, 2015 at 9:43 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>> From: Magnus Damm <damm+renesas@opensource.se>
>>>
>>> Shmobile is all multiplatform these days, so get rid of the
>>> reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
>>> enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
>>> MSTP depending on if they are included in the SoC or not.
>>>
>>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>> ---
>>>
>>>  Changes since V1:
>>>  - dropped DIV6 from R-Car Gen1 variants - thanks Geert!
>>
>> BTW, you forgot to mention, but it's important for Mike and Stephen to
>> know that this should not be queued up in a branch that still has
>> ARCH_SHMOBILE_LEGACY.
>
> Allow me to clarify one thing.
>
> Your comment is true for this older version of this patch, but newer
> versions such as:
> [PATCH v5 01/05] clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI
> and later versions do not have this dependency on ARCH_SHMOBILE_LEGACY cleanups.
>
> So newer versions can be merged at any time without any special dependencies.

That's correct, as they don't get rid of CONFIG_ARCH_SHMOBILE_MULTI in
drivers/clk/Makefile...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

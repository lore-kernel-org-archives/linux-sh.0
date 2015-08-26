From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 26 Aug 2015 08:07:25 +0000
Subject: Re: [PATCH v2] clk: shmobile: Get rid of CONFIG_SHMOBILE_MULTI
Message-Id: <CANqRtoTKJRwg1dxy9DGL3eeBwGTFzmYrEs6kkwipw+HhO1HKdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150826074309.4298.76147.sendpatchset@little-apple>
	<CAMuHMdX9pzpBhOpN8_Cn=kiAHr9vrRP19brc26b+3vUp52QwhA@mail.gmail.com>
In-Reply-To: <CAMuHMdX9pzpBhOpN8_Cn=kiAHr9vrRP19brc26b+3vUp52QwhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Wed, Aug 26, 2015 at 4:55 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Wed, Aug 26, 2015 at 9:43 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Shmobile is all multiplatform these days, so get rid of the
>> reference to CONFIG_ARCH_SHMOBILE_MULTI. Also instead of always
>> enabling DIV6 and MSTP adjust the Makefile to enable DIV6 and
>> MSTP depending on if they are included in the SoC or not.
>>
>> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> BTW, the symbol name in the subject lacks an "ARCH_" infix.
>
> Too many replies to the same patch, time for coffee...

Ouch, that's for V3 then...

Thanks,

/ magnus

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 23 Oct 2015 11:25:14 +0000
Subject: Re: [PATCH v4 2/5] [RFC] clk: shmobile: Add r8a7795 CPG Core Clock Definitions
Message-Id: <CAMuHMdUmiPFykkSFcNBjWcgUXUvQpNZTm82nxKNwNOSw7b7BZg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-3-git-send-email-geert+renesas@glider.be>
	<2464036.AexIB1O0H1@avalon>
In-Reply-To: <2464036.AexIB1O0H1@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Fri, Oct 23, 2015 at 1:21 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +#define R8A7795_CLK_R                        45
>> +#define R8A7795_CLK_OSC                      46
>
> Those two clocks are called RCLK and OSCCLK in the datasheet, shouldn't w=
e use
> those names ?

..._CLK_RCLK and ..._CLK_OSCCLK sound a bit heavy to me.

Besides, all other clocks in the datasheet have a "=CF=86" suffix, which al=
so
means "CLK", and which we don't retain.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

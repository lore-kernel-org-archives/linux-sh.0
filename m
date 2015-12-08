From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Dec 2015 09:38:13 +0000
Subject: Re: [PATCH v6 4/5] clk: shmobile: Add new CPG/MSSR driver core
Message-Id: <CAMuHMdVY_Vm5V0m_wznHbC6oy+=fov6h=cYg-BVJqTvR=LS=6Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
	<1447343686-2038-5-git-send-email-geert+renesas@glider.be>
	<1816814.hXph9CLyDv@avalon>
In-Reply-To: <1816814.hXph9CLyDv@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, linux-clk <linux-clk@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Dec 5, 2015 at 4:08 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> +static inline int cpg_mssr_add_clk_domain(struct device *dev,
>> +                                       const unsigned int *core_pm_clks,
>> +                                       unsigned int num_core_pm_clks) {}
>
> The function is missing a return statement.

Thank you, will include for v7 and/or final pull request.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

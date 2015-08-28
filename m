From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2015 08:44:34 +0000
Subject: Re: [PATCH 3/4 v3][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <CAMuHMdX0SWqy7SREuvXd54cm2SCGdNDtq_6PSOqpkVrXK7DjsA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877fpdw3av.wl%kuninori.morimoto.gx@renesas.com>
	<873801w377.wl%kuninori.morimoto.gx@renesas.com>
	<1559394.i3FG4v33fI@avalon>
	<CAMuHMdX+edyEWNaSV5d7Knxs8ZjxN7hLPqQgmb+4awNNnfpRDQ@mail.gmail.com>
	<20150818002018.31346.63666@quantum>
	<CAMuHMdXDuG5izkMCrBmTtznbFNQzXUVLKTrG9a_K=L2qbbkv5Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXDuG5izkMCrBmTtznbFNQzXUVLKTrG9a_K=L2qbbkv5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Mike,

On Wed, Aug 19, 2015 at 9:49 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Aug 18, 2015 at 2:20 AM, Michael Turquette
> <mturquette@baylibre.com> wrote:
>> Also, while you're thinking about the perfect clock binding, please do
>> consider dropping clock-output-names if you can. Specifying clock-names
>> alongside the clocks property inside of the consumer node is a bit more
>> elegant in my opinion. This is also a bit easier if you think about
>> expressing your clock data with C inside of your provider driver.
>
> Makes sense. I don't think anything relies on the "clock-output-names"
> ... currently.

BTW, was "dropping clock-output-names" a general comment for all clock
drivers, or specific to the SoC's Clock Pulse Generator?

For e.g. "fixed-factor-clock", the driver falls back to using the node's name
if  "clock-output-names" is not present.

But e.g. for MSTP clocks, that can't be done, as the clocks wouldn't have
names in that case (single node with multiple clocks). Unless we start
fabricating them from the node name and the indices.

> I was going to use it for identifying the GIC clock, though:

That applies to MSTP clocks ("intc-sys"), not the main CPG block clocks.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

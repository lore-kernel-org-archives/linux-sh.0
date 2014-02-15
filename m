From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 15 Feb 2014 13:20:16 +0000
Subject: Re: [PATCH 2/3] renesas: change to using clock-indices
Message-Id: <CAMuHMdWzmaJEb47n5rTjYg8oCWd3fSV=vArDjuvttuWvbU99hg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1392314571-30107-2-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent, Magnus,

On Fri, Feb 14, 2014 at 3:34 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> >> Regarding how to roll it into the SoC code, I feel that this patch [2/3]
>> >> and next patch [3/3] potentially causes breakage with the existing
>> >> binding that was part of the v3.13 upstream kernel.
>> >
>> > If I'm not mistaken that's v3.14, not v3.13.
>>
>> Nope, it's merged in v3.13. Looked it up before sending the email. =)
>
> I might be missing something, but
>
> $ git log v3.13 --oneline -- drivers/clk/shmobile/ | wc
>       0       0       0
> $ git log v3.14-rc1 --oneline -- drivers/clk/shmobile/ | wc
>       6      48     309

It's the published bindings that count, right?

Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
was added in commit f94859c215b6d977794108a1a9a101239e393c09
("clk: shmobile: Add MSTP clock support").

$ git tag --contains f94859c215b6d977794108a1a9a101239e393c09
v3.14-rc1
v3.14-rc2
$

Now, the bindings must be in flux, as the documentation doesn't match
the code, nor the example:

Documentation says:

+  - renesas,indices: Indices of the gate clocks into the group (0 to 31)

Example and implementation use "renesas,clock-indices":

                renesas,clock-indices = <
                        R8A7790_CLK_TPU0 R8A7790_CLK_MMCIF1 R8A7790_CLK_SDHI3
                        R8A7790_CLK_SDHI2 R8A7790_CLK_SDHI1 R8A7790_CLK_SDHI0
                        R8A7790_CLK_MMCIF0
                >;

Woops...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

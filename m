From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2014 10:56:52 +0000
Subject: Re: [PATCH v7 0/2] clk: shmobile: DIV6 clock variable parent support
Message-Id: <CAMuHMdWkGtMq+gDZ+1YTmUh2E5xAUsCANcuG433=S3QOsPzjdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<CAMuHMdW=TGAySfRgXtVigcO-HuEudEDhnc2BhWuy8b0KJvE4oA@mail.gmail.com>
	<CANqRtoQS_868tnScxyLpSkCRiAewVvMfGLh60PqSC+b-mhKakw@mail.gmail.com>
In-Reply-To: <CANqRtoQS_868tnScxyLpSkCRiAewVvMfGLh60PqSC+b-mhKakw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Mike Turquette <mturquette@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

Hi Magnus,

On Tue, Nov 11, 2014 at 11:16 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Mon, Nov 10, 2014 at 6:16 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Fri, Nov 7, 2014 at 4:51 PM, Ulrich Hecht
>> <ulrich.hecht+renesas@gmail.com> wrote:
>>>  .../bindings/clock/renesas,cpg-div6-clocks.txt     |  18 ++--
>>>  drivers/clk/shmobile/clk-div6.c                    | 113 ++++++++++++++++++---
>>>  2 files changed, 113 insertions(+), 18 deletions(-)
>>
>> For the series:
>> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks, Geert!
>
> From my side this series "[PATCH v7 0/2] clk: shmobile: DIV6 clock
> variable parent support" looks quite finalized. Would it be possible

Does this mean I can add your acked-by?

Thanks!

> for you to pick this up into the renesas-driver git repo? It would
> also be great if you could lend a hand and make sure this series gets
> picked up by Mike.

Will do.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

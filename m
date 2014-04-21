From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Apr 2014 10:22:02 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CAMuHMdUodRGTrcXBHYJqnCAdSi+-cXFnL58zqYwMBSvip95d2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Apr 21, 2014 at 11:50 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 21 April 2014 10:31:14 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> A simple serial port integration prototype that happens to
>> target Koelsch. Written to propose how to move one step closer
>> to integrate DT support for serial ports on mach-shmobile.
>
> I think you've over-engineering it. I would just switch serial devices to DT
> in one go, like we do for all other devices.

Having the backwards-compatibility mode for DTSes without the main
serial console is nice, though. But I agree that we shouldn't introduce
more steps than necessary.

FWIW, I've been using your "ARM: shmobile: koelsch: Enable SCIF0 and SCIF1
serial ports in DT" on and off.

Last time I tried together with "of: Enable console on serial ports specified
by /chosen/stdout-path", which allows to boot without any "console="
parameters at all.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 05 Nov 2014 21:06:38 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <CAMuHMdX_JCducYDzZWd-TN-a6yJnApjeHvaUJYUexMd9yRN1nw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Nov 5, 2014 at 4:43 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > As Laurent has pointed out before, the LAN controller is not
>> > (directly) hooked up to this clock, but to an external oscillator.
>> > Nonetheless Ethernet won't work unless ZB is on, which I have
>> > determined by trial and error. Maybe that should have been pointed out
>> > in the description...
>>
>> I don't have the schematics for kzm9g, but I guess the LAN controller
>> is hooked up to the BSC (Bus State Controller).
>
> Yes it is. We should probably model the BSC in DT, and add the LAN controller
> as a child of the BSC node. With automatic clock management in runtime PM,
> could we do without a BSC driver entirely ?

I'm afraid we're gonna need a bus driver to handle that correctly.
Especially when considering the BSC is in a PM domain (A4S).

Fortunately A4S is always powered when the CPU is talking to Ethernet,
as A4S contains the CPU cores, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

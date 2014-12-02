From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 22:58:11 +0000
Subject: Re: [PATCH 5/5] ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]
Message-Id: <CAMuHMdUM1f2oUtmKis0cksNK0RQmH66qLSO677_XW7E7sCfHaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417538146-23350-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417538146-23350-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Dec 2, 2014 at 10:34 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 02 December 2014 22:11:52 Geert Uytterhoeven wrote:
>> On Tue, Dec 2, 2014 at 10:06 PM, Laurent Pinchart wrote:
>> >> >         aliases {
>> >> >
>> >> > -               serial6 = &scif0;
>> >> > -               serial7 = &scif1;
>> >> > +               serial0 = &scif0;
>> >> > +               serial1 = &scif1;
>> >>
>> >> Actually the labels on my Koelsch read "debug0" and "debug1".
>> >> Do we care?
>> >
>> > I thought serial port aliases were required to be named "serial" ?
>>
>> ePAPR v1.1 only mentions up to 31 characters out of [a-z0-9-].
>> Nothing about rgeneric names like with node names.
>
> The sh-sci driver calls of_alias_get_id(np, "serial") to retrieve the port
> number. The alias must then start by "serial" unless I'm missing something.

OK, then we're stuck with "serial%u" (some drivers use "uart%u" or even
"ttyAS%u"!).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

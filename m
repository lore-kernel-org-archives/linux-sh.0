From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Jun 2014 14:21:22 +0000
Subject: Re: [PATCH v2] ARM: shmobile: koelsch: Add support HSCIF1
Message-Id: <CAMuHMdUaO2pANQJCVceEkoJb9QuS7=BO-x3V5eSoBOEeCuOAUg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <9058795.dyXpcFtuGJ@avalon>
 <CAMuHMdUd=E=TcSTPwy0xbpAcZH+voiEkjND=qzdSzG_zKdPe9g@mail.gmail.com>
 <1751840.oCdYe48VRu@avalon>
In-Reply-To: <1751840.oCdYe48VRu@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Fri, Jun 13, 2014 at 3:24 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> About your comment about the resistors and capacitors, which applies to
>> both HSCIF0 and HSCIF1: probably the serial port will still work if
>> these are present.
>
> With a 4.7µF capacitive load on the transmission line, assuming a drive
> strength of 40mA (which is pretty high), switching between 0V and 3.3V takes
> 388µs, corresponding to 2579 Hz. You'll have to reduce the baud rate :-)

Right, 4.7µF is a bit high. So at least the capacitor has to go for today's
typical serial speeds.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

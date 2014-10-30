From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Oct 2014 18:03:37 +0000
Subject: Re: [PATCH v3 7/7] ARM: shmobile: kzm9g-reference: require ZB clock for Ethernet controller
Message-Id: <CAMuHMdXLbW6H3erVgpddf7wtUDHRNEgOY_3rFokn6xE80-=HBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414515736-24905-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Oct 30, 2014 at 6:41 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> On Wed, Oct 29, 2014 at 1:21 AM, Simon Horman <horms@verge.net.au> wrote:
>> On Tue, Oct 28, 2014 at 06:02:16PM +0100, Ulrich Hecht wrote:
>>> Unlike the legacy stuff, CCF disables the ethernet controller's clock
>>> unless it is used somewhere.
>>
>> This feels like it should come earlier in the series to avoid
>> breaking then fixing ethernet support for kzm9g-reference.
>
> The CCF support, not being used yet, doesn't actually break anything.
> The reason this patch is separated from the rest is that it works, but
> it's not completely clear (to me) how.
>
> As Laurent has pointed out before, the LAN controller is not
> (directly) hooked up to this clock, but to an external oscillator.
> Nonetheless Ethernet won't work unless ZB is on, which I have
> determined by trial and error. Maybe that should have been pointed out
> in the description...

I don't have the schematics for kzm9g, but I guess the LAN controller
is hooked up to the BSC (Bus State Controller). According to the sh73a0
datasheet, ZB=C3=B8 is the clock for the BSC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

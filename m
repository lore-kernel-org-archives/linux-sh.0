From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Mar 2014 12:07:52 +0000
Subject: Re: [PATCH RFC] ARM: shmobile: r8a7791 legacy: Disable RMSTP clocks
Message-Id: <CAMuHMdVrAR+5+gyqEyJGRfmUp=+Tuyj7=y4G5-ZysaRjJgdp=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394135648-10193-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Mon, Mar 10, 2014 at 12:45 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> Currently I'm most worried by bugs slipping in in our drivers' clock
>> handling due to the clock still being enabled on the SH-4A side.
>
> I can share that concern. One possible solution would be a debug option to
> force disabling of all RMSTPCRs from the Linux side. It's a bit hackish
> though. Another one would be to fix the boot loader for our development
> boards, but I don't know where the sources are located, and whether we co=
uld
> push the modification "upstream" internally.

My koelsch has U-Boot b6af5fc, which presumably can be found at
http://git.denx.de/?p=3Du-boot/u-boot-sh.git;a=3Dcommit;h=B6af5fc

Haven't tried building and FLASHing my own, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

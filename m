From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 Dec 2015 08:22:57 +0000
Subject: Re: [PATCH/RFC 00/03] ARM: shmobile: r8a7795 Salvator-X IPMMU test code
Message-Id: <CAMuHMdU9-gu2jDQSnpk6hbSFpDD5nSTw2xC2KaeizFSaZP0fCA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215132634.15356.29848.sendpatchset@little-apple>
In-Reply-To: <20151215132634.15356.29848.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Tue, Dec 15, 2015 at 2:26 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: r8a7795 Salvator-X IPMMU test code
>
> [PATCH/RFC 01/03] ARM: shmobile: External Salvator-X SCIF3/HSCIF3 loop
> [PATCH/RFC 02/03] ARM: shmobile: r8a7795: Hack up SYS-DMAC0 support
> [PATCH/RFC 03/03] ARM: shmobile: r8a7795: Tie in IPMMU with SYS-DMAC0
>
> Hook up the external SCIF3/HSCIF3 loop back adapter via DT and tie
> in SYS-DMAC0 and the IPMMU units for test purpose.
>
> Not for upstream merge.

Have you considered using DT overlays for this?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

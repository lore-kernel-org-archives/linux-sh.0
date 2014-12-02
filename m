From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Dec 2014 17:42:02 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: ape6evm-reference: add ethernet controller to DT
Message-Id: <CAMuHMdVETVobsbYNdwXOp7AuH5FAoh=KP5e3mf_7vp3oHA-q+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <dbffb5a1525dc88f1c871c48574634f14845b43d.1380530263.git.horms+renesas@verge.net.au>
In-Reply-To: <dbffb5a1525dc88f1c871c48574634f14845b43d.1380530263.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Tue, Dec 2, 2014 at 9:37 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Describes the SMSC LAN9220 chip.  It is not currently enabled because a suitable
> mechanism for activating its clock (zb) is yet to be developed.

Have you tried the mechanism from "[PATCH RFC 0/3] Add "Simple" / Renesas Bus
State Controller Driver" (https://lkml.org/lkml/2014/11/24/661)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

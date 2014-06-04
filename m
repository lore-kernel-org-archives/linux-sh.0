From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 04 Jun 2014 11:54:45 +0000
Subject: shdma: DM_FIX and SM_FIX?
Message-Id: <CAMuHMdVrP2FJiuS2qZsFFsGdB1pNBqobakLLdPR68wtznizOiA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It seems the current values for the Destination/Source Address Mode (SM/DM)
fields in the SHDMA DMA Channel Control Register:

#define DM_FIX   0x0000c000
#define SM_FIX   0x00003000

are not correct for all parts, according to the documentation.

While on sh7724, A1 (r8a7740), AG5 (sh73a0/r8a73a0), and APE6 (r8a73a4)
both the '00' and '11' bit combinations indicate a fixed destination or source
address, '11' is marked as "Setting Prohibited" on sh7750, sh7753, sh7760,
and R-Car Gen2.

I don't know about other parts.
RZ/A1H and R-Car Gen1 use different DMA controller blocks.

At least with QSPI on R-Car M2, '11' does seem to work, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

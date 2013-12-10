From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 10 Dec 2013 13:19:13 +0000
Subject: Re: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <CAMuHMdXdvF+N0+b0Mo3DO4Vj3NCymh-ySU_SMRATFUekSfnaRg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312100220.42153.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312100220.42153.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sergei,

On Tue, Dec 10, 2013 at 12:20 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Renesas R-Car development boards use KSZ8041RNLI PHY which for some reason has
> ID of 0x00221537 that is not documented for KSZ8041-family PHYs and does not
> match the  documented ID of  0x0022151x (where 'x' is the revision).  We have
> to add the new #define PHY_ID_* and new ksphy_driver[] entry, almost the same
> as KSZ8041 one, differing only in the 'phy_id' and 'name' fields.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

I don't seem to get "net eth0: Receive FIFO Overflow" anymore after applying
this patch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

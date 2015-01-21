From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Jan 2015 10:40:30 +0000
Subject: Re: [PATCH 11/13] Documentation: Remove ZBOOT MMC/SDHI utility and docs
Message-Id: <CAMuHMdVy=28VAbiH3763UzA4qJ7qUOAJzFT7fv6GQfXq5-kLuQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150121045256.7648.7451.sendpatchset@little-apple>
 <20150121045447.7648.23274.sendpatchset@little-apple>
In-Reply-To: <20150121045447.7648.23274.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Magnus,

On Wed, Jan 21, 2015 at 5:54 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0001/Documentation/arm/Makefile
> +++ work/Documentation/arm/Makefile     2015-01-21 11:27:40.337571523 +0900
> @@ -1 +1 @@
> -subdir-y := SH-Mobile
> +

.git/rebase-apply/patch:14: new blank line at EOF.

This file can just be removed, if you remove the "arm" from
Documentation/Makefile?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

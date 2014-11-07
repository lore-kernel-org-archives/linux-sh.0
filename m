From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Nov 2014 14:20:04 +0000
Subject: Re: [PATCH v4 0/6] sh73a0 common clock framework implementation
Message-Id: <CAMuHMdV8=gmEZFRWG+asusgCqCy+pPwxiYVHUmQAhA=o-TAbpA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415292641-30331-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich

With this series applied (also with the previous version), kzm9g-multiplatform
(with sh73a0-kzm9g-reference.dtb) locks up after initializing ttySC4, i.e.
after printing

    sh-sci e6c80000.serial: ttySC4 at MMIO 0xe6c80000 (irq = 110,
base_baud = 0) is a scifa

If I comment out the "clocks" property of scifa4 in the dtsi, it continues
(without any serial output, of course).

Do you have any clue?

I'm also using the scif early debug patch, else I don't see any serial output
at all.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

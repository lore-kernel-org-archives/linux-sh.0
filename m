From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Jun 2012 12:47:34 +0000
Subject: Re: [GIT PULL] sh fixes for 3.5-rc3
Message-Id: <CAMuHMdVLEUBz8=L_=3MdzvAzr8jtyu_o2f3AaAiSNHS0KX11Cg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120613075737.GA27673@linux-sh.org>
In-Reply-To: <20120613075737.GA27673@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Paul,

On Wed, Jun 13, 2012 at 9:57 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> Paul Mundt (13):
>      sh: convert to kbuild asm-generic support.

>  arch/sh/include/asm/kvm_para.h          |    1 -

I guess this breaks "make ARCH=sh headers_check"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

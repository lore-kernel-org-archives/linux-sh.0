From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 25 Jun 2015 06:24:17 +0000
Subject: Re: [musl] SH sigcontext ABI is broken
Message-Id: <CAMuHMdU3dM=UEUfgmEao=xJh=qocVfKZmxgbesWieb223B=o9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150619070912.GA15025@brightrain.aerifal.cx>
In-Reply-To: <20150619070912.GA15025@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 11:34 PM, Rich Felker <dalias@libc.org> wrote:
>> I want musl to support sh2 but I _also_ want it to support coldfire and
>> h8300 and so on. If musl is the successor to uclibc (which needs to be
>> put out of its misery), it needs nommu support for several different
>> architectures. If you insist that every nommu architecture must also run
>> those nommu binaries on with-mmu sibling architectures, you're going to
>> be unifying coldfire and m68k next...
>
> If you look at the kernel I'm pretty sure that already works...
> Coldfire does not seem to be a separate arch/ABI as far as the kernel
> is concerned.

Off-topic, but:
1. While the Coldfire user mode instruction set is (more or less?) a subset
   of the classic m68k user mode instruction set, there are larger differences
   in the supervisor mode instruction sets.
2. Coldfire uses a different MMU than classic m68k.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

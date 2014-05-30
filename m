From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 May 2014 10:10:08 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791 SYSC setup code
Message-Id: <CAMuHMdWTLsXv65m7HY4rgS6OF5tySn=efBy0RPLJJrYztNdzkQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386DD74.3000202@renesas.com>
In-Reply-To: <5386DD74.3000202@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Thu, May 29, 2014 at 9:15 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> +#include <linux/kernel.h>
>> +#include <asm/io.h>
>> +#include <mach/pm-rcar.h>
>> +#include <mach/r8a7791.h>
>
> alphabetical order if possible

To me the order looks OK:
  - Linux-specific first (in alphabetical order),
  - ARM-specific second (in alphabetical order),
  - Machine-specific third (in alphabetical order),

I would separate the sections by a blank line, though, but for sections
with a single item that's not really needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

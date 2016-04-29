From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 29 Apr 2016 06:48:35 +0000
Subject: Re: [PATCH 1/7] sh: add support for J-Core J2 processor
Message-Id: <CAMuHMdV8u9G5kG5fJV3thxYdrbpwLOASB2FrzDn6AnEH_S0UXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <b8864269082ee9e5dcc079865340de70711b3272.1461880061.git.dalias@libc.org>
In-Reply-To: <b8864269082ee9e5dcc079865340de70711b3272.1461880061.git.dalias@libc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 18, 2016 at 12:09 AM, Rich Felker <dalias@libc.org> wrote:
> --- /dev/null
> +++ b/arch/sh/mm/cache-j2.c
> @@ -0,0 +1,58 @@
> +/*
> + * arch/sh/mm/cache-j2.c
> + *
> + * Copyright (C) 2015 SEI

"Smart Energy Instruments, Inc.", like in some other files?

Too many entities are called "SEI"...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

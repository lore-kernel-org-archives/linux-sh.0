From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 May 2014 18:50:50 +0000
Subject: Re: sh: Replace __get_cpu_var uses
Message-Id: <CAMuHMdXopP-6NLJvkk=9aN9FieBSv3LOAgp4oB+FQA60ZjjR0w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1405051144420.28592@gentwo.org>
In-Reply-To: <alpine.DEB.2.10.1405051144420.28592@gentwo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Christoph,

On Mon, May 5, 2014 at 6:45 PM, Christoph Lameter <cl@linux.com> wrote:
> Could you see if this compiles and works?

shx3_defconfig (one of the SMP defconfigs) still compiles fine.

> No sh build environment here.

https://www.kernel.org/pub/tools/crosstool/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

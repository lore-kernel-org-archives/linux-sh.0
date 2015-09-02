From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Sep 2015 12:30:48 +0000
Subject: Re: topic/gen3-latest
Message-Id: <CAMuHMdVBxJ4X=UhiKfmRMp7t36o6oe1tboDbCH51zf3-qhK6qw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXLKW4FkwbrhKoToV9BdHruK4VmvnMzofCEUSnuxk-_nQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXLKW4FkwbrhKoToV9BdHruK4VmvnMzofCEUSnuxk-_nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 2, 2015 at 11:32 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> I've updated topic/gen3-latest in
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git with:
>   - topic/gen3-cpg-v6
>   - topic/r8a7795-pfc-v2
>   - topic/gen3-modemr-syscon-v1

The above works fine, as CONFIG_PINCTRL is not yet selected by ARCH_RENESAS.

As soon as CONFIG_PINCTRL=y, the system seems to boot fine, but serial input
on the console does not work.

Disabling CONFIG_PINCTRL _or_ reverting from topic/r8a7795-pfc-v2 to
topic/r8a7795-pfc-v1 fixes the issue.

Looking into it...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

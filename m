From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Aug 2015 07:34:32 +0000
Subject: Re: SH2 kernel fails to build with recent GCC
Message-Id: <CAMuHMdUzE=7ASYVzi=-u9TMMzCnvjyWgYovsFPuRY5jB1ZA3aQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150812015616.GA19843@brightrain.aerifal.cx>
In-Reply-To: <20150812015616.GA19843@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rich,

On Wed, Aug 12, 2015 at 3:56 AM, Rich Felker <dalias@libc.org> wrote:
> The commit that resolved GCC issue #54089 broke building the kernel
> for SH2, by causing GCC to generate calls to new libgcc functions
> which the kernel's fake libgcc does not provide. See the GCC issue
> tracker for details:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?idT089
>
> The relevant commit is linked from comment 16; comments 33-43 (and
> perhaps beyond) discuss the issue in detail and possible fixes.
>
> Before I work on a fix, would dropping the kernel's copy of libgcc
> functions for SH and using the real libgcc (like some archs do; see
> comment 43) be acceptable, or do we need to get updated
> libgcc[-compatible] code into the kernel?

Which libgcc functions are missing? I couldn't find that list in the bug
report...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

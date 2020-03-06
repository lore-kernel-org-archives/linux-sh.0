From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 06 Mar 2020 08:04:40 +0000
Subject: Re: [PATCH] sh: Stop printing the virtual memory layout
Message-Id: <CAMuHMdVG+ueSeMw1BEKSv15zun4eOB1ZzdGidH8quy2zMp7tdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <202003021038.8F0369D907@keescook> <20200305151010.835954-1-nivedita@alum.mit.edu>
 <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
In-Reply-To: <f672417e-1323-4ef2-58a1-1158c482d569@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <keescook@chromium.org>, "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>, kernel-hardening@lists.openwall.com, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Thu, Mar 5, 2020 at 4:18 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 3/5/20 4:10 PM, Arvind Sankar wrote:
> > For security, don't display the kernel's virtual memory layout.
> >
> > Kees Cook points out:
> > "These have been entirely removed on other architectures, so let's
> > just do the same for ia32 and remove it unconditionally."
> >
> > 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> > 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> > 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> > fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> > adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> Aww, why wasn't this made configurable? I found these memory map printouts
> very useful for development.

In most of the above (but not in this patch), "%p" was used to print
addresses, which started showing useless hashed addresses since commit
ad67b74d2469d9b8 ("printk: hash addresses printed with %p").

Instead of changing them all to print usable addresses instead, it was
agreed upon to just remove them.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

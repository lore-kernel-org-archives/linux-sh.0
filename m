From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 03 Dec 2019 09:06:37 +0000
Subject: Re: Build failure on latest powerpc/merge (311ae9e159d8 io_uring: fix dead-hung for non-iter fixed r
Message-Id: <CAMuHMdUzqnPpbSXB1JaY-+BbAvKno3akSYi6c8ZLQfLuOCC7rg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <71cf82d5-5986-43b7-cf1c-acba429a89d6@c-s.fr>
 <3a95d445-1f5c-7750-f0de-ddc427800b3b@kernel.dk>
In-Reply-To: <3a95d445-1f5c-7750-f0de-ddc427800b3b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Jens Axboe <axboe@kernel.dk>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Pavel Begunkov <asml.silence@gmail.com>

Hi Jens,

On Fri, Nov 29, 2019 at 5:06 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 11/29/19 6:53 AM, Christophe Leroy wrote:
> >     CC      fs/io_uring.o
> > fs/io_uring.c: In function ‘loop_rw_iter’:
> > fs/io_uring.c:1628:21: error: implicit declaration of function ‘kmap’
> > [-Werror=implicit-function-declaration]
> >       iovec.iov_base = kmap(iter->bvec->bv_page)
> >                        ^
> > fs/io_uring.c:1628:19: warning: assignment makes pointer from integer
> > without a cast [-Wint-conversion]
> >       iovec.iov_base = kmap(iter->bvec->bv_page)
> >                      ^
> > fs/io_uring.c:1643:4: error: implicit declaration of function ‘kunmap’
> > [-Werror=implicit-function-declaration]
> >       kunmap(iter->bvec->bv_page);
> >       ^
> >
> >
> > Reverting commit 311ae9e159d8 ("io_uring: fix dead-hung for non-iter
> > fixed rw") clears the failure.
> >
> > Most likely an #include is missing.
>
> Huh weird how the build bots didn't catch that. Does the below work?

Thanks, this fixes the same issue on SuperH:

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -69,6 +69,7 @@
>   #include <linux/nospec.h>
>   #include <linux/sizes.h>
>   #include <linux/hugetlb.h>
> +#include <linux/highmem.h>
>
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/io_uring.h>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

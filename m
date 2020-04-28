From: Jann Horn <jannh@google.com>
Date: Tue, 28 Apr 2020 06:10:51 +0000
Subject: Re: [PATCH 5/5] mm/gup: Take mmap_sem in get_dump_page()
Message-Id: <CAG48ez3kLgXQBOnSJJ+XuYpM__XnKc_AqJMoiPBhFbTdmoWxag@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
 <20200428032745.133556-6-jannh@google.com>
 <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Tue, Apr 28, 2020 at 5:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
> >
> > Properly take the mmap_sem before calling into the GUP code from
> > get_dump_page(); and play nice, allowing __get_user_pages_locked() to drop
> > the mmap_sem if it has to sleep.
>
> This makes my skin crawl.
>
> The only reason for this all is that page cache flushing.
>
> My gut feeling is that it should be done by get_user_pages() anyway,
> since all the other users presumably want it to be coherent in the
> cache.
>
> And in fact, looking at __get_user_pages(), it already does that
>
>                 if (pages) {
>                         pages[i] = page;
>                         flush_anon_page(vma, page, start);
>                         flush_dcache_page(page);
>                         ctx.page_mask = 0;
>                 }
>
> and I think that the get_dump_page() logic is unnecessary to begin with.

Ah! And even though flush_cache_page() is broader than
flush_dcache_page(), that's actually unnecessary, right? Since the
kernel only wants to read from the page, and therefore e.g. the icache
is irrelevant?

Yay! :) I did think this was a bit gnarly, and it's nice to know that
this can be simplified.

(And now I'm going to avert my eyes from the GUP code before I start
thinking too hard about how much it sucks that FOLL_LONGTERM doesn't
drop the mmap_sem across the access and how much I dislike the whole
idea of FOLL_LONGTERM in general...)

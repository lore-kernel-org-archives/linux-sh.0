From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Apr 2020 03:50:40 +0000
Subject: Re: [PATCH 5/5] mm/gup: Take mmap_sem in get_dump_page()
Message-Id: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
 <20200428032745.133556-6-jannh@google.com>
In-Reply-To: <20200428032745.133556-6-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>
> Properly take the mmap_sem before calling into the GUP code from
> get_dump_page(); and play nice, allowing __get_user_pages_locked() to drop
> the mmap_sem if it has to sleep.

This makes my skin crawl.

The only reason for this all is that page cache flushing.

My gut feeling is that it should be done by get_user_pages() anyway,
since all the other users presumably want it to be coherent in the
cache.

And in fact, looking at __get_user_pages(), it already does that

                if (pages) {
                        pages[i] = page;
                        flush_anon_page(vma, page, start);
                        flush_dcache_page(page);
                        ctx.page_mask = 0;
                }

and I think that the get_dump_page() logic is unnecessary to begin with.

               Linus

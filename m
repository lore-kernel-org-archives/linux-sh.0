From: Jann Horn <jannh@google.com>
Date: Tue, 05 May 2020 11:42:12 +0000
Subject: Re: [PATCH v2 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
Message-Id: <CAG48ez3F70-UXwdHmO4CnR0bAForn-SBtstW5WAYjcrLFwS_9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429214954.44866-2-jannh@google.com>
 <20200505104805.GA17400@lst.de>
In-Reply-To: <20200505104805.GA17400@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Tue, May 5, 2020 at 12:48 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 29, 2020 at 11:49:50PM +0200, Jann Horn wrote:
> > dump_emit() is for kernel pointers, and VMAs describe userspace memory.
> > Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
> > even if it probably doesn't matter much on !MMU systems - especially given
> > that it looks like we can just use the same get_dump_page() as on MMU if
> > we move it out of the CONFIG_MMU block.
>
> Looks sensible.  Did you get a chance to test this with a nommu setup?

Nope. Do you happen to have a recommendation for a convenient
environment I can use with QEMU, or something like that? I'm guessing
that just running a standard armel Debian userspace with a !mmu ARM
kernel wouldn't work so well?

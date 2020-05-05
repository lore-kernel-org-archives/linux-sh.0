From: Jann Horn <jannh@google.com>
Date: Tue, 05 May 2020 11:44:34 +0000
Subject: Re: [PATCH v2 3/5] coredump: Refactor page range dumping into common helper
Message-Id: <CAG48ez26DT2v7QQEbbur8LL+tQskrTBLCW+eW__RTOpezte6rw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429214954.44866-4-jannh@google.com>
 <20200505105023.GB17400@lst.de>
In-Reply-To: <20200505105023.GB17400@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Tue, May 5, 2020 at 12:50 PM Christoph Hellwig <hch@lst.de> wrote:
> On Wed, Apr 29, 2020 at 11:49:52PM +0200, Jann Horn wrote:
> > Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
> > into the coredump file. Extract that logic into a common helper.
> >
> > Any other binfmt that actually wants to create coredumps will probably need
> > the same function; so stop making get_dump_page() depend on
> > CONFIG_ELF_CORE.
>
> Why is the #ifdef CONFIG_ELF_CORE in gup.c removed when the only
> remaining caller is under the same ifdef?

Oh, whoops, good point - I should go put that back.

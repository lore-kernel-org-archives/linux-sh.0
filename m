From: Christoph Hellwig <hch@lst.de>
Date: Tue, 05 May 2020 10:48:05 +0000
Subject: Re: [PATCH v2 1/5] binfmt_elf_fdpic: Stop using dump_emit() on user pointers on !MMU
Message-Id: <20200505104805.GA17400@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429214954.44866-2-jannh@google.com>
In-Reply-To: <20200429214954.44866-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, "Eric W . Biederman" <ebiederm@xmission.com>

On Wed, Apr 29, 2020 at 11:49:50PM +0200, Jann Horn wrote:
> dump_emit() is for kernel pointers, and VMAs describe userspace memory.
> Let's be tidy here and avoid accessing userspace pointers under KERNEL_DS,
> even if it probably doesn't matter much on !MMU systems - especially given
> that it looks like we can just use the same get_dump_page() as on MMU if
> we move it out of the CONFIG_MMU block.

Looks sensible.  Did you get a chance to test this with a nommu setup?

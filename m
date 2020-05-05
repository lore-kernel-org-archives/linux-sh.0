From: Christoph Hellwig <hch@lst.de>
Date: Tue, 05 May 2020 10:50:23 +0000
Subject: Re: [PATCH v2 3/5] coredump: Refactor page range dumping into common helper
Message-Id: <20200505105023.GB17400@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429214954.44866-4-jannh@google.com>
In-Reply-To: <20200429214954.44866-4-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jann Horn <jannh@google.com>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, "Eric W . Biederman" <ebiederm@xmission.com>

On Wed, Apr 29, 2020 at 11:49:52PM +0200, Jann Horn wrote:
> Both fs/binfmt_elf.c and fs/binfmt_elf_fdpic.c need to dump ranges of pages
> into the coredump file. Extract that logic into a common helper.
> 
> Any other binfmt that actually wants to create coredumps will probably need
> the same function; so stop making get_dump_page() depend on
> CONFIG_ELF_CORE.

Why is the #ifdef CONFIG_ELF_CORE in gup.c removed when the only
remaining caller is under the same ifdef?

Otherwise this looks fine to me.

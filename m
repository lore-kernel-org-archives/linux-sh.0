From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Apr 2020 16:40:21 +0000
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
Message-Id: <CAHk-=wg2uw09tJMKTooQBr=AJPzzLTaq95b+SSS513Gm0gy5sw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
 <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
 <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
In-Reply-To: <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jann Horn <jannh@google.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Tue, Apr 28, 2020 at 9:34 AM Rob Landley <rob@landley.net> wrote:
>
> Writes to a local filesystem should never be short unless disk full/error.

Well, that code is definitely supposed to also write to pipes.

But it also has "was I interrupted" logic, which stops the core dump.

So short writes can very much happen, it's just that they also imply
that the core dump should be aborted.

So the loop seems to be unnecessary. The situations where short writes
can happen are all the same situations where we want to abort anyway,
so the loop count should probably always be just one.

The same would go for any potential network filesystem with the
traditional NFS intr-like behavior.

            Linus

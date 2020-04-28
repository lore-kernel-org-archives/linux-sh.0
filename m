From: Jann Horn <jannh@google.com>
Date: Tue, 28 Apr 2020 05:52:20 +0000
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
Message-Id: <CAG48ez0Nz8Bnty2aKdsUeMoXkjc_Bcxr+EcStZ7LBTOgRt1mrQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
 <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
In-Reply-To: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, "Eric W . Biederman" <ebiederm@xmission.com>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On Tue, Apr 28, 2020 at 5:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
> >
> > After a partial write, we have to update the input buffer pointer.
>
> Interesting. It seems this partial write case never triggers (except
> for actually killing the core-dump).
>
> Or did you find a case where it actually matters?
>
> Your fix is obviously correct, but it also makes me go "that function
> clearly never actually worked for partial writes, maybe we shouldn't
> even bother?"

Hmm, yeah... I can't really think of cases where write handlers can
spuriously return early without having a pending signal, and a second
write is likely to succeed... I just know that there are some things
that are notorious for returning short *reads* (e.g. pipes, sockets,
/proc/$pid/maps).

Al's commit message refers to pipes specifically; but even at commit
2507a4fbd48a, I don't actually see where pipe_write() could return a
short write without a page allocation failure or something like that.

So maybe you're right and we should just get rid of it...

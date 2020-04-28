From: Rob Landley <rob@landley.net>
Date: Tue, 28 Apr 2020 16:40:47 +0000
Subject: Re: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
Message-Id: <94141fbb-9559-1851-54c1-cdc5fc529a1a@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
 <20200428032745.133556-3-jannh@google.com>
 <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
In-Reply-To: <CAHk-=wjSYTpTH0X8EcGGJD84tsJS62BN3tC6NfzmjvXdSkFVxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On 4/27/20 10:35 PM, Linus Torvalds wrote:
> On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>>
>> After a partial write, we have to update the input buffer pointer.
> 
> Interesting. It seems this partial write case never triggers (except
> for actually killing the core-dump).
> 
> Or did you find a case where it actually matters?
> 
> Your fix is obviously correct, but it also makes me go "that function
> clearly never actually worked for partial writes, maybe we shouldn't
> even bother?"

Writes to a local filesystem should never be short unless disk full/error.

Once upon a time this was yet another thing that NFS could break that no other
filesystem would break, but I dunno about now? (I think the page cache collates
it and defers the flush until the error can't be reported back anyway?)

Rob

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Apr 2020 16:54:28 +0000
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
Message-Id: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
 <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
In-Reply-To: <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Mark Salter <msalter@redhat.com>, Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Nicolas Pitre <nico@fluxnic.net>, Linux-sh list <linux-sh@vger.kernel.org>, Jann Horn <jannh@google.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Linux-MM <linux-mm@kvack.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Christoph Hellwig <hch@lst.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Eric W . Biederman" <ebiederm@xmission.com>

On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> > in load_flat_file() - which is also used to loading _libraries_. Where
> > it makes no sense at all.
>
> I haven't looked at the shared lib support in there for a long time,
> but I thought that "id" is only 0 for the actual final program.
> Libraries have a slot or id number associated with them.

Yes, that was my assumption, but looking at the code, it really isn't
obvious that that is the case at all.

'id' gets calculated from fields that very much look like they could
be zero (eg by taking the top bits from another random field).

> > Most of that file goes back to pre-git days. And most of the commits
> > since are not so much about binfmt_flat, as they are about cleanups or
> > changes elsewhere where binfmt_flat was just a victim.
>
> I'll have a look at this.

Thanks.

> Quick hack test shows moving setup_new_exec(bprm) to be just before
> install_exec_creds(bprm) works fine for the static binaries case.
> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
> dig into that to see why.

Just moving setup_new_exec() would at least allow us to then join the
two together, and just say "setup_new_exec() does the credential
installation too".

So to some degree, that's the important one.

But that flush_old_exec() does look odd in load_flat_file(). It's not
like anything but executing a binary should flush the old exec.
Certainly not loading a library, however odd that flat library code
is.

My _guess_ is that the reason for this is that "load_flat_file()" also
does a lot of verification of the file and does that whole "return
-ENOEXEC if the file format isn't right". So we don't want to flush
the old exec before that is done, but we obviously also don't want to
flush the old exec after we've actually loaded the new one into
memory..

So the location of flush_old_exec() makes that kind of sense, but it
would have made it better if that flat file support had a clear
separation of "check the file" from "load the file".

Oh well. As mentioned, the whole "at least put setup_new_exec() and
install_exec_creds() together" is the bigger thing.

But if it's true that nobody really uses the odd flat library support
any more and there are no testers, maybe we should consider ripping it
out...

                Linus

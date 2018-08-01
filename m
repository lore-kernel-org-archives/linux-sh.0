From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 01 Aug 2018 22:06:33 +0000
Subject: Re: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
Message-Id: <CAKwvOdmHadWqZSLT2DM4D9Kt-EwVHrjuiKy6vYJpVw7Dk=bTKQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
 <20180801185331.39535-1-ndesaulniers@google.com> <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
In-Reply-To: <20180801145530.185dab6b47a61842923fc02d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Wed, Aug 1, 2018 at 2:55 PM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Wed,  1 Aug 2018 11:53:31 -0700 Nick Desaulniers <ndesaulniers@google.=
com> wrote:
>
> > As part of the effort to reduce the code duplication between _THIS_IP_
> > and current_text_addr(), let's consolidate callers of
> > current_text_addr() to use _THIS_IP_.
>
> Why not switch everything to current_text_addr()?  _THIS_IP_ is ugly ;)
>
> Several architectures (s390, sparc, sh, ...) do funky things in their
> current_text_addr().  Does the generic kernel.h implementation of
> current_text_addr() work OK on those architectures?

Good question, one I've been mulling over for a few days.  That's
definitely something that I've considered.  Mostly, it comes down to
there being fewer call sites of current_text_addr() than _THIS_IP_, so
it's IMO a smaller change that doesn't require coordinating tree-wide
changes.

What's interesting about current_text_addr() is that while there are
many arch specific definitions, there are only 5 call sites in the
whole kernel (and 4 of them are arch specific).  So unless there's an
arch specific reason to prefer inline assembly over higher level C
(yes, returning the address of a label in a statement expression is
ugly), (it looks like parisc might have a reason, at its lone call
site, see: https://lkml.org/lkml/2018/8/1/1678, TBD), then I don't
think that current_text_addr() has a raison d'=C3=AAtre.  I suspect that
its use predates the GNU C extensions needed for the current generic C
implementation (statement expressions + addr of label) and has just
been reimplemented in every new arch's arch/*/include/asm/processor.h
simply because the other archs had it.

So the plan is to replace the 5 call sites of current_text_addr() with
_THIS_IP_ (if possible), then delete all definitions of the arch
specific current_text_addr()'s.  This can be done on a per tree basis,
rather than a treewide patch for converting _THIS_IP_ (who has many
more call sites) to current_text_addr().  What do you think?

--=20
Thanks,
~Nick Desaulniers

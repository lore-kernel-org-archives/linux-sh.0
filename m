From: Rich Felker <dalias@libc.org>
Date: Tue, 02 Jun 2020 20:28:33 +0000
Subject: Re: linux-sh for-next reactivation
Message-Id: <20200602202832.GA3776@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200602031123.GA1079@brightrain.aerifal.cx>
 <20200602150039.780a0ac0@canb.auug.org.au>
In-Reply-To: <20200602150039.780a0ac0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Tue, Jun 02, 2020 at 03:00:39PM +1000, Stephen Rothwell wrote:
> Hi Rich,
> 
> On Mon, 1 Jun 2020 23:11:39 -0400 Rich Felker <dalias@libc.org> wrote:
> >
> > Could you reactivate linux-next pull from my arch/sh for-next branch?
> > It's where it was before, at:
> > 
> >     git://git.libc.org/linux-sh for-next
> > 
> > and has newly accepted patches ready.
> 
> I already have an SH tree from
> git://git.sourceforge.jp/gitroot/uclinux-h8/linux.git#sh-next .  Should
> I do anything with that one?
> 
> It currently contains:
> 
> $ git log --oneline origin/master..sh/sh-next 
> a193018e5290 (sh/sh-next) sh: add missing EXPORT_SYMBOL() for __delay
> 1d5fd6c33b04 sh: add missing DECLARE_EXPORT() for __ashiftrt_r4_xx
> d70f1e3d5dbd Merge remote-tracking branch 'origin/master' into sh-next
> baf58858e8b6 sh: prefer __section from compiler_attributes.h
> 8619b5a9035a sh: Drop -Werror from kernel Makefile
> 3a3a78124693 sh: kernel: disassemble: Mark expected switch fall-throughs
> fb8f77490f55 sh: kernel: hw_breakpoint: Fix missing break in switch statement
> cd10afbc932d sh: remove unneeded uapi asm-generic wrappers
> cbfc6edb6a4a sh: use __builtin_constant_p() directly instead of IS_IMMEDIATE()

Hi Stephen,

I completely forgot that you had the tree from our other co-maintainer
Yoshinori Sato on the list linux-next is pulling from. Would it be
okay to keep both? That would help with quickly identifying and
resolving any conflicting commits and make things go more smoothly
with two maintainers trying to be active.

Let me know if this doesn't work for you and we'll figure out
alternative arrangements.

Rich

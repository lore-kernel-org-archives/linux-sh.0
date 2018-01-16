From: Petr Mladek <pmladek@suse.com>
Date: Tue, 16 Jan 2018 16:33:01 +0000
Subject: Re: [PATCH 00/13] replace print_symbol() with printk()-s
Message-Id: <20180116163301.lh76kvjheyobjgkp@pathway.suse.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
In-Reply-To: <20171211125025.2270-1-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Mark Salter <msalter@redhat.com>, Tony Luck <tony.luck@intel.com>, David Howells <dhowells@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Borislav Petkov <bp@alien8.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Vineet Gupta <vgupta@synopsys.com>, Fengguang Wu <fengguang.wu@intel.com>, Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-ia64@vger.kernel.org, linux-am33-list@redhat.com, linux-sh@vger.kernel.org, linux-edac@vger.kernel.org, x86@kernel.org, linux-snps-arc@lists.infradead.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

On Mon 2018-01-08 11:09:42, Sergey Senozhatsky wrote:
> On (01/05/18 15:42), Petr Mladek wrote:
> >=20
> > I am all for it. But I would postpone this removal to 4.17.
> > The reason is rather ugly. 13th patch is already in arc tree.
> > We would need to shuffle the patch or coordinate pull requests.
>=20
> JFI, the patch is in Linus's tree as of now (d0729bc6bee797fb).

Great. I have pushed the patch that removes printk_symbol()
into printk.git, branch for-4.16-print-symbol.

Note that I have updated the commit message similar way
like I did for the other commits. Especially I wanted
to mention what it was obsoleted by. The message is:

  kallsyms: remove print_symbol() function

  No more print_symbol()/__print_symbol() users left, remove these
  symbols.

  It was a very old API that encouraged people use continuous lines.
  It had been obsoleted by %pS format specifier in a normal printk()
  call.


See also
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?=
h=3Dfor-4.16-print-symbol&id=D2279c9d7f7db7f97567368bfc4539b3411adf8d

Best Regards,
Petr

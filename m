From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Sep 2013 10:44:53 +0000
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
Message-Id: <52441025.9030308@nod.at>
List-Id: <linux-sh.vger.kernel.org>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
In-Reply-To: <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ramkumar Ramachandra <artagnon@gmail.com>
Cc: linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, Jeff Dike <jdike@addtoit.com>, gxt@mprc.pku.edu.cn, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Am 26.09.2013 12:40, schrieb Ramkumar Ramachandra:
> Richard Weinberger wrote:
> Forget all that. What matters is that upstream is still broken, and
> users are suffering. Despite a reasonable fix being submitted in July.

So, what exactly is broken in upstream?
make defconfig works as it always did.

make defconfig ARCH=um SUBARCH=x86 (or SUBARCH=i386) will create a defconfig for 32bit.
make defconfig ARCH=um SUBARCH=x86_64 one for 64bit.

Thanks,
//richard

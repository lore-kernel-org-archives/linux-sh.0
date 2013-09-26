From: Ramkumar Ramachandra <artagnon@gmail.com>
Date: Thu, 26 Sep 2013 10:54:12 +0000
Subject: Re: [PATCH 2/8] um: Do not use SUBARCH
Message-Id: <CALkWK0k5neR50h+AWEF5AgnpbgWMitZUnbv_caVzt6HiUA6mXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-3-git-send-email-richard@nod.at> <CALkWK0kCrQ9hPABD_XQ9QFG-vByP+xZWZs+RkVK77+cX7Odz7g@mail.gmail.com>
 <52441025.9030308@nod.at>
In-Reply-To: <52441025.9030308@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, Jeff Dike <jdike@addtoit.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Richard Weinberger wrote:
> So, what exactly is broken in upstream?
> make defconfig works as it always did.

Auto-detection of SUBARCH, which can be done with a simple call to
uname -m (the 90% case). The second patch I submitted prevented
spawning xterms unnecessarily, which we discussed was a good move.

> make defconfig ARCH=um SUBARCH=x86 (or SUBARCH=i386) will create a defconfig for 32bit.
> make defconfig ARCH=um SUBARCH=x86_64 one for 64bit.

Yes, that's how I prepared the patch in the first place.

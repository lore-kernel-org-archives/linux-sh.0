From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 29 May 2020 17:45:40 +0000
Subject: [RESEND] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org


Hi!

This is my attempt of implementing a 64-bit get_user() for SH to address the
build problem when CONFIG_INFINIBAND_USER_ACCESS is enabled.

I have carefully looked at the existing implementations of __get_user_asm(),
__put_user_asm() and the 64-bit __put_user_u64() to come up with the 64-bit
__get_user_u64().

I'm admittedly not an expert when it comes to writing GCC contraints, so the
code might be completely wrong. However, it builds fine without warnings
and fixes the aforementioned issue for me.

Hopefully someone from the more experienced group of kernel developers can
review my code and help me get it into proper shape for submission.

Resent because I forgot to add a subject for the first cover text.

Thanks,
Adrian

--
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 11 Jun 2020 07:58:10 +0000
Subject: [PATCH v3] sh: Implement __get_user_u64() required for 64-bit get_user()
Message-Id: <20200611075811.2949870-1-glaubitz@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, NIIBE Yutaka <gniibe@fsij.org>, linux-kernel@vger.kernel.org

Hi!

This is version 3 of my patch to implement __get_user_u64() for SH.

I have asked both Yutaka Niibe and Yoshinori Sato to look over my changes and they
both agreed that an entry in __ex_tables for the second access was missing, so I
add the missing ".long 1b+2, 3b\n\t".

The changes should be correct now and will hopefully get a positive review by
the SH maintainers.

Thanks,
Adrian

--
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

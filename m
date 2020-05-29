From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 29 May 2020 09:03:37 +0000
Subject: Build fails with unknown symbol __get_user_unknown with InifiniBand enabled
Message-Id: <8945f9b7-d4d3-851e-dc4f-2d05ed94c169@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

Trying to build the SuperH kernel on Debian currently fails with:

	ERROR: "__get_user_unknown" [drivers/infiniband/core/ib_uverbs.ko] undefined!

when Infiniband is enabled (which is the default in Debian) during build.

I have assumed that the problem is similar to what Kuninori Morimoto fixed in the
sh-next branch [2] but I couldn't figure out where __get_user_unknown() is actually
defined within the kernel.

Does anyone know how to fix this problem?

Thanks,
Adrian

> [1] https://buildd.debian.org/status/fetch.php?pkg=linux&arch=sh4&ver=5.6.14-1&stamp90304428&raw=0
> [2] https://osdn.net/projects/uclinux-h8/scm/git/linux/commits?branch=sh-next

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

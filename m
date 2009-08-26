From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Wed, 26 Aug 2009 18:33:46 +0000
Subject: [BUG] arch/sh/include/mach-common/mach/sh7785lcr.h: PCA9564_ADDR
Message-Id: <4A95800A.7020603@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Since some months ago i noticed that with newer kernels the RTC on the
SH7785LCR stopped working when running on 32bit mode. I just found out
this is due to a commit that reverted the declaration of the
PCA9564_ADDR address for both 29bit and 32bit mode. The current address
only works on 29bit mode.

The bad commit is the following:

http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commitdiff;h{ce6c2740fab36708233e998a9e53115649b193

And it makes this error on 32bit mode:

rtc-rs5c372 0-0032: can't read registers
rtc-rs5c372: probe of 0-0032 failed with error -5
PCA9564/PCA9665 at 0x06000000 registered.

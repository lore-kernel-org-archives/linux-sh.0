From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 26 Apr 2016 21:52:25 +0000
Subject: [PATCH v2 0/6] simplify rtc-generic driver
Message-Id: <1461707551-1337971-1-git-send-email-arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: geert@linux-m68k.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, linux-alpha@vger.kernel.org, a.zummo@towertech.it, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-m68k@lists.linux-m68k.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org

This is a resend of an earlier series, to clean up the rtc-generic
driver by avoiding the dependency on the architecture specific
include/asm/rtc.h header that after this series is only used
for the deprecated "genrtc" driver. As I've shown in another
series, only three architectures (m68k, powerpc, parisc)
actually use the genrtc driver, and they all support rtc-generic
as a replacement as well.

The only missing piece appears to be the ioctl support for
the m68k q40 machine that I'm adding in patch 2 here.

	Arnd


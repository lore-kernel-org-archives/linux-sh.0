From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 04:39:07 +0000
Subject: [PATCH 0/2] Resume maintenance & development of arch/sh
Message-Id: <20160108043907.GA7005@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>

Yoshinori Sato and I would like to take over as co-maintainers for the
orphaned sh (SuperH) arch. Sato-san is the current H8/300 arch
maintainer and introduced the original sh2 support in Linux. I am
working on the software side of the J-Core project reviving the sh
arch as open hardware (see https://lwn.net/Articles/647636/), and am
also the maintainer of musl libc.

We plan to transition arch/sh from legacy board support files to
device tree, clean up infrastructure that was previously arch-specific
but which has since been replaced with arch-generic solutions
elsewhere in the kernel, and add support for new hardware,
specifically the J2 and future J-Core processors and SOC devices.

Rich

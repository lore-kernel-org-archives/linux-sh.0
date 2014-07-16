From: Paul Bolle <pebolle@tiscali.nl>
Date: Wed, 16 Jul 2014 11:15:09 +0000
Subject: ARM: shmobile: r7s72100: genmai: CONFIG_MACH_GENMAI
Message-Id: <1405509309.4408.36.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit bec652e2fbfe ("ARM: shmobile: r7s72100: genmai: Remove legacy
board file") is included in linux-next as of next-20140716.

It removed the Kconfig symbol MACH_GENMAI (twice!). It also removed its
macro from a Makefile. It did not touch its macro from
arch/arm/mach-shmobile/Makefile.boot.

Is the trivial patch to remove CONFIG_MACH_GENMAI from that Makefile
queued somewhere?


Paul Bolle


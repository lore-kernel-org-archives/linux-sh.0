From: Rob Landley <rob@landley.net>
Date: Wed, 22 Jun 2016 18:31:00 +0000
Subject: tmpfs and devtmpfs on nommu.
Message-Id: <576AD964.8040704@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Although devtmpfs mounts fine, tmpfs itself depends on shm which depends
on mmu.

In mm/shm.c there are a few small #ifdef tmpfs but the big one is lines
1561 to 3026, which seems to be most of tmpfs. There's sort of a stub
tmpfs afterwards, if that's not enabled, so presumably that's how we get
devtmpfs with CONFIG_TMPFS disabled.

My question is: can we add the size checking logic to the stub? I'm
aware that faulting pages to swap isn't happening without an mmu, but we
can at least make it so logfiles filing up initramfs don't lock the box
hard.

Rob

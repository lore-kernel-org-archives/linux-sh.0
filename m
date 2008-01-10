From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Thu, 10 Jan 2008 19:32:44 +0000
Subject: Build error with -rc7/.25 queue
Message-Id: <1199993564.6349.4.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Building with the 2.6.25 queue on top of 2.6.24-rc7-git(latest) I get
this:

 SYSCALL arch/sh/kernel/vsyscall/vsyscall-trapa.so
/home/adrian/dreamy-linux/buildroot/build_sh4/staging_dir/usr/bin/sh4-linux-uclibc-ld: error in arch/sh/kernel/vsyscall/vsyscall-trapa.o(.eh_frame); no .eh_frame_hdr table will be created.


Not had time to investigate, but thought I should let the list know.

Adrian


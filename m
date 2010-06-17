From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 17 Jun 2010 10:32:56 +0000
Subject: Userspace command line gcc options troubles
Message-Id: <201006171232.56669.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all
when I try to build init.c application I get the following error:
sh-uclinux-gcc -O2 -mfdpic -m2a -mb init.c
/home/fgiovagnini/sh7203/sh7203-
uclinux-4.4-206/build/target/bin/../lib/gcc/sh-uclinux/4.4.1/../../../../sh-
uclinux/bin/as: unrecognized option '--fdpic--isa=sh2a'
make[1]: *** [init.o] Errore 1

I'm using as suggsted:
sh-uclinux-gcc (Sourcery G++ Lite 4.4-206) 4.4.1
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


How could I solve?


Thanks 
-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
www.aurion-tech.com

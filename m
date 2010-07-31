From: Tiago Maluta <tiago.maluta@gmail.com>
Date: Sat, 31 Jul 2010 16:44:57 +0000
Subject: question about __NR_restart_syscall
Message-Id: <AANLkTik=25zU1ps454ZA7P+MYTqN0sA2HAUR0qiqLke_@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I was debugging (with gdb) a piece of code of an kernel object, the
snippet of module init function is:

(...)
0x0000000a : mov #0,r0
0x0000000c : .word 0x0000
0x0000000e : mov.l r0,@(0,r0)
0x00000010 : .word 0x0001
0x00000012 : mov.b r0,@(0,r0)

This code is regarded to __NR_restart_syscall? and, if yes, this
syscalls could restart the kernel?

--tm

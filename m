From: rdtorres@gmail.com
Date: Tue, 30 Sep 2008 22:26:23 +0000
Subject: CoreDump STLinux
Message-Id: <a7b2eccc0809301526l1f8f392euabbda91aedb7fede@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

First of all sorry to send an email to linuxsh-dev list directly, I
doing it because my attempt to use linux-sh@m17n.org fail (its site is
down).

My problem:
I trying to analyse a core-dump of  "Hello-world" like app that is
running on SH4-STLinux, but it fails.

gdb gives me :

(gdb) bt full
#0  0x297382d4 in raise () from
/opt/7109/STM/STLinux-2.2/devkit/sh4/bin/../target/lib/libc.so.6
No symbol table info available.
#1  0x29739dd6 in abort () from
/opt/7109/STM/STLinux-2.2/devkit/sh4/bin/../target/lib/libc.so.6
No symbol table info available.
Cannot access memory at address 0x7b916ff8


My program code:

#include <stdlib.h>

extern void m1();

static int count = 0;

void m3(){
       if (count++ > 2)
               abort();
       m1();
}

void m2(){
       m3();
}

void m1 (){
       m2();
}

int
main (int argc, char* argv[]) {
       m1();
       return 0;
}

I compiled it with /opt/STM/STLinux-2.2/devkit/sh4/bin/sh4-linux-g++
-g -o mysand sandbox.cpp

I've tried -fstack-protector-all option without success too.

Before running it on STLinux I'm running: ulimited -c unlimited.


Do you have any idea why the stack of my core-dump is broken ?


Thanks in advance,
Rafael Torres

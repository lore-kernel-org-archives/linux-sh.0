From: Drasko DRASKOVIC <drasko.draskovic@gmail.com>
Date: Fri, 19 Feb 2010 23:51:38 +0000
Subject: Unaligned kernel access for __udivsi3_i4i
Message-Id: <5ec3d7931002191551g21c0cda9le17729529b1afd78@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi all,
I am getting Unaligned kernel access on 0x809b7662

(gdb) disassemble 0x809b7662 0x809b7762
Dump of assembler code from 0x809b7662 to 0x809b7762:
0x809b7662 <__udivsi3_i4i+54>:=A0=A0=A0 mov.l=A0=A0=A0 @(r0,r1),r1
0x809b7664 <__udivsi3_i4i+56>:=A0=A0=A0 mov=A0=A0=A0 r5,r0
0x809b7666 <__udivsi3_i4i+58>:=A0=A0=A0 tst=A0=A0=A0 #-2,r0
0x809b7668 <__udivsi3_i4i+60>:=A0=A0=A0 mova=A0=A0=A0 0x809b784c <__sdivsi3=
_i4i+336>,r0
...


Can it be related to __udivsi3_i4i and toolchain problem, mentioned
here http://209.85.229.132/search?q=CAche:7eePA2ixT4gJ:www.sfr-fresh.com/li=
nux/misc/v2.6/ChangeLog-2.6.21+__udivsi3_i4i+unaligned+access+st+linux&cd=
=10&hl=3Den&ct=3Dclnk


Can this be the reason that my app is crashing (after some time) with
SIGBUS errors?


How can I further investigate problem of unaligned access in the
kernel, to check if it comes from kernel modules?


Best regards,
Drasko

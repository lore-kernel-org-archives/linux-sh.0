From: Hideo Saito <saito@densan.co.jp>
Date: Fri, 15 Feb 2008 09:10:59 +0000
Subject: Re: needs writeback on ptrace
Message-Id: <20080215.181059.74166085.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20080215.095254.68562685.saito@densan.co.jp>
In-Reply-To: <20080215.095254.68562685.saito@densan.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org


On Fri, 15 Feb 2008 16:56:59 +0900, Paul Mundt wrote:
> What are the values of address, phys, and alias_mask on your platform in
> this case?

In the case of the condition |if ((address^phys) & alias_mask)| is not true=
, the values are as follows.

address@0678,phys=D74a000,alias_mask=1000
address@0678,phys=D74a000,alias_mask=1000
address)565040,phys=D045000,alias_mask=1000
address)565040,phys=D045000,alias_mask=1000
address@07e8,phys=D74a000,alias_mask=1000
address@07e8,phys=D74a000,alias_mask=1000

gdb steps following code

67        printf("n =3D %d, nn =3D %d, sum =3D %d\n", n, nn, nsum(n, nn));
(gdb) next

(gdb) info line 67
Line 67 of "hello.c" starts at address 0x4007d2 <main+366>
   and ends at 0x400804 <main+416>.
(gdb) disas 0x4007d2 0x400804
Dump of assembler code from 0x4007d2 to 0x400804:
0x004007d2 <main+366>:  mov     r14,r1
0x004007d4 <main+368>:  add     #-16,r1
0x004007d6 <main+370>:  mov.l   @(24,r1),r2
0x004007d8 <main+372>:  mov     r14,r1
0x004007da <main+374>:  add     #-16,r1
0x004007dc <main+376>:  mov.l   @(28,r1),r1
0x004007de <main+378>:  mov     r2,r4
0x004007e0 <main+380>:  mov     r1,r5
0x004007e2 <main+382>:  mov.l   0x4008cc <main+616>,r1  ! 0x40061a <nsum>
0x004007e4 <main+384>:  jsr     @r1
0x004007e6 <main+386>:  nop
0x004007e8 <main+388>:  mov.l   0x4008d0 <main+620>,r2  ! 0x400aac
0x004007ea <main+390>:  mov     r14,r1
0x004007ec <main+392>:  add     #-16,r1
0x004007ee <main+394>:  mov.l   @(24,r1),r3
0x004007f0 <main+396>:  mov     r14,r1
0x004007f2 <main+398>:  add     #-16,r1
0x004007f4 <main+400>:  mov.l   @(28,r1),r1
0x004007f6 <main+402>:  mov     r2,r4
0x004007f8 <main+404>:  mov     r3,r5
0x004007fa <main+406>:  mov     r1,r6
0x004007fc <main+408>:  mov     r0,r7
0x004007fe <main+410>:  mov.l   0x4008d4 <main+624>,r1  ! 0x400360 <printf@=
plt>
0x00400800 <main+412>:  jsr     @r1
0x00400802 <main+414>:  nop
End of assembler dump.
(gdb)=20

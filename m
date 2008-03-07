From: Kieran Bingham <kieranbingham@gmail.com>
Date: Fri, 07 Mar 2008 14:30:15 +0000
Subject: Fixing up unaligned userspace access
Message-Id: <1204900215.12315.174.camel@atlas.mpc-data.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi guys,

I'm getting confused about how the unaligned accesses are being handled
in SH2/SH2a.

Our busybox build and userland seems to be causing these exceptions far
too often.

For example, pressing "Tab" to tab complete a filename, causes these two
exceptions to fire, and then soon after the whole board stalls.



Fixing up unaligned userspace access in "sh" pidH pc=0x0ccda168
ins=0x60f0

Fixing up unaligned userspace access in "sh" pidH pc=0x0ccd9eac
ins=0x9015



Mainly I'm confused though, as looking at the assembly the instructions
aren't unaligned ? and don't seem to be trying to do anything
un-aligned ? - Is there something else that could be going on here?


In the first instance, the code disassembly from HEW shows :

DissAddr Obj Code          Dissassembly

0CCDA158 6893              MOV       R9,R8
0CCDA15A 410B              JSR       @R1
0CCDA15C 7801              ADD       #H'01,R8
0CCDA15E 64A2              MOV.L     @R10,R4
0CCDA160 3488              SUB       R8,R4
0CCDA162 D13C              MOV.L     @(H'00F0:8,PC),R1
0CCDA164 410B              JSR       @R1
0CCDA166 0009              NOP       
0CCDA168 60F0              MOV.B     @R15,R0     ## Faulting Address
0CCDA16A 8809              CMP/EQ    #H'09,R0
0CCDA16C 8904              BT        @H'CCDA178:8
0CCDA16E 9162              MOV.W     @(H'00C4:8,PC),R1
0CCDA170 31FC              ADD       R15,R1
0CCDA172 9061              MOV.W     @(H'00C2:8,PC),R0
0CCDA174 5119              MOV.L     @(H'24:4,R1),R1
0CCDA176 0F16              MOV.L     R1,@(R0,R15)
0CCDA178 AE21              BRA       @H'CCD9DBE:12
0CCDA17A 0009              NOP       

That seems to read fine as move the value pointed by R15 into R0, and
compare to see if it is H'09 ...

And at the second exception :

DissAddr Obj Code          Dissassembly

0CCD9E96 A0D5              BRA       @H'CCDA044:12
0CCD9E98 0009              NOP       
0CCD9E9A 7101              ADD       #H'01,R1
0CCD9E9C 3010              CMP/EQ    R1,R0
0CCD9E9E 8D4A              BT/S      @H'CCD9F36:8
0CCD9EA0 627C              EXTU.B    R7,R2
0CCD9EA2 A12E              BRA       @H'CCDA102:12
0CCD9EA4 E11F              MOV       #H'1F,R1
0CCD9EA6 D118              MOV.L     @(H'0060:8,PC),R1
0CCD9EA8 410B              JSR       @R1
0CCD9EAA 0009              NOP       
0CCD9EAC 9015              MOV.W     @(H'002A:8,PC),R0 ## Faulting Addr
0CCD9EAE E101              MOV       #H'01,R1
0CCD9EB0 A164              BRA       @H'CCDA17C:12
0CCD9EB2 0F16              MOV.L     R1,@(R0,R15)
0CCD9EB4 D114              MOV.L     @(H'0050:8,PC),R1
0CCD9EB6 410B              JSR       @R1
0CCD9EB8 0009              NOP       
0CCD9EBA D114              MOV.L     @(H'0050:8,PC),R1
0CCD9EBC E200              MOV       #H'00,R2
0CCD9EBE 900C              MOV.W     @(OFF_R6:8,PC),R0
0CCD9EC0 E3FF              MOV       #H'FF,R3



Does anyone have any clue as to which direction I should start poking to
find out what is actually causing these exceptions ?

Cheers

Hmmmmmmm and I've confused my self further ... tab completion in the
shell is working without issue on the NFS mounts, but not if you try to
tab complete filenames from within the root/mtd folders .... I'm not
sure thats much of a clue - but perhaps the bug is somewhere in the FS
instead of the busybox shell ...


-- 

Kieran Bingham,


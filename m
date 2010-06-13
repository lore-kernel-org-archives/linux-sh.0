From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Sun, 13 Jun 2010 10:03:09 +0000
Subject: [sh7785lcr proto] fails to boot since commit 6430a5987f8bb9a7c5187b343956aa8ef404d571
Message-Id: <4C14ACDD.6050004@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello list,

I tried some weeks to upgrade the sh7785lcr prototype board using 32bits
to the latest released kernel(2.6.34.something). I've also tried with
latest git.

However it fails to boot:

<snip>
U-Boot 1.3.3-00319-gcd0b0dc-dirty (Sep  9 2008 - 17:12:09)

CPU: SH4A
BOARD: Renesas Technology Corp. R0P7785LC0011RL
DRAM:  128MB
FLASH: 64MB
PCI: SH7780 PCI host bridge found.
PCI:   Bus Dev VenId DevId Class Int
        00  00  10ec  8169  0200  00
        00  01  1095  3512  0180  00
In:    serial
Out:   serial
Err:   serial
Net:   RTL8169#0
=> run boot32
## Starting application at 0xA3F80000 ...


U-Boot 2009.06-rc2-05736-gf40f6db-dirty (May 26 2009 - 14:43:40)

CPU: SH4
BOARD: Renesas Technology Corp. R0P7785LC0011RL
DRAM:  384MB
FLASH: 64MB
PCI: SH7780 PCI host bridge found.
PCI:   Bus Dev VenId DevId Class Int
        00  00  10ec  8169  0200  00
        00  01  1095  3512  0180  00
In:    serial
Out:   serial
Err:   serial
Net:   RTL8169#0
Hit any key to stop autoboot:  0
Using RTL8169#0 device
TFTP from server 192.168.0.3; our IP address is 192.168.0.12
Filename 'uImage.32bit'.
Load address: 0x89000000
Loading: #################################################################
         #################################################################
         ########################################################
done
Bytes transferred = 2726217 (299949 hex)
## Booting kernel from Legacy Image at 89000000 ...
   Image Name:   Linux-2.6.35-rc2-00750-g9973e38
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    2726153 Bytes =  2.6 MB
   Load Address: 88001000
   Entry Point:  88002000
   Verifying Checksum ... OK
?  Uncompressing Kernel Image ... OK

<It reboots here>

U-Boot 1.3.3-00319-gcd0b0dc-dirty (Sep  9 2008 - 17:12:09)

CPU: SH4A
BOARD: Renesas Technology Corp. R0P7785LC0011RL
</snip>

I've bisected it and found this commit the culprit:
http://git.kernel.org/?p=linux/kernel/git/lethal/sh-2.6.git;a=commit;hd30a5987f8bb9a7c5187b343956aa8ef404d571

Using a commit before this one, it boots, and applying this patch to
that commit, fails.

Reverting this commit on current git, still doesn't boot.

Needless to say, 29bit mode still works...

Talking with mfleming on #linux-sh(he did the commit, he suggested me
the following:
<snip>
<mfleming> when the board resets can you read the value of address
0xff00000c from uboot and see if it contains 0x80000000 ?
<armin76> mfleming:
http://dev.gentoo.org/~armin76/sh/sh7785lcr.32bitproto.config
<mfleming> (that's the TLB exception register)
<armin76> notice that the only change between defconfig and this one is
the proto thing and the mem address and size
<armin76> mfleming: ok, let me check...
<armin76> when it resets you mean when i use the latest git kernel and
starts over, right? :)
<mfleming> yes, or when you use the kernel that head my commit as HEAD.
do they both reset?
<mfleming> s/head/has/
<armin76> yes
<armin76> both do the same
<mfleming> either one is fine then
<mfleming> but if you use mine it'll be easier to debug
<mfleming> my commit, i mean
<armin76> sure, lets see...
<armin76> mfleming:  md 0xff00000c
<armin76> ff00000c: 80000000 2c000000 00000000 00000000    .......,........
<mfleming> wait, are you still at the uboot prompt?
<mfleming> what's in 0xff000020 ?
<armin76> yes
<armin76> md 0xff000020
<armin76> ff000020: 00000000 00000140 00000000 00000000    ....@...........
<mfleming> aha!
<mfleming> multipl TLB hit exception
<mfleming> err, multiple
</snip>

My kconfig is at
http://dev.gentoo.org/~armin76/sh/sh7785lcr.32bitproto.config

Thanks

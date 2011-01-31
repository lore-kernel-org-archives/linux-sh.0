From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 31 Jan 2011 05:35:30 +0000
Subject: Re: help about rks+7203 and derived board
Message-Id: <201101310635.30921.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all, now I can report the actual condition:
1) toolchain used:
G++ Lite 4.4-206) 4.4.1
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

2) Kernel got as follow
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6.git
$ git checkout v2.6.37

3) Kernel build as follow:
$  make ARCH=sh CROSS_COMPILE=sh-uclinux- rsk7203_defconfig
$  make ARCH=sh CROSS_COMPILE=sh-uclinux- uImage

my board boot successfully.
And with this kernel also work without any workaround the flash.






On Monday 31 January 2011 05:36:55 Nobuhiro Iwamatsu wrote:
> Hi,
> 
> 2011/1/28 Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>:
> > Hi,
> > I was able to build u-boot for my board (rsk+ derived) and it works.
> > I was able to build uImage for linux 2.6.17 made by Keiram (who gave me
> > the zImage working) and I was able to boot;
> > I build zImage for 2.6.37+ and uImage for 2.6.27+ and I was not ablt to
> > see anything on the serial console on booting.
> > These are my informations.
> 
> Yes, old zImage ( v2.6.17 ) work on my env too.
> ( this zImage included in RSK BSP ).
> 
> Best regards,
>   Nobuhiro

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com

From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Mar 2010 06:41:59 +0000
Subject: Re: Hi All, hot to debug my eth0' hw?
Message-Id: <aec7e5c31003162341n444b6225gfc6dc1478d3744a8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201003161225.42600.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Wed, Mar 17, 2010 at 3:15 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> I'm tring to build the new 2.6-git kernel
> I'm using gcc-3.4.6 based toolchain;

For the kernel please use the latest codesourcery toolchain. Actually,
in general, please try the latest version of any software before you
report any issues.

> Which toolchian I have to use?

For sh2a user space I'm not sure.

The kernel builds just fine for me:

damm@t400s ~/kernel/sh-2.6 $ _gcc --version
sh-linux-gnu-gcc (Sourcery G++ Lite 4.4-45) 4.4.1
Copyright (C) 2009 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

damm@t400s ~/kernel/sh-2.6 $ make -j 3 ARCH=sh CROSS_COMPILE=_ rsk7203_defconfig
[snip]
damm@t400s ~/kernel/sh-2.6 $ make -j 3 ARCH=sh CROSS_COMPILE=_ uImage
[snip]
  LD      vmlinux
  SYSMAP  System.map
  SYSMAP  .tmp_System.map
  OBJCOPY arch/sh/boot/vmlinux.bin
  GZIP    arch/sh/boot/vmlinux.bin.gz
  UIMAGE  arch/sh/boot/uImage.gz
Image Name:   Linux-2.6.34-rc1
Created:      Wed Mar 17 15:31:35 2010
Image Type:   SuperH Linux Kernel Image (gzip compressed)
Data Size:    1362130 Bytes = 1330.21 kB = 1.30 MB
Load Address: 0c001000
Entry Point:  0c002000
  Image arch/sh/boot/uImage is ready
damm@t400s ~/kernel/sh-2.6 $

Cheers,

/ magnus

From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Jan 2011 00:28:52 +0000
Subject: Re: Booting kernel 2.6.37+ for renesas sh on sh2a 7203
Message-Id: <20110118002851.GE2122@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101161739.57933.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 17, 2011 at 10:30:28PM +0100, Fabio Giovagnini wrote:
> Where could I find the exact sequence of command I have to execute to build and 
> run under u-boot the kernel?
> I did:
> make uImage and I got the following:
> 
> Is there anything wrong?
> I used the toolchain
> sh7203-uclinux-4.4-206
> and with the same u-boot is built and executed properly.
> 
> fgiovagnini@aurio01:~/sh7203/sh7203-uclinux-4.4-206/build$ make -f 
> Makefile.sh-2.6
> 
> 
> ***************************************************
> ***                Building Linux               ***
> ***************************************************
> make -C /home/fgiovagnini/sh7203/sh7203-uclinux-4.4-206/build/../sh-2.6 
> ARCH=sh CROSS_COMPILE=sh-uclinux- uImage
> make[1]: ingresso nella directory ?/home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-206/sh-2.6?
>   CHK     include/linux/version.h
>   CHK     include/generated/utsrelease.h
> make[2]: ?include/generated/machtypes.h? ? aggiornato.
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
[snip]

>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   OBJCOPY arch/sh/boot/vmlinux.bin
>   GZIP    arch/sh/boot/vmlinux.bin.gz
>   UIMAGE  arch/sh/boot/uImage.gz
> Image Name:   Linux-2.6.37+
> Created:      Mon Jan 17 22:27:07 2011
> Image Type:   SuperH Linux Kernel Image (gzip compressed)
> Data Size:    975877 Bytes = 953.00 kB = 0.93 MB
> Load Address: 0x0C001000
> Entry Point:  0x0C002000
>   Image arch/sh/boot/uImage is ready

The uImage has generated succesfully, so what exactly is the problem?

If you need basic uboot instructions then try the uboot website or
mailing list.

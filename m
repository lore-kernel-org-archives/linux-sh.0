From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Mon, 04 Mar 2019 13:23:53 +0000
Subject: Re: Kernel compilation for SH4 arch fails with poky 2.5.2
Message-Id: <a5bc48a0-dc5f-ccfe-0d1a-4f0576d3afa0@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <8beaba914a6a423ba3acef4adfd34179@BLRX13MDC425.AMER.DELL.COM>
In-Reply-To: <8beaba914a6a423ba3acef4adfd34179@BLRX13MDC425.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Raveendra!

On 3/4/19 2:01 PM, Raveendra.Reddy.P@dell.com wrote:
> When we configure poky-2.5.2 with sh4 (SuperH) arch and Linux kernel 4.9.161, it fails with following error message. 
> From our observations, the below issue seems to be due to toolchain/gcc not the kernel.
> 
> #bitbake linux-yocto
> 
>    CC      drivers/mmc/core/sd.o
> | {standard input}: Assembler messages:
> | {standard input}: Error: unaligned opcodes detected in executable segment
> | make[5]: *** [drivers/mmc/core/sd.o] Error 1
> | make[4]: *** [drivers/mmc/core] Error 2
> | make[3]: *** [drivers/mmc] Error 2
> | make[2]: *** [drivers] Error 2
> | make[2]: *** Waiting for unfinished jobs....
> | make[1]: *** [sub-make] Error 2
> | make: *** [__sub-make] Error 2
> | ERROR: oe_runmake failed

I haven't seen this particular error yet. We're building the sh4 kernel with gcc-8
for the SH7751LCR and SH7785LCR boards without any issues.

Full log available at:

> https://buildd.debian.org/status/fetch.php?pkg=linux&arch=sh4&ver=4.19.20-1&stamp50088221&raw=0

> Apart from configuring the sh4 machine and kernel version, we have not altered the default settings of poky. The machine config, kernel .config file and log files are attached. Could you please help us with the kernel compilation for sh4 architecture. 

I think you forgot to attach the configuration and log files? I'm not seeing them.

> Note: This issue was not observed with GCC version 4.9.0. Poky 2.5 has GCC Version 7.3.0. Expectation is to compile kernel with GCC 7.3.

If you give me the kernel configuration, I could try it with gcc-8 and report
back.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

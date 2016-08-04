From: Rich Felker <dalias@libc.org>
Date: Thu, 04 Aug 2016 18:38:48 +0000
Subject: Re: Build error in -next due to 'sh: add working futex atomic ops on userspace addresses for smp'
Message-Id: <20160804183848.GK15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <57A2C843.6060108@roeck-us.net>
In-Reply-To: <57A2C843.6060108@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Aug 03, 2016 at 09:44:51PM -0700, Guenter Roeck wrote:
> Hi,
> 
> I see the following build error in -next when building sh:shx3_defconfig.
> 
> {standard input}: Assembler messages:
> {standard input}:177: Error: unknown opcode
> {standard input}:7760: Error: unknown opcode
> 
> {standard input}:163: Error: displacement to defined symbol .L24 overflows 8-bit field
> {standard input}:6826: Error: displacement to defined symbol .L1409 overflows 12-bit field
> {standard input}:7051: Error: displacement to defined symbol .L1469 overflows 12-bit field
> [many more of those]
> 
> {standard input}:148: Error: pcrel too far
> {standard input}:7549: Error: negative offset
> [several more of those]
> 
> This is seen when building kernel/futex.o.
> 
> I initially thought that the problem was due to an old compiler/toolchain,
> but using a new toolchain did not help.
> 
> Toolchain:
> 	sh4-linux-gcc.br_real (Buildroot 2016.05) 5.3.0
> 	GNU ld (GNU Binutils) 2.26.20160125
> 
> When using gcc 4.6.3 (from the kernel.org toolchain), the error is reported as:
> 
> {standard input}: Assembler messages:
> {standard input}:318: Error: unknown opcode
> {standard input}:7282: Error: unknown opcode
> 
> Bisect (for both toolchains) points to 'sh: add working futex atomic ops on userspace
> addresses for smp' as the culprit. Bisect log is attached.

Thanks! It's just a missing "\n\t" after the "synco" before the #ifdef
CONFIG_MMU that caused the .section on the next line to get
concatenated with the synco. I'll fix it now. Glad you caught it.

Rich

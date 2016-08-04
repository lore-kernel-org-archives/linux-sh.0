From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Aug 2016 04:44:51 +0000
Subject: Build error in -next due to 'sh: add working futex atomic ops on userspace addresses for smp'
Message-Id: <57A2C843.6060108@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi,

I see the following build error in -next when building sh:shx3_defconfig.

{standard input}: Assembler messages:
{standard input}:177: Error: unknown opcode
{standard input}:7760: Error: unknown opcode

{standard input}:163: Error: displacement to defined symbol .L24 overflows 8-bit field
{standard input}:6826: Error: displacement to defined symbol .L1409 overflows 12-bit field
{standard input}:7051: Error: displacement to defined symbol .L1469 overflows 12-bit field
[many more of those]

{standard input}:148: Error: pcrel too far
{standard input}:7549: Error: negative offset
[several more of those]

This is seen when building kernel/futex.o.

I initially thought that the problem was due to an old compiler/toolchain,
but using a new toolchain did not help.

Toolchain:
	sh4-linux-gcc.br_real (Buildroot 2016.05) 5.3.0
	GNU ld (GNU Binutils) 2.26.20160125

When using gcc 4.6.3 (from the kernel.org toolchain), the error is reported as:

{standard input}: Assembler messages:
{standard input}:318: Error: unknown opcode
{standard input}:7282: Error: unknown opcode

Bisect (for both toolchains) points to 'sh: add working futex atomic ops on userspace
addresses for smp' as the culprit. Bisect log is attached.

Guenter

---
# bad: [4d9dc2a0baee551d44e853e28a69cec881308655] Add linux-next specific files for 20160804
# good: [523d939ef98fd712632d93a5a2b588e477a7565e] Linux 4.7
git bisect start 'HEAD' 'v4.7'
# good: [b0c4e2acdd6175a07107474f3cd7bdc062cf4d3d] Merge branch 'for-next' of git://git.samba.org/sfrench/cifs-2.6
git bisect good b0c4e2acdd6175a07107474f3cd7bdc062cf4d3d
# good: [77a87824ed676ca8ff8482e4157d3adb284fd381] clocksource/drivers/clps_711x: fixup for "ARM: clps711x:
git bisect good 77a87824ed676ca8ff8482e4157d3adb284fd381
# good: [221bb8a46e230b9824204ae86537183d9991ff2a] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect good 221bb8a46e230b9824204ae86537183d9991ff2a
# bad: [5134a4ec4905a332a460709acd4e08afe749d6fc] Merge remote-tracking branch 'befs/for-next'
git bisect bad 5134a4ec4905a332a460709acd4e08afe749d6fc
# good: [f0936155f2204720655aefbc2f17c25a2c80a59e] Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good f0936155f2204720655aefbc2f17c25a2c80a59e
# good: [50e4cfe7f334833aba4e5b69bbe6450aeed56732] Merge remote-tracking branch 'samsung-krzk/for-next'
git bisect good 50e4cfe7f334833aba4e5b69bbe6450aeed56732
# good: [1a4db2bf7d3c1e26a42337b5bb1e81b6b7cfce2b] Merge remote-tracking branch 'parisc-hd/for-next'
git bisect good 1a4db2bf7d3c1e26a42337b5bb1e81b6b7cfce2b
# bad: [a0f556c518531ec412b1dfeae008d175fd0b203e] Merge remote-tracking branch 'sh/for-next'
git bisect bad a0f556c518531ec412b1dfeae008d175fd0b203e
# good: [d844e279152c27e5b1a56dc40de08ddfd99176f3] powerpc/ptrace: Enable in transaction NT_PPC_VMX ptrace requests
git bisect good d844e279152c27e5b1a56dc40de08ddfd99176f3
# bad: [38396cc1e27e0fee33a70dcbe2bc5ad343144b8e] sh: add SMP support for J2
git bisect bad 38396cc1e27e0fee33a70dcbe2bc5ad343144b8e
# good: [f368d475871e8aafdfcffc858aad9647ced82fa2] sh: make board-secureedge5410 explicitly non-modular
git bisect good f368d475871e8aafdfcffc858aad9647ced82fa2
# good: [7213f0d9421066fd4e31c1230c150103d88431a4] sh: add support for J-Core J2 processor
git bisect good 7213f0d9421066fd4e31c1230c150103d88431a4
# good: [172e33b70901310162b981236f0612956e68eb8a] sh: add J2 atomics using the cas.l instruction
git bisect good 172e33b70901310162b981236f0612956e68eb8a
# bad: [7d582a9edd130847f9712fc7012f1a643b8b8f26] sh: SMP support for SH2 entry.S
git bisect bad 7d582a9edd130847f9712fc7012f1a643b8b8f26
# bad: [3adc5aa28659f0f6e9defb915a1ccc67d76704b7] sh: add working futex atomic ops on userspace addresses for smp
git bisect bad 3adc5aa28659f0f6e9defb915a1ccc67d76704b7
# first bad commit: [3adc5aa28659f0f6e9defb915a1ccc67d76704b7] sh: add working futex atomic ops on userspace addresses for smp

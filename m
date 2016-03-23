From: Rich Felker <dalias@libc.org>
Date: Wed, 23 Mar 2016 02:52:04 +0000
Subject: sh cpu_data init broken for smp?
Message-Id: <20160323025204.GA18208@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The arch/sh/kernel/cpu/*/probe.c cpu_probe functions are run per-cpu
from cpu_init from head_32.S, but they fill boot_cpu_data with cpu &
cache properties rather than current_cpu_data. Most of the consumers
of this data (especially cache properties), however, use
current_cpu_data, which seems to be default-initialized to zero for
all but the boot cpu. I can't confirm this bug on legacy SH hardware
since I don't have any that does SMP, but it's present on my
in-progress J2 SMP work.

Possibly a global s/boot_cpu_data/current_cpu_data/ should be applied
to arch/sh/kernel/cpu/*/probe.c and a few other places, but I wonder
why this data is even kept per-cpu. Can we actually support having
cache structure and cpu properties vary per-cpu in an SMP setup? I
don't think so, and if not, I'd rather switch to having a single copy
of the cpu_data and eliminate cpu_probe except at boot time on the
boot cpu.

A related issue is that I want to replace the 'probe' results that are
actually just hard-coded with data from device tree, which is only
available in flat form this early in the boot.

Rich

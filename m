From: Benoit Cousson <bcousson@baylibre.com>
Date: Wed, 26 Feb 2014 23:09:46 +0000
Subject: [RFC 0/4] ARM: shmobile: Add CPUFreq support for r8a7790-lager platform
Message-Id: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

This not-yet-ready-to-merge series is adding CPUFreq support to Lager board.

Due to the missing data for the OPP voltage values, a safe 1.0v value is
used for all OPPs.

At least this series can be used by Laurent to test the z-clock CCF node
and the KICK bit fix I've just sent.

Bottom-line, no real DVFS so far, but just DFS :-)

Please note that this series is safe even in the case of Cortex A7 boot
since the cpufreq-cpu0 driver is using the physical CPU@0 device node.
In the case of CA7 boot, the first cpu will be the CPU@100, and thus
the driver will fail at probe time due to the lack of CPU@0.

Regards,
Benoit 


Benoit Cousson (4):
  ARM: dts: r8a7790-lager: Add VDD MPU regulator for DVFS
  ARM: dts: r8a7790-lager: Add DVFS parameters into cpu0 node for
    r8a7790
  ARM: shmobile: lager-reference: Add cpufreq-cpu0 device for CPUFreq
    support
  ARM: shmobile: Make r8a77900 CPUFreq capable

 arch/arm/boot/dts/r8a7790-lager.dts            | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi                 | 11 +++++++++++
 arch/arm/mach-shmobile/Kconfig                 |  2 ++
 arch/arm/mach-shmobile/board-lager-reference.c |  3 +++
 4 files changed, 41 insertions(+)

-- 
1.8.3.2


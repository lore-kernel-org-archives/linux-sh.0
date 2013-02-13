From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 13 Feb 2013 14:16:13 +0000
Subject: [PATCH 00/02] ARM: shmobile: EMEV2 SMP DT reference code (hack alert!)
Message-Id: <20130213141613.12474.97583.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: EMEV2 SMP DT reference code (hack alert!)

[PATCH 01/02] ARM: shmobile: Temporarily use C to setup EMEV2 clocks
[PATCH 02/02] ARM: shmobile: Temporarily use emev2_map_io() for SMP

This series is a small silly SMP DT reference implementation meant
to give the sh73a0 DT SMP problem a kick in the butt.

None of the patches in the series should be merged as-is, but they
can instead be used to boot EMEV2 using DT with SMP support.

I've used the following steps to build an uImage for the KZM9D board:

make -j9 ARCH=arm CROSS_COMPILE=_ uImage
./scripts/dtc/dtc -I dts -O dtb arch/arm/boot/dts/emev2-kzm9d.dts -o arch/arm/boot/dts/emev2-kzm9d.dtb
rm arch/arm/boot/zImage arch/arm/boot/uImage
make -j9 ARCH=arm CROSS_COMPILE=_ zImage
cat arch/arm/boot/dts/emev2-kzm9d.dtb >> arch/arm/boot/zImage 
$(cut -f 3- -d ' ' < arch/arm/boot/.uImage.cmd)

The above sequence works well for me and is obviously much better and
easier than making use of any static mach-type number.

As for build configuration, use the following two on KZM9D DT-only:
CONFIG_ARCH_EMEV2=y
CONFIG_MACH_KZM9D=n

The current state of EMEV2 and KZM9D DT is that you can get serial
ports and the STI timer running with DT-only. The GPIO bits still
lack DT bindings. This means no ethernet, so initramfs is needed.

Not-even-remotely-signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    3 +++
 1 file changed, 3 insertions(+)

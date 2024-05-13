Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471164F883
	for <linux-sh@vger.kernel.org>; Mon, 13 May 2024 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715639500; cv=none; b=hUSY1Z/ziPd0/tAfJ0HUvd5bCwbZVfGsjpj6qWa/Jck3LQh3nXzywUZIlAu+8oMIm2GU6Rw5IfFILqxxT6yqCHuvjvxKvsbq/HfpNSTOTrfzexV/cmCaJ2udFnO8KwgoQ256CT9YXnSH4zMtUl4SnI/HIjDvmyD7Z8KRNNoMrOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715639500; c=relaxed/simple;
	bh=MKSoY19olU2TaA0AHyuiCNOc4VA+B7q/olktQ6ModJE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=OouDlcqhnG/CwukyarViJBLkrn7USMIQH1kIqv+9JsDME9KLxIYtnmrz3uY9UzLs265g6/VVMp3KY9zkClEKhiiw+QrT1s+j4o7cTFr5OdB2kcOQiFQW8c36lldxcan0PfVUClRqYBSVnrn3aFi2/e6QJDB++WOki49Ykbp+owI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=QW1W7qAc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="QW1W7qAc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qxgsh99CdnnyYWRLILMtymTD9trDqieVMRCTBo1DfoY=; t=1715639496; x=1716244296; 
	b=QW1W7qAcw6L38BdRkfG64bp9U1eaaB61f0deQWwlOwV6Ami4k3W3My+pyBtIt1kEPngxkI1/IQA
	fpFM46c5JvfjZWvlMBzTyMN2jlBZvEahTUq9FaIEXlU592S9ZFV76y+ZJQKLmDsa4eIjm3/acEDVk
	qsPmjNpzSC8+MIi2wfudxTVm+uUl3gFasTomDliYRws7gvqCxMcCdV/V5t1gZZBkWmiK3/FyGpJa8
	a/q9hL+nZQZ/mh+bwUnhCrO65qn37jBXShRMsVXESOFO+/bAUxSmbSiTiKXjQjfdf6MsaxvAAIfoQ
	GkCvpGbsH5oRyUcTvg6+gvDJRHl5oMug4oXw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s6eCe-00000002aHN-1afF; Tue, 14 May 2024 00:31:28 +0200
Received: from p5b13a15c.dip0.t-ipconnect.de ([91.19.161.92] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s6eCe-000000048Eb-0DPt; Tue, 14 May 2024 00:31:28 +0200
Message-ID: <80eaf34723abe96744f0a9b2859679cc88783433.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Guenter Roeck <linux@roeck-us.net>, Krzysztof
 Kozlowski <krzysztof.kozlowski@linaro.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Rich
 Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 linux-sh <linux-sh@vger.kernel.org>
Date: Tue, 14 May 2024 00:31:27 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello Linus,

this is my first larger pull request with a total of 35 changes with the ma=
jority
of improvements coming from Geert Uytterhoeven who took the time to fix a t=
otal
of 30 cases of "-Wmissing-prototypes" compiler warnings, either by adding a=
 missing
header include, defining the missing forward declarations or making the fun=
ctions
in question static. In the case of several DMA functions, the fix was to ac=
tually
just remove them as they were added but never used. Another one of these wa=
rnings
was eliminated by removing the left-over sh5 cache handling support, a chan=
ge that
was suggested by Yoshinori Sato. While at it, Geert also removed two unneed=
ed casts
to kprobe_opcode_t in the kprobes code.

Another change by Guenter Roeck was contributed to fix errors that were rep=
orted during
checksum unit tests. The fix actually reverts the older change cadc4e1a2b4d=
 ("sh: Handle
calling csum_partial with misaligned data") which turned to be incorrect. I=
t remains to
be investigated whether there is a better way to handle misaligned data in =
csum_partial().

A small fix contributed by Krzysztof Kozlowski drops the incorrect SPI cont=
roller
spi-max-frequency property in the device tree source file for the J2 device=
 platform
while Uwe Kleine-K=C3=B6nig converted the push-switch driver to have its ca=
llback function
return void, a change that is currently being applied to all drivers throug=
hout the
kernel in order to avoid resource leaks.

Last but not least, Artur Rojek has fixed the IOPORT base address for the S=
ega Dreamcast
platform which allows the Linux kernel to be successfully booted on this on=
ce popular video
game console for the first time since a long time ago.

The following changes since commit 4cece764965020c22cff7665b18a012006359095=
:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.10-tag1

for you to fetch changes up to efe976b7eecfa3f81e241da67d1a511e30a87779:

  sh: setup: Add missing forward declaration for sh_fdt_init() (2024-05-13 =
15:37:11 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.10

- sh: setup: Add missing forward declaration for sh_fdt_init()
- sh: smp: Protect setup_profiling_timer() by CONFIG_PROFILING
- sh: of-generic: Add missing #include <asm/clock.h>
- sh: dreamcast: Fix GAPS PCI bridge addressing
- sh: boot: Add proper forward declarations
- sh: boot: Remove sh5 cache handling
- Revert "sh: Handle calling csum_partial with misaligned data"
- sh: j2: Drop incorrect SPI controller spi-max-frequency property
- sh: push-switch: Convert to platform remove callback returning void
- sh: sh7785lcr: Make init_sh7785lcr_IRQ() static
- sh: sh7757: Add missing #include <asm/mmzone.h>
- sh: sh7757lcr: Make init_sh7757lcr_IRQ() static
- sh: mach-sh03: Make sh03_rtc_settimeofday() static
- sh: mach-highlander: Add missing #include <mach/highlander.h>
- sh: traps: Make is_dsp_inst() static
- sh: cache: Move forward declarations to <asm/cacheflush.h>
- sh: dma: Remove unused functionality
- sh: dwarf: Make dwarf_lookup_fde() static
- sh: kprobes: Remove unneeded kprobe_opcode_t casts
- sh: kprobes: Make trampoline_probe_handler() static
- sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
- sh: smp: Fix missing prototypes
- sh: sh7786: Remove unused sh7786_usb_use_exclock()
- sh: sh2a: Add missing #include <asm/processor.h>
- sh: dma: Remove unused dmac_search_free_channel()
- sh: math-emu: Add missing #include <asm/fpu.h>
- sh: nommu: Add missing #include <asm/cacheflush.h>
- sh: ftrace: Fix missing prototypes
- sh: hw_breakpoint: Add missing forward declaration for arch_bp_generic_fi=
elds()
- sh: traps: Add missing #include <asm/setup.h>
- sh: return_address: Add missing #include <asm/ftrace.h>
- sh: tlb: Add missing forward declaration for handle_tlbmiss()
- sh: syscall: Add missing forward declaration for sys_cacheflush()
- sh: fpu: Add missing forward declarations
- sh: pgtable: Fix missing prototypes

----------------------------------------------------------------
Artur Rojek (1):
      sh: dreamcast: Fix GAPS PCI bridge addressing

Geert Uytterhoeven (31):
      sh: pgtable: Fix missing prototypes
      sh: fpu: Add missing forward declarations
      sh: syscall: Add missing forward declaration for sys_cacheflush()
      sh: tlb: Add missing forward declaration for handle_tlbmiss()
      sh: return_address: Add missing #include <asm/ftrace.h>
      sh: traps: Add missing #include <asm/setup.h>
      sh: hw_breakpoint: Add missing forward declaration for arch_bp_generi=
c_fields()
      sh: ftrace: Fix missing prototypes
      sh: nommu: Add missing #include <asm/cacheflush.h>
      sh: math-emu: Add missing #include <asm/fpu.h>
      sh: dma: Remove unused dmac_search_free_channel()
      sh: sh2a: Add missing #include <asm/processor.h>
      sh: sh7786: Remove unused sh7786_usb_use_exclock()
      sh: smp: Fix missing prototypes
      sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
      sh: kprobes: Make trampoline_probe_handler() static
      sh: kprobes: Remove unneeded kprobe_opcode_t casts
      sh: dwarf: Make dwarf_lookup_fde() static
      sh: dma: Remove unused functionality
      sh: cache: Move forward declarations to <asm/cacheflush.h>
      sh: traps: Make is_dsp_inst() static
      sh: mach-highlander: Add missing #include <mach/highlander.h>
      sh: mach-sh03: Make sh03_rtc_settimeofday() static
      sh: sh7757lcr: Make init_sh7757lcr_IRQ() static
      sh: sh7757: Add missing #include <asm/mmzone.h>
      sh: sh7785lcr: Make init_sh7785lcr_IRQ() static
      sh: boot: Remove sh5 cache handling
      sh: boot: Add proper forward declarations
      sh: of-generic: Add missing #include <asm/clock.h>
      sh: smp: Protect setup_profiling_timer() by CONFIG_PROFILING
      sh: setup: Add missing forward declaration for sh_fdt_init()

Guenter Roeck (1):
      Revert "sh: Handle calling csum_partial with misaligned data"

Krzysztof Kozlowski (1):
      sh: j2: Drop incorrect SPI controller spi-max-frequency property

Uwe Kleine-K=C3=B6nig (1):
      sh: push-switch: Convert to platform remove callback returning void

 arch/sh/Kconfig                                 |   3 +-
 arch/sh/boards/board-sh7757lcr.c                |   2 +-
 arch/sh/boards/board-sh7785lcr.c                |   2 +-
 arch/sh/boards/mach-dreamcast/setup.c           |   3 +
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c |   1 +
 arch/sh/boards/mach-sh03/rtc.c                  |   2 +-
 arch/sh/boards/of-generic.c                     |   2 +
 arch/sh/boot/compressed/Makefile                |   2 +-
 arch/sh/boot/compressed/cache.c                 |  13 ---
 arch/sh/boot/compressed/misc.c                  |   9 +-
 arch/sh/boot/compressed/misc.h                  |   9 ++
 arch/sh/boot/dts/j2_mimas_v2.dts                |   2 -
 arch/sh/drivers/dma/dma-api.c                   | 143 --------------------=
----
 arch/sh/drivers/push-switch.c                   |   6 +-
 arch/sh/include/asm/cacheflush.h                |  12 ++
 arch/sh/include/asm/dma.h                       |   7 --
 arch/sh/include/asm/fpu.h                       |   3 +
 arch/sh/include/asm/ftrace.h                    |  10 ++
 arch/sh/include/asm/hw_breakpoint.h             |   2 +
 arch/sh/include/asm/setup.h                     |   1 +
 arch/sh/include/asm/syscalls.h                  |   1 +
 arch/sh/include/asm/tlb.h                       |   4 +
 arch/sh/kernel/cpu/sh2a/opcode_helper.c         |   2 +
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c          |   3 +
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c          |   1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c          |   3 +
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c          |  14 ---
 arch/sh/kernel/dwarf.c                          |   2 +-
 arch/sh/kernel/kprobes.c                        |  13 +--
 arch/sh/kernel/return_address.c                 |   2 +
 arch/sh/kernel/smp.c                            |   6 +-
 arch/sh/kernel/traps.c                          |  10 +-
 arch/sh/kernel/traps_32.c                       |   5 +-
 arch/sh/lib/checksum.S                          |  67 +++--------
 arch/sh/math-emu/math.c                         |   2 +
 arch/sh/mm/cache-sh4.c                          |   2 -
 arch/sh/mm/cache-shx3.c                         |   1 +
 arch/sh/mm/cache.c                              |  14 ---
 arch/sh/mm/nommu.c                              |   2 +
 arch/sh/mm/pgtable.c                            |   4 +-
 arch/sh/mm/tlbex_32.c                           |   1 +
 41 files changed, 111 insertions(+), 282 deletions(-)
 delete mode 100644 arch/sh/boot/compressed/cache.c
 create mode 100644 arch/sh/boot/compressed/misc.h

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

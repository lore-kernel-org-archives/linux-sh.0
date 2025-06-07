Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADD1362;
	Sat,  7 Jun 2025 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749310402; cv=none; b=l8Y+A+6H9LoEpG1Tf7cptcJbeKB5C9Qwx/BbmPYOFtcqBpZ+ZPQlmKPF5GXUptgSYQ1hCxHHvu0jVLsnmHuF7vJGdE4rnio3ePjwmacW54O+9SHDngvRMUv3IU2vxJiULMxzVDzp/PBu+L2D3WHQsvcNe806OoXg11S15ND9pIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749310402; c=relaxed/simple;
	bh=mL3bMPxtlWeP4omW9jhy3oREP5l10pyt+mXfirZFTiw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=RriiADCMEVc9q731AiWzNrGJqMvDHyInSFBWbEjprW9KETuFfjVxceyk8MLvDn6Ia6ehvBqDf6NXAJWVY+IO0Gy/v3+8Wgvb8OUTN7J+aD0dGQ8wVK6karVUR79TxkeKwsx10KA6MTQe9MdDhbJavBrgiRjpAXJN4gZDdCCVH64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=dG62WXl/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="dG62WXl/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8iUcTrsbpF5lvVp8YW0lY7JI5M8cSHdudxeylxSoV/4=; t=1749310400; x=1749915200; 
	b=dG62WXl/I7MjwwfDskgcYNfSOaZV6155wvGPLx2bqIU9YoPF0xkoD7CzCmXP7SLPSvw0CupTlnN
	RAAS2av5WcWcnU5Z+5QO7TAEeCAdM5untjpnxb/JDSE7rW5CIOl29aqfZ3cuWT0+KCpeGMKQMsF7v
	eKXECXoiL5AzLpb4q0yFsjXITQUvl9bIrM05/1Zg90lRY4w8TRym2T3FnNmb49AaFO0XIle/qegcE
	Nerz4HxlT5TBHx1DhGPIqEKg/b64kOFPbTtHD1cB+ZKNDy8WJibnV3WBo6z3KYH0gBCY7Jy7H5JW3
	SqskYzMHGqag3a1GbV7i3y6xkes/k+m/V/ow==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uNvXo-00000002GG3-111a; Sat, 07 Jun 2025 17:33:16 +0200
Received: from p5b13afe4.dip0.t-ipconnect.de ([91.19.175.228] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uNvXn-00000003fZb-49FC; Sat, 07 Jun 2025 17:33:16 +0200
Message-ID: <878859a81e32c216669a9f80a6c30eaf83be5a9d.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.16
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Huth <thuth@redhat.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>,  Mike Rapoport <rppt@kernel.org>, Rich Felker
 <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,  linux-sh
 <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Date: Sat, 07 Jun 2025 17:33:15 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

this is my pull request for v6.16 which contains one fix and two code clean=
ups.

The first patch by Thomas Huth replaces the __ASSEMBLY__ with __ASSEMBLER__=
 macro
in all headers since the latter is now defined automatically by both GCC an=
d Clang
when compiling assembly code.

The second patch by Geert Uytterhoeven sets the default SPI mode for the ec=
ovec24
board which became necessary after a new mode member as added to the sh_msi=
of_spi_info
struct in cf9e4784f3bde3e4 ("spi: sh-msiof: Add slave mode support").

Finally, the third patch by Mike Rapoport removes unused variables in the k=
probes
code in kprobe_exceptions_notify().

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8=
:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.16-tag1

for you to fetch changes up to 8a3682601ddaa4ef0c400f627a7f4b9388bbccef:

  sh: kprobes: Remove unused variables in kprobe_exceptions_notify() (2025-=
06-07 15:16:41 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.16

- sh: kprobes: Remove unused variables in kprobe_exceptions_notify()
- sh: ecovec24: Make SPI mode explicit
- sh: Replace __ASSEMBLY__ with __ASSEMBLER__ in all headers

----------------------------------------------------------------
Geert Uytterhoeven (1):
      sh: ecovec24: Make SPI mode explicit

Mike Rapoport (1):
      sh: kprobes: Remove unused variables in kprobe_exceptions_notify()

Thomas Huth (1):
      sh: Replace __ASSEMBLY__ with __ASSEMBLER__ in all headers

 arch/sh/boards/mach-ecovec24/setup.c          |  1 +
 arch/sh/include/asm/cache.h                   |  4 ++--
 arch/sh/include/asm/dwarf.h                   |  6 +++---
 arch/sh/include/asm/fpu.h                     |  4 ++--
 arch/sh/include/asm/ftrace.h                  |  8 ++++----
 arch/sh/include/asm/mmu.h                     |  4 ++--
 arch/sh/include/asm/page.h                    |  8 ++++----
 arch/sh/include/asm/pgtable.h                 |  4 ++--
 arch/sh/include/asm/pgtable_32.h              |  8 ++++----
 arch/sh/include/asm/processor.h               |  4 ++--
 arch/sh/include/asm/smc37c93x.h               |  4 ++--
 arch/sh/include/asm/suspend.h                 |  2 +-
 arch/sh/include/asm/thread_info.h             | 10 +++++-----
 arch/sh/include/asm/tlb.h                     |  4 ++--
 arch/sh/include/asm/types.h                   |  4 ++--
 arch/sh/include/mach-common/mach/romimage.h   |  6 +++---
 arch/sh/include/mach-ecovec24/mach/romimage.h |  6 +++---
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |  6 +++---
 arch/sh/kernel/kprobes.c                      |  4 ----
 19 files changed, 47 insertions(+), 50 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

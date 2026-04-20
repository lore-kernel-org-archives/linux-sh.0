Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D8D3A0B2E;
	Mon, 20 Apr 2026 12:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689860; cv=none; b=eglOYPxQmgeZZdhtaQx9AmjmWGrkHraoUTAmge/Shr5HXlz2L1p8soArCRMcbl0jr4oCNE4r68uHOyjX9VULgQJKvcESBV6PW6LCoY7yQ9xrzBpxeyRW7vvFbDrwjm/v10XiE7Jj004FOcxCRWHTClglTYZbvHLpGg+lF7c1r4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689860; c=relaxed/simple;
	bh=Zjket3ohV83Rl+wEGw0FbgZm5yvBWMvRoUsi5ntbvLM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=ovo6APkfjdj7bicFmz/bfVzYxl3lEE2lLdVd7WgDpc/Me0h6LnHgz3QPYj70dpq34PnM3xIrIfC3yZSgMdTMZ1/IGdtALi4osr8P986G1TFmUiFXrm/SnPIXhYUUBk0khAycwd6Cl3HOolfEYZ5WlbEj8MfbzgG0utNbdWrvs7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=GPa0oC6h; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="GPa0oC6h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=cdjRzU/Fwv8mMjWBkd52WYLa/rrNl9J1u0P7F5nouJU=; t=1776689855; x=1777294655; 
	b=GPa0oC6h6BOxzxD0QK8ripJXlUMW5OYl2cEy60EOHfDkj+MDbXh+3q9JghsSva25F61YZVE6N7M
	EQ8UZeK/dlBjTZQC7tdXqYAMAS7cMYbgrOHFZNcsx47k/kIB9/znIt3AVy4q9zQmFQH3ltDN8KIjL
	CAOYhoN9ZHMpkELm1lu59hJ2S4djWPzryzivMYzuXiO+Hw6inbmZmXnUZZUcLLH52L/zrwThatveq
	eDB5HL+VDA0jnmCyMI1LKxE+fis0q5V65zrdoPkpRoUIMEWqDmJm3GsCS+Yx/W9KXbYUXsNck5jmE
	CV1sOJcDclZq9LcIHYIzZ5xCs/5uF1lwrcQg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wEoBv-00000000YQ7-1AdK; Mon, 20 Apr 2026 14:57:31 +0200
Received: from dynamic-089-012-084-148.89.12.pool.telefonica.de ([89.12.84.148] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wEoBv-00000002S8o-0F2d; Mon, 20 Apr 2026 14:57:31 +0200
Message-ID: <6fd0b00bde4213ae0006a98f517212a7803f69fc.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v7.1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Tim Bird <tim.bird@sony.com>, 
 Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	 <thomas.weissschuh@linutronix.de>, Rich Felker <dalias@libc.org>, 
 "<ysato@users.osdn.me>"
	 <ysato@users.osdn.me>, linux-sh <linux-sh@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Mon, 20 Apr 2026 14:57:30 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

after skipping some kernel releases, I'm back with a pull request for v7.1 =
which contains
four patches. Two patches from Thomas Zimmermann, one by Tim Bird and one b=
y Thomas Wei=C3=9Fschuh.

The first patch by Thomas Zimmermann adds a missing include in dac.h for SH=
-3 which became
necessary after 243ce64b2b37 ("backlight: Do not include <linux/fb.h> in he=
ader file") which
made __raw_readb() and __raw_writeb() inaccessible in dac.h. Thomas' second=
 patch drops
CONFIG_FIRMWARE_EDID for SH as it depends on X86 or EFI_GENERIC_STUB which =
are not defined
on SH for obvious reasons.

The patch by Tim Bird fixes just a small typo in two SPDX ID lines which he=
 stumbled over by
accident.

And, least but not last, the patch by Thomas Wei=C3=9Fschuh removes the CON=
FIG_VSYSCALL reference from
UAPI. This was necessary as the definition of AT_SYSINFO_EHDR was gated bet=
ween CONFIG_VSYSCALL to
avoid a default gate VMA to be created. However that default gate VMA was r=
emoved entirely in commit
a6c19dfe3994 ("arm64,ia64,ppc,s390,sh,tile,um,x86,mm: remove default gate a=
rea").

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f=
:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v7.1-tag1

for you to fetch changes up to 647b43f65357673a9ee4fe8a99247a7549bdb368:

  sh: Drop CONFIG_FIRMWARE_EDID from defconfig files (2026-04-18 10:23:23 +=
0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v7.1

- sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
- sh: Remove CONFIG_VSYSCALL reference from UAPI
- sh: Fix typo in SPDX license ID lines
- sh: Include <linux/io.h> in dac.h

----------------------------------------------------------------
Thomas Wei=C3=9Fschuh (1):
      sh: Remove CONFIG_VSYSCALL reference from UAPI

Thomas Zimmermann (2):
      sh: Include <linux/io.h> in dac.h
      sh: Drop CONFIG_FIRMWARE_EDID from defconfig files

Tim Bird (1):
      sh: Fix typo in SPDX license ID lines

 arch/sh/configs/dreamcast_defconfig  | 1 -
 arch/sh/configs/hp6xx_defconfig      | 1 -
 arch/sh/configs/se7343_defconfig     | 1 -
 arch/sh/configs/se7780_defconfig     | 1 -
 arch/sh/drivers/platform_early.c     | 2 +-
 arch/sh/include/asm/platform_early.h | 2 +-
 arch/sh/include/cpu-sh3/cpu/dac.h    | 2 ++
 arch/sh/include/uapi/asm/auxvec.h    | 6 +-----
 8 files changed, 5 insertions(+), 11 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F714B082
	for <linux-sh@vger.kernel.org>; Tue, 23 Jul 2024 08:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721723348; cv=none; b=McileL7fNZHn9K7ymSgi+uXsqCQbL2xqlhA5wkCZ/e7gnewq+xOdLtyuVWnqVQuiDNwnLV9ASYQD9qFgAO/ILah7yYy7gX4w4KklQxsYevbkjyOcR/enf/jiNYFJQCViaQc1dTEI5TQkfZk5OcUpc4spE7u3gQwvR/G/dg2e3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721723348; c=relaxed/simple;
	bh=sOdyJObdIYM75Z8CvydTybkoQXU3vc4PCOmj/wQLEgs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=j9jPJexRb//i4wiygxXKICLDB9UQ8Nj/1K5+s9VXTVQJ1MfU9cmFvAOtLM+IAOfZqDPjEWgVBGBK/NffWOMSvMb6MaF2YeYMpyVB8UzvoR0+0y0zrqhXcJ37yjmszmu0hd122w25kTDK9qEjGVRU5PHEPaB4YeDYyxFwJE5SZdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=I1txTEX5; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="I1txTEX5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZOHOwdhqfhi2jUesVsQnc+Z+W82ysKIfaShgvMR7/aA=; t=1721723344; x=1722328144; 
	b=I1txTEX5GEOA8QFOmsTDjdr7RcJ7cY7UCN2FdrHuPSFORiKR0dFvSZOCq/mT3u+Vh3IABgJ1YD+
	RWH90LJ5jgNAoe7lWBITn3djqrID84yWu2rgQOQGR7+JWfYckV2mrdxDk8UcQgNJw7+vB1QnzggXn
	/XAfATgSZyynR/oPWfOSVc2iv0TamUrXnLsGvgJDBH/6+wOmb79ynuSU3BQkCfPu30+JyAqF47kx7
	voE+sIcGgvoSzdkOgWBNBXntlmCgm3kfiFztk91gc3GtFV9yWZCfYIExZlt+ZJ7zydUUgBtWHtTKV
	pzBrycHK4CWJizKcsNUhahO9vNu4AhO7cfgw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sWAtJ-000000030c8-01Bw; Tue, 23 Jul 2024 10:29:01 +0200
Received: from dynamic-089-012-111-099.89.12.pool.telefonica.de ([89.12.111.99] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sWAtI-00000003gDT-3NRS; Tue, 23 Jul 2024 10:29:00 +0200
Message-ID: <285ec5d64bc9ce8a8aef6d1f3f81c00da587584f.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.11
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Oscar Salvador
 <osalvador@suse.de>,  Rich Felker <dalias@libc.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>
Date: Tue, 23 Jul 2024 10:29:00 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

my pull request with sh updates is rather small this time and contains just=
 three
changes. The first change by Oscar Salvador drops support for memory hotplu=
g and
hotremove for sh as the kernel stopped supporting it on 32-bit platforms si=
nce
7ec58a2b941e ("mm/memory_hotplug: restrict CONFIG_MEMORY_HOTPLUG to 64 bit"=
), this
includes a follow-up change to update all affected KConfig and config files=
. The
third change comes from Jeff Johnson which adds the missing MODULE_DESCRIPT=
ION()
macro to the push-switch driver.

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0=
:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.11-tag1

for you to fetch changes up to 0c5e964dad29aff321d4c006193d45d292756165:

  sh: push-switch: Add missing MODULE_DESCRIPTION() macro (2024-07-16 17:52=
:36 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.11

- sh: push-switch: Add missing MODULE_DESCRIPTION() macro
- sh: Kconfig: Drop CONFIG_MEMORY_{HOTPLUG,HOTREMOVE}
- sh: Drop support for memory hotplug and memory hotremove

----------------------------------------------------------------
Jeff Johnson (1):
      sh: push-switch: Add missing MODULE_DESCRIPTION() macro

Oscar Salvador (2):
      sh: Drop support for memory hotplug and memory hotremove
      sh: Kconfig: Drop CONFIG_MEMORY_{HOTPLUG,HOTREMOVE}

 arch/sh/Kconfig                     |  2 --
 arch/sh/configs/apsh4ad0a_defconfig |  2 --
 arch/sh/configs/sdk7786_defconfig   |  2 --
 arch/sh/configs/shx3_defconfig      |  2 --
 arch/sh/drivers/push-switch.c       |  1 +
 arch/sh/mm/Kconfig                  |  4 ----
 arch/sh/mm/init.c                   | 28 ----------------------------
 7 files changed, 1 insertion(+), 40 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

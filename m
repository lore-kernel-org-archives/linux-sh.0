Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2E1CA81
	for <linux-sh@vger.kernel.org>; Sun,  6 Apr 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743927807; cv=none; b=l7MczXLAxP+1QNC0tqWHfuyMnYa8udpvvlunK8uyjizHx1N1jqCR90vdPOzfE2E/GSjAMgj1r4k+kIlTRaFyNYpx4r0V/ExRTl2rVBVksTI6GOKAJ37kPcAw/LzTQSIAwu7g3WrBoR3Iw6pM5y/CME7BCunlwPpb2YkVgB+ZXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743927807; c=relaxed/simple;
	bh=RuwLPaaZsx7pKCC5UVsvtAw5drPL1oY5Z023SfeqPd4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WhAWyijmkaahlis0CNmBwjfF6gLoJypTQBQvk4ULNPajiMuw3tIHwL1wRTRaY3LCusfeqWaZioG8lXwg1lHRCOJg6zjinsipmzoU6Si1geppCA5S7hwAJ1bzLp4zwXBtOjk4PO4GCnsjN0Tr52JSRK1Nv+MCbX8OJlpSAKnpdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=fv/lYuBe; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="fv/lYuBe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LXM0M37RqHWGT0yEZylfip6+Ws/m8msgBTxl/DHup7s=; t=1743927803; x=1744532603; 
	b=fv/lYuBepaKkD+YnoToGf7WNy3SnlGqsbWCIMaiw9a8NkvMwkQINx3Uz1cbkTV+da4eb3GrZgxF
	hk0CWv0o0OxkuOJdX5zkr2d38J/v09ANb0gka36ApMx2fk3ZV/d1HqylDQUtIOwOy0IIEd7jth3vh
	AeJ+HOVM+IcHrYkRhZaOIgc8H93xWgMQQ3NgBMaL9iqJpdl1Xu2z4VnH4EcAls9Cbrw3Qc4hrsCFm
	R7Ofw74vx+gUJN60i/Pn57/Syo/o3ykHHuuoauOp8sH5KkTBPtbjkQ6evLvRexvuxF4frDTpcsmEZ
	C2Zeckp3ZKPIaMjCEsrv0aHTg7VPlkO9ITBg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u1LH9-000000043My-1y8L; Sun, 06 Apr 2025 10:22:43 +0200
Received: from dynamic-092-224-170-221.92.224.pool.telefonica.de ([92.224.170.221] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u1LH9-00000002TCL-15jd; Sun, 06 Apr 2025 10:22:43 +0200
Message-ID: <9c7331defe8b6991bf7f00a7d5e565d6c6784f56.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.15
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Artur Rojek <contact@artur-rojek.eu>, Johan Korsnes
	 <johan.korsnes@gmail.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>
Date: Sun, 06 Apr 2025 10:22:42 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

this is my pull request for v6.15 which contains one important fix and
one small configuration update. The first patch by Artur Rojek fixes an
issue with the J2 firmware loader not being able to find the location of
the device tree blob due to insufficient alignment of the .bss section
which rendered J2 boards unbootable.

The second patch by Johan Korsnes updates the defconfigs on sh to drop
the CONFIG_NET_CLS_TCINDEX configuration option which became obsolete
after 8c710f75256b ("net/sched: Retire tcindex classifier").

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b=
:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.15-tag1

for you to fetch changes up to 5f2efd67a17e5f4e2fccdb86014efaf8725f57a7:

  sh: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX (2025-04-05 19:46:38 =
+0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.15

- sh: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX
- sh: Align .bss section padding to 8-byte boundary

----------------------------------------------------------------
Artur Rojek (1):
      sh: Align .bss section padding to 8-byte boundary

Johan Korsnes (1):
      sh: defconfig: Drop obsolete CONFIG_NET_CLS_TCINDEX

 arch/sh/configs/se7712_defconfig       |  1 -
 arch/sh/configs/se7721_defconfig       |  1 -
 arch/sh/configs/sh7710voipgw_defconfig |  1 -
 arch/sh/configs/titan_defconfig        |  1 -
 arch/sh/kernel/vmlinux.lds.S           | 15 ++++++++++++++-
 5 files changed, 14 insertions(+), 5 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

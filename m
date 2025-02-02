Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542101581F0
	for <linux-sh@vger.kernel.org>; Sun,  2 Feb 2025 09:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738490001; cv=none; b=KYNZcC1Mu1c/L1I3KGn/9KeEynxfo4AuBD7N/CPafXaFedwb5cGWDWYp82gBwBJDk2iDb3e4oBtbTD9bKS5VjJ2ydfUS5peggqzNIvEivhY0SRrE8DBd9VHsd2v5MW42S9uvS1xWzSA/x1Z/FXoYzreAZgB+6VVDnV+Sx5nMbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738490001; c=relaxed/simple;
	bh=x6e/kf/eLyVHz+VB4T0xZ5Juxw1JzmwYSp9flgFSXLk=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=khE0G2r68JFVwyErHZ0mbGWqWxZn/uSYDKTIKRSKywjdMpBnxgVc1aHfA45/N6no8ZWylsQ92LYGkEFTPj+8JuPQ7qc07rigHJNL33ZwUixDmi59fUrI0lrSHITnatUuT79j1NhHZQXruRtSemY6ekmIWJngH74TzGq6pvqXgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=F87QC0DZ; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="F87QC0DZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ElZPPtVl/NCb/kXNAmWsr5oYLYtZJiorUGRVqtipmnw=; t=1738489998; x=1739094798; 
	b=F87QC0DZ6/15B5+iS3+AX3T+jxbigBKqKVToMIlMz7sjkY1iH0ZDHKGLHToKUUgzttor3WncTDn
	GpBqvceFGhBu9KUB3UDH90L1ocNVaN5VLsw+ZFehHW7GPXKpO9iGnfc3tGs9MaW5w0kPbE0XGpe64
	BLBJgF3KbrXq03XqPnxRrljMEXASFa9V/Aklepy19yAFnuKzqJhTW0nw1+J3DLSc887LUI0/eSnnU
	WinEp+iGrEScTKgFEsPaNgLnrCuFQ9GIH8Vi7j4gJYuIAHtKDgPRM5FjPgoKbqOhgF4h9zOY5JriK
	pGKg3WMZOmrYYAr9hPjNYRVMNAET0etmZ40w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1teWf6-00000000oKw-1haJ; Sun, 02 Feb 2025 10:53:08 +0100
Received: from [151.216.131.255]
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1teWf6-00000003tcA-0gzv; Sun, 02 Feb 2025 10:53:08 +0100
Message-ID: <e69caa6dbc35338b2aa898b3647985823e0548ea.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.14
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, David Wang <00107082@163.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Yoshinori Sato	 <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>
Date: Sun, 02 Feb 2025 10:53:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

this is my pull request for v6.14 which contains three fixes and improvemen=
ts
for sh. The first patch by David Wang replaces seq_printf() with the more
efficient seq_put_decimal_ull_width() to increase performance when stress
reading /proc/interrupts.

The second patch by Masahiro Yamada migrates sh to the generic rule for bui=
lt-in
DTB to help avoid race conditions during parallel builds which can occur be=
cause
Kbuild decends into arch/*/boot/dts twice.

And, finally, a patch by Geert Uytterhoeven replaces select with imply in t=
he
boards Kconfig for enabling hardware with complex dependencies. This addres=
ses
warnings which were reported by the kernel test robot.

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37=
:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.14-tag1

for you to fetch changes up to 909f3c55d887a9f9d4cd2762813cbfcaf640ec57:

  sh: boards: Use imply to enable hardware with complex dependencies (2025-=
02-01 10:44:06 +0100)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.14

- sh: boards: Use imply to enable hardware with complex dependencies
- sh: Migrate to the generic rule for built-in DTB
- sh: irq: Use seq_put_decimal_ull_width() for decimal values

----------------------------------------------------------------
David Wang (1):
      sh: irq: Use seq_put_decimal_ull_width() for decimal values

Geert Uytterhoeven (1):
      sh: boards: Use imply to enable hardware with complex dependencies

Masahiro Yamada (1):
      sh: Migrate to the generic rule for built-in DTB

 arch/sh/Kbuild            | 1 -
 arch/sh/Kconfig           | 7 ++++---
 arch/sh/boards/Kconfig    | 4 ++--
 arch/sh/boot/dts/Makefile | 2 +-
 arch/sh/kernel/irq.c      | 4 ++--
 arch/sh/kernel/setup.c    | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

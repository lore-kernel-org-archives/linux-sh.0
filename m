Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819141EEA3C;
	Wed, 30 Jul 2025 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753860924; cv=none; b=OP9UJxd5IOH81EbPB0YynGJF5RPI390WvUfgXa/XFPori5ZSytlE+90gGGBUW88ZLDCVDlOBedMPG3jYaHSG2stJoCh337Uk+0tRwuuOaUWycuayasc+TUjSPZOslB5jVWAUkk59kXLUbkhMp9ItUarsn87nq1yXiGVP1Bzuq9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753860924; c=relaxed/simple;
	bh=VlXnZibtdmdKimqu6qXZyu/DjzJ+xUxz1yDOIaJW3z4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=TsbVL/JS3mS5xTS9tsSjTtHrweb/l8xutSzf25Z8Rm1lzLldwMvFqNDMH54IjwfW3XLqe1ycSPwIQJ3ke5+BSWYYq7DMsGv8NaDTJrVIqdnm6M+BjMyrw4i7cy6vZtKab1StuDTcDDQQj0iPSe+DUuZmcmzGesw5OzBA68VvopA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=O7aANDc9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="O7aANDc9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jzhbZhe6tjjT85IYcBPClShujk44zmFvIfzzOCZVjl8=; t=1753860920; x=1754465720; 
	b=O7aANDc9KjSkZIR+A+P6kxJ+PHdaFItE/dDC2QVDNcSlu8j//twHpCCvEXo0a4Xhh79tEybG+W1
	McrH3z8TdF/6FEVrpvZ/gFnwKeHBZIwbMXRRWP07D6DWi+4vCakb7Kopy8x3ACgFBT7I+1Y7YQmRk
	oyfXO++EscT1vhvIOLcyo9nxWUwZwstuJSqDpU6LEQeboDjTL/qXdiZaN9crKSyUaD3baOVhDAxpw
	FCfSCbfI9HUwAi5nrODYfg3zknAciHrd3r+/uLVDZjtHosn177QRBhLFNfQESWKfqWRrTLvRTf4Ux
	OSRprA6hDJkMaDOdcSRXTmYw0vZk18cmqKfA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1uh1LB-00000003x53-2PLV; Wed, 30 Jul 2025 09:35:09 +0200
Received: from dynamic-002-242-133-026.2.242.pool.telefonica.de ([2.242.133.26] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1uh1LB-00000001ACF-1Udf; Wed, 30 Jul 2025 09:35:09 +0200
Message-ID: <949b52e4e97f7531cd5f40d13e7689ae7768cde3.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.17
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ben Hutchings <benh@debian.org>, Rich Felker <dalias@libc.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh
 <linux-sh@vger.kernel.org>, linux-kernel	 <linux-kernel@vger.kernel.org>
Date: Wed, 30 Jul 2025 09:35:08 +0200
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

this is my pull request for v6.17 which contains just one patch.

The patch Ben Hutchings replaces the hyphen in the exported variable ld-bfd
with an underscore to avoid issues with certain shells such as dash which
do not pass through environment variables whose name includes a hyphen.

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v6.17-tag1

for you to fetch changes up to c32969d0362a790fbc6117e0b6a737a7e510b843:

  sh: Do not use hyphen in exported variable name (2025-07-26 17:15:41 +020=
0)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.17

- sh: Do not use hyphen in exported variable name

----------------------------------------------------------------
Ben Hutchings (1):
      sh: Do not use hyphen in exported variable name

 arch/sh/Makefile                 | 10 +++++-----
 arch/sh/boot/compressed/Makefile |  4 ++--
 arch/sh/boot/romimage/Makefile   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

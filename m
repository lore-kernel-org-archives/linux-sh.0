Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10123A562;
	Sun,  3 May 2026 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777820552; cv=none; b=MWCA/8hCNUe7B4rEJQSii3pACGlAodXPVN9pWWWCWqOm4eewbyzyDoRr7HmdLQwfY82jU3nH+74vcsi/jJAj/DxTTU/hkxM3KeZI6WjMjAfpz6SRxGQl/UQyNGDVoau6m+lM2xz9ZEEi4DmxV/zM22sTL5zbkDByii79WlkmpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777820552; c=relaxed/simple;
	bh=qMqFmwNYSnxXOE4/RBM3i2a4enFJvs56nQ219Js1i3E=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=M5/Vk8FrK/Rictatn5Tj4OAertwRdSBzehMK5ESY81p/U8ImbGRIZ8uoIX+kWTlWX5Kt/pOvlZWvG84sB4ykRCjXwMUEZqa2KJ9HA6j7KnenxixAYhg2tRczxv6VJ5/rijHiS9qvOLFjPsdioKtft1154pohqDqBf/hb58EumCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=LX2ICIIV; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="LX2ICIIV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=w4+a3Jb0XFNGsLt0TQ+OJDaayqvEOWothhdFXA8orGQ=; t=1777820550; x=1778425350; 
	b=LX2ICIIVBUH4+wRHqaj826jgOxgHRH8n3JtKqVzQCgiJgfkF8mxwjq7zYbiqR/2kPB0BqQvj9P1
	0pGdhfR59PNnCbs2Pi8+rmVFHGz0bsb8H7MVBTR4CoUucUZKrCkSuACAF994nN0n1FmHt9/YwehQn
	WtS3QbeFyVhypni1u3G1J9m4DRrSSdwQNKR9Et1yXJGTW74ngObxPTKJq36ALVIF0ypvRMwOVzyDJ
	h/HbVOrHPGYJmnohKOzvj+OU2bqMrbPBnTqbtsksHwvQb16F3uPQap5jSC3Wy1rbrX2n3cYG8FUdH
	ZUsQjuUMeXUtjSAAtuy6Gis/kmc8sj/CmkDQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wJYKy-00000002qFk-1LE4; Sun, 03 May 2026 17:02:28 +0200
Received: from dynamic-077-183-073-066.77.183.pool.telefonica.de ([77.183.73.66] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wJYKy-00000003neT-0RXc; Sun, 03 May 2026 17:02:28 +0200
Message-ID: <052fc1373d143466c745b01b4803cae950cca6af.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh fixes for v7.1
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>, Rich Felker
 <dalias@libc.org>,  Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh
 <linux-sh@vger.kernel.org>, linux-kernel	 <linux-kernel@vger.kernel.org>
Date: Sun, 03 May 2026 17:02:27 +0200
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

the memory management changes in v7.1, in particular the ZERO_PAGE consolid=
ation,
introduced a regression on sh which made these systems unbootable. The prob=
lem was
that on sh, the initial boot parameters were previously referenced as an ar=
ray and
after 6215d9f4470f ("arch, mm: consolidate empty_zero_page"), they were ref=
erenced
as a pointer which caused wrong code generation and boot hang. The patch ch=
anges the
declaration back to being an array which fixes the boot hang.

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731=
:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/=
sh-for-v7.1-tag2

for you to fetch changes up to b0aa5e4b087b686575f1b31ce54048b4d059b7b8:

  sh: Fix fallout from ZERO_PAGE consolidation (2026-05-03 16:35:40 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh fixes for v7.1

- sh: Fix fallout from ZERO_PAGE consolidation

----------------------------------------------------------------
Mike Rapoport (Microsoft) (1):
      sh: Fix fallout from ZERO_PAGE consolidation

 arch/sh/include/asm/setup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

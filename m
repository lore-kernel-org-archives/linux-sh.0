Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C91C36
	for <linux-sh@vger.kernel.org>; Fri,  5 Apr 2024 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354875; cv=none; b=tSoTJJqGnLCHhxrHfZZCcV/sIslVhSsr15Vmbr+o2WdyvQSHoSJ/pTZ2Ess5WcHb7UJDs81sUIWz8NPAaLTsgkN20h5WsBQFor5NO/gOg8XAgOqCR/mTw6/QXJXEKS04Fupura3MMZVT6OBNP4/ZGRwHBO9qJv5P0tGbJZO5t3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354875; c=relaxed/simple;
	bh=ywhkUPsgb1Z6X5RaX9OOQCFbKwUSgRbi1k4Sk6712qg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jYsQDhWbNSbyyrhvZh9lmaXm366FaZ471EAc49NWeZdLYip/me/ux125DUTWMH9kNxQ/UcPpnyFGbkHbrb/coSh85NFxViwW4F/4GYUGPRnyPYiSPbXUrdGjoG5Om7b2KwSkDIkTJaWmLR9pA6KD7+oq/Jhl10QRGDUAeLgupbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MIAVFMsx; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MIAVFMsx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j62RtguUf/iuOC/F02f9UHfxhcBN6q/wdoWR1aizqZE=; t=1712354872; x=1712959672; 
	b=MIAVFMsxk84JY5dvUI9As9mCahAsI/8HpFgMY2sTwttUlp9LAwt85urdm+iXQg2lEK5nP90CvKN
	dzghXMVBKFNVFad3qMCe4ZCcen8NQCZHuqSEWdoY3WrV2ysl3KQS+Lokd2/wW7FxCMC85EdXdGA0o
	n1to0naIqesDUuLq5kVar+DiPkJgAxCaKe3wVHk/Md8Er2nLhD6M13d+nlvvko5TZXeBCZGfzNYrp
	GAviX6MXyqSBSwEW7jkc/CHvF4MhTTV3jcvjerBuZfcxxK1xhXM1p8yLeR9wrW8ZpDCkbbVqBEkMn
	YuydbZrcKa3WsXIO6LGtHaJQ74pgtx8vXPWA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1rsriw-000000026cG-0mKX; Sat, 06 Apr 2024 00:07:50 +0200
Received: from dynamic-089-014-127-029.89.14.pool.telefonica.de ([89.14.127.29] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1rsriv-00000002Sg6-47N6; Sat, 06 Apr 2024 00:07:50 +0200
Message-ID: <bd3ddd0d0fa911dbefdfb89ca26e3f79c98898dd.camel@physik.fu-berlin.de>
Subject: Re: [RESEND v7 00/37] Device Tree support for SH7751 based board
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list
	 <linux-sh@vger.kernel.org>
Date: Sat, 06 Apr 2024 00:07:49 +0200
In-Reply-To: <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
	 <e5f6a857-1296-e110-a3b2-c05d08522371@landley.net>
	 <CAMuHMdWL0aHmZS7NuZO5AUhn=zmNDG+fPZzmG--DyZr-LFwZ-Q@mail.gmail.com>
	 <aebc1db5-5c3e-dafe-0c35-7d0a4ed4d885@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

On Fri, 2024-04-05 at 13:57 -0500, Rob Landley wrote:
> $ b4
> bash: b4: command not found
> $ aptitude show b4
> E: Unable to locate package b4
> $ aptitude search b4
> p   b43-fwcutter                    - utility for extracting Broadcom 43x=
x firmw
> ...

glaubitz@z6:~> dpkg -S `which b4`
b4: /usr/bin/b4
glaubitz@z6:~> apt show b4
Package: b4
Version: 0.12.0-2
Priority: optional
Section: python
Maintainer: H=C3=A9ctor Or=C3=B3n Mart=C3=ADnez <zumbi@debian.org>
Installed-Size: 373 kB
Depends: python3-dkim (>=3D 1.0.5), python3-dnspython (>=3D 2.1.0), python3=
-requests (>=3D 2.24.0), python3-patatt (>=3D 0.6.3), git-filter-repo (>=3D=
 2.30), python3:any
Homepage: https://git.kernel.org/pub/scm/utils/b4/b4.git
Download-Size: 76.6 kB
APT-Manual-Installed: yes
APT-Sources: http://ftp.debian.org/debian bookworm/main amd64 Packages
Description: helper utility to work with patches made available via a publi=
c-inbox archive
 This is a helper utility to work with patches made available via a
 public-inbox archive like lore.kernel.org. It is written to make it
 easier to participate in a patch-based workflows, like those used in
 the Linux kernel development.
 .
 This package installs the application and library for Python 3.

glaubitz@z6:~>

Alternatively, install it via pip:

glaubitz@z6:~> pip install --user --break-system-packages b4

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

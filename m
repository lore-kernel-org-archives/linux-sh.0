Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029737267A
	for <linux-sh@vger.kernel.org>; Wed, 29 Apr 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448788; cv=none; b=JsBouaqOYSUGGlJXTbKxEiANKHbeBQ/y3JUHryjdla8rLuJRqPg1rauNfTJhnOGnyFbCrBW1iFVSi8+mJz/EB63XFrvhChJlrNIE7PommAqaVrsMavpttRlSEeITm2aw2tGDJKmlEzOZOd50UTR2em9OR5sEztCjjwuWWpztWNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448788; c=relaxed/simple;
	bh=lveUzSY/YcjYr88t9fX8xRS2jGNvx4Bmov6WHAzGeN4=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=XJ36plbeGPbHE5CapKvv5QYN+39rWahQyD7sbas6aoJ88Mpb8E2+jS9OR7ZI5L7ZIpWJSOCxJPK3cGFoJvN2p4TnoHfCzfjhzya30qKcPL+natlfsfo9WNpSOyZWRTilqhs4bTwS6adNh2aICqDbTDhHMnma9mL6HJGBH7oUB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=A4rTf+oX; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="A4rTf+oX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:Cc:To:From:Subject:Message-ID:From:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=2eDAP27Ji17b7MM5gB37ngYuh9/VAKMbEfnMzRAzjO4=; t=1777448784; x=1778053584; 
	b=A4rTf+oXf6CESgcFaUxqZBXisIJxZcDN0OFSB7ugU7SWCdzGcVW5F5nn22aMVv7NA06QdK7qu8t
	/8wITqUCbapizdfyhTL6ORP1JTHGv0M2hFRmgf5KcNrVd2UYZfUhqYr5X/ZFa57XrWljpUH9dqAIj
	FA6LHAtFFUsiXoFSLZ2goHLz6/dvHBSMs0Q0KB3ATohvQdmZ/ALCaFtA/dHRrcQ474MuE1oyR/1Ic
	zEKzhTIphTDrqtdIhT34ZCfATJkM7DmHt1EA2hdzwRNE7GSy9y7oPYN2FX5bRMK+lSBRjTfUBJFGX
	P9mACz6yi32qjqMVCdbjfc7UHR0NnHsEsDUw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wHzck-00000003Tyx-0Mrg; Wed, 29 Apr 2026 09:46:22 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wHzcj-00000000Q91-3fI5; Wed, 29 Apr 2026 09:46:22 +0200
Message-ID: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
Subject: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>
Cc: linux-sh <linux-sh@vger.kernel.org>, Geert Uytterhoeven
	 <geert+renesas@glider.be>
Date: Wed, 29 Apr 2026 09:46:21 +0200
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

Hi Rob,

I'm trying to build a new root image after updating Toybox but that no long=
er works:

glaubitz@node54:/data/home/glaubitz/toybox> make root CROSS=3Dsh2eb-linux-m=
uslfdpic- LINUX=3D/data/home/glaubitz/sh-linux
mkroot/mkroot.sh  -- LINUX=3D/data/home/glaubitz/sh-linux CROSS=3Dsh2eb-lin=
ux-muslfdpic-
No ccc symlink to compiler directory.
make: *** [Makefile:108: root] Error 1
glaubitz@node54:/data/home/glaubitz/toybox>

It asks me to create a "ccc" symlink but I have no clue where that link is =
supposed
to point to. The FAQ says the link is supposed to =C2=BBpointing at a direc=
tory full of
cross compilers=C2=AB but I don't have that and that's not my personal setu=
p. I have the
cross compilers installed in my home directory and their bin directories ad=
ded to
the PATH variable which has always worked in the past without any problems.

Can you explain how that "ccc" symlink works?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

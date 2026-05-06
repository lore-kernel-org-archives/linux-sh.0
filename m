Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7D3EF0B7
	for <linux-sh@vger.kernel.org>; Wed,  6 May 2026 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092384; cv=none; b=UrwGkEvlckphoD1Xid9/7OppV8+Bsl4tzChJ49ACJ9S4VmJrBGu4X20/NbrYxgKAxUpeSTTElyD/oW14V17Be0AVPB3Z518fkd3z1dV63fKQw9liAc2tvKumvBOMVExp7Z1Vw0ueAHQJ/xJ0LPWnJ6M3Ro5VGb/U2CKgRKlGTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092384; c=relaxed/simple;
	bh=6F4QKf9mE8uyaPsN6gaDY0Ek8hqXmbtn5kvfGAlxwk4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FF3TYgk+zb8D+vXELjDP/l3hx0ISYZzFJXllSjiUw1CnC4rh+xd3ai4dQiNLhfrmUfHi3Wmh6wK7royg93d5NM4WsISsZq/W31C3lrGG5ZGhXPEbFepzGkRkdzgvonQfrTCPcxPDck11nFLDyfeM6b0BOm2lys5r+wmJ4H3eNPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a03:2267:2:0:b9c2:3755:da0:52dd] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1wKh3B-001PzO-09;
	Wed, 06 May 2026 18:32:49 +0000
Received: from ben by deadeye with local (Exim 4.99.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1wKh39-0000000Cpvf-1A6f;
	Wed, 06 May 2026 20:32:47 +0200
Date: Wed, 6 May 2026 20:32:46 +0200
From: Ben Hutchings <ben@decadent.org.uk>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Subject: [PATCH] sh: uaccess: Handle exception on second instruction of
 __put_user_u64
Message-ID: <afuJTi1IGCgrK_cc@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ANLi5RjxS5YWnIiP"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a03:2267:2:0:b9c2:3755:da0:52dd
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--ANLi5RjxS5YWnIiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Each entry in the exception table only covers a single instruction,
but there are 2 instructions that could fault in __put_user_u64.

__get_user_u64 never had this bug.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I noticed and meant to fix this bug in 2019, but then the patch
lingered in a git branch since then.  Today I found and rewrote it to
match the way Adrian did the exception table for __get_user_u64.  I
have not tested this version at all, though.

Ben.

 arch/sh/include/asm/uaccess_32.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
index 5d7ddc092afd..26096258e43b 100644
--- a/arch/sh/include/asm/uaccess_32.h
+++ b/arch/sh/include/asm/uaccess_32.h
@@ -194,6 +194,7 @@ __asm__ __volatile__( \
 	".previous\n" \
 	".section	__ex_table,\"a\"\n\t" \
 	".long	1b, 3b\n\t" \
+	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	: "=r" (retval) \
 	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
@@ -216,6 +217,7 @@ __asm__ __volatile__( \
 	".previous\n" \
 	".section	__ex_table,\"a\"\n\t" \
 	".long	1b, 3b\n\t" \
+	".long	1b + 2, 3b\n\t" \
 	".previous" \
 	: "=r" (retval) \
 	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \

--ANLi5RjxS5YWnIiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmn7iUoACgkQ57/I7JWG
EQlvMQ/9Fz6BJMJ/uk1q4HXBbzgsgef41r3+VC/jJEaJOOxLpuqTrICBMaGF3bFn
fyAEOfKu43nVbiFZypzdnm9/4htDneO8832k/KC+dTvmeFs471KSb/zQqLg8rnsl
XwGgcHKqvyp3OEyoAFW1B1nUNv67D26RZiNqE9Vounfye37G6Vtw0ayusYvn4Gqu
xqNdrZasY5DZJDJTbg8QKZSKuojpD+r3Gbm4rhSvoSvooamB0YcjxLI+lNbxoHVU
3YNNc14PFnQjdO9tJ6N7lHTBq4LqtffAKy5Z5FMFS5NboB2+KbHSlK0EW25ITPmZ
aNLxd4UBDi2Lj9zzwuc02PZBt864vZH7Ekw61LyuJlLd0dvfuJeYXdzAZruOcOXh
aKdzJ30bQyUPOIvG16AChmHH+6CaDpGfpVy/s3Ih1sYS+pFKU/1XKPwWQH45f5fP
bjwxlFzL0j1mkShG0YRy3GdNs5rpfZnnXOKcR/la4MGs3ajGZBSE891GG3ABTSmJ
cDhzfyGbaIUeYLQWSbwc64iN1MrRhcyQ0sk+AMckYYWlgCOxs0izAi/Mlh1+57rR
KXh4QQMVejhdgi5ienxchj1k7PlI1g7WrrwXgQ7hXmdX42K/MNP2MN9WiPk9SI6i
aSLe8ivYdbUJI8Zm+KRyMMGCF7EpPlwzMpDRktFS3jr7jeRUPgA=
=QMqy
-----END PGP SIGNATURE-----

--ANLi5RjxS5YWnIiP--

Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08033FE7
	for <linux-sh@vger.kernel.org>; Thu, 17 Jul 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763663; cv=none; b=abRzfQHtv8xariEbeMTB6AxcQ0QvgbhRx2KBn/bXaPll/6XyeHM8SCM8KmvcHcBDsCKF1eJDJihs0fgeT67l2yV4ZGkSncdYGBFBvagvnIxNspZUas3ww5N5A358JN44Kej4OhBCk0acql44uGizVtAYsNzfCp0mMqiSOjZ1FFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763663; c=relaxed/simple;
	bh=sb6KIyuJM0nYU85bHUC76QsWVI45M0SLU24CjTMAK9g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MTG21kyjsjIFb+1owQhg+Oj/VXrygfrw5ruVfCYBwS/6nTgwwf9aScKL4oWM0EOm72sqfH4f1K4+Kb6l5KyHPzzbXoUwEBd1aCDNX8VF3WQh00gB683iwtH7OoPyTJH6RrAcZdRumpzsg7TOC5olefJ0mk1bSk7osC6BEhPNVfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:a020:54f:c8c1:c75b:a8a9:e239:376b] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1ucPtW-005qkD-0O;
	Thu, 17 Jul 2025 14:47:34 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1ucPtU-000000008DM-10AG;
	Thu, 17 Jul 2025 16:47:32 +0200
Date: Thu, 17 Jul 2025 16:47:32 +0200
From: Ben Hutchings <benh@debian.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Subject: [PATCH v2] sh: Do not use hyphen in exported variable name
Message-ID: <aHkNBHnFT68xvwjK@decadent.org.uk>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZNzIuhzsPNnY9O/f"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a02:a020:54f:c8c1:c75b:a8a9:e239:376b
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--ZNzIuhzsPNnY9O/f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

arch/sh/Makefile defines and exports ld-bfd to be used by
arch/sh/boot/compressed/Makefile and arch/sh/boot/romimage/Makefile.
However some shells, including dash, will not pass through environment
variables whose name includes a hyphen.  Usually GNU make does not use
a shell to recurse, but if e.g. $(srctree) contains '~' it will use a
shell here.

Other instances of this problem were previously fixed by commits
2bfbe7881ee0 "kbuild: Do not use hyphen in exported variable name"
and 82977af93a0d "sh: rename suffix-y to suffix_y".

Rename the variable to ld_bfd.

References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=3Ds=
h4&ver=3D4.13%7Erc5-1%7Eexp1&stamp=3D1502943967&raw=3D0
Fixes: 7b022d07a0fd ("sh: Tidy up the ldscript output format specifier.")
Signed-off-by: Ben Hutchings <benh@debian.org>
---
v2: Updated after the use of suffix-y was fixed separately.

v1 is archived at
https://lore.kernel.org/linux-sh/20170819213109.GJ18698@decadent.org.uk/

 arch/sh/Makefile                 | 10 +++++-----
 arch/sh/boot/compressed/Makefile |  4 ++--
 arch/sh/boot/romimage/Makefile   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sh/Makefile b/arch/sh/Makefile
index cab2f9c011a8..7b420424b6d7 100644
--- a/arch/sh/Makefile
+++ b/arch/sh/Makefile
@@ -103,16 +103,16 @@ UTS_MACHINE		:=3D sh
 LDFLAGS_vmlinux		+=3D -e _stext
=20
 ifdef CONFIG_CPU_LITTLE_ENDIAN
-ld-bfd			:=3D elf32-sh-linux
-LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64 --oformat $(ld-bfd)
+ld_bfd			:=3D elf32-sh-linux
+LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64 --oformat $(ld_bfd)
 KBUILD_LDFLAGS		+=3D -EL
 else
-ld-bfd			:=3D elf32-shbig-linux
-LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64+4 --oformat $(ld-bfd)
+ld_bfd			:=3D elf32-shbig-linux
+LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64+4 --oformat $(ld_bfd)
 KBUILD_LDFLAGS		+=3D -EB
 endif
=20
-export ld-bfd
+export ld_bfd
=20
 # Mach groups
 machdir-$(CONFIG_SOLUTION_ENGINE)		+=3D mach-se
diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/Mak=
efile
index 8bc319ff54bf..58df491778b2 100644
--- a/arch/sh/boot/compressed/Makefile
+++ b/arch/sh/boot/compressed/Makefile
@@ -27,7 +27,7 @@ endif
=20
 ccflags-remove-$(CONFIG_MCOUNT) +=3D -pg
=20
-LDFLAGS_vmlinux :=3D --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e startup=
 \
+LDFLAGS_vmlinux :=3D --oformat $(ld_bfd) -Ttext $(IMAGE_OFFSET) -e startup=
 \
 		   -T $(obj)/../../kernel/vmlinux.lds
=20
 KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
@@ -51,7 +51,7 @@ $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
=20
 OBJCOPYFLAGS +=3D -R .empty_zero_page
=20
-LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld-bfd) -T
+LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld_bfd) -T
=20
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
 	$(call if_changed,ld)
diff --git a/arch/sh/boot/romimage/Makefile b/arch/sh/boot/romimage/Makefile
index c7c8be58400c..17b03df0a8de 100644
--- a/arch/sh/boot/romimage/Makefile
+++ b/arch/sh/boot/romimage/Makefile
@@ -13,7 +13,7 @@ mmcif-obj-$(CONFIG_CPU_SUBTYPE_SH7724)	:=3D $(obj)/mmcif-=
sh7724.o
 load-$(CONFIG_ROMIMAGE_MMCIF)		:=3D $(mmcif-load-y)
 obj-$(CONFIG_ROMIMAGE_MMCIF)		:=3D $(mmcif-obj-y)
=20
-LDFLAGS_vmlinux :=3D --oformat $(ld-bfd) -Ttext $(load-y) -e romstart \
+LDFLAGS_vmlinux :=3D --oformat $(ld_bfd) -Ttext $(load-y) -e romstart \
 		   -T $(obj)/../../kernel/vmlinux.lds
=20
 $(obj)/vmlinux: $(obj)/head.o $(obj-y) $(obj)/piggy.o FORCE
@@ -24,7 +24,7 @@ OBJCOPYFLAGS +=3D -j .empty_zero_page
 $(obj)/zeropage.bin: vmlinux FORCE
 	$(call if_changed,objcopy)
=20
-LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld-bfd) -T
+LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld_bfd) -T
=20
 $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/zeropage.bin arch/sh/boot/zImage=
 FORCE
 	$(call if_changed,ld)

--ZNzIuhzsPNnY9O/f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmh5DPkACgkQ57/I7JWG
EQlHcQ/7B4o+ctM6UblLgI+QbBgJUKHzHTdmNgqS2r2DtIpVpGF7RiVb64eS/u3n
QiVHPUKA39+Rk7jDi9iQ8OcsmSuaRplhc7/LJ+ERFHyEJ36nl0eXoVRIVSMwSGSi
bQrXyLRmWaKCdegw8SfJV0xjZft7PP/FNWSs3b+aGDY/7AN15ulr+TzjKMAiCm/5
Ak9cAUaGOMu1f0TV6yUR+DP/Zfre+qsaz+lxjGP7GNcronJ6TjJxyCae0DJX6nfF
4+9NMP8h9rYPrtMmk9LwuE+w0HLW/Vbor8YryDHEAEA2wVVgoezDm+e9xRzaWCOd
DL34g7zYzZPrWp5Oy7U0UmD1Ob1WjduX9KAx0eAXYGtx6U169Pk8ObUBGip7wfNO
Z2Vqqs7DTk8yYt4vTRWrpN9TeVINUqsn9KaiQCelyWl8QlbOFC13XaionZd8Dz4f
43/HTxnJ5dol6foPG80Ukg5HQUFJMaEVbGGYXHkY0Y1hRXrIcujocYMWD7cel/Ly
xdwgZQKNwqJ3ziuww4u/quZ7tjSRuPhqRn280ycbqpWOo5qp5DXLWa9035O9+JZu
m0d7CM2+qfwscdGvoFM+U0ROzsYI38n1F+N/G3wynUZIODvH5Z1lfUnxlUGF+seU
TK0Szkrrzt1q326AM1OXd7ZEscnQHxZIUlg2sxgpjkDpWFLJSNU=
=XNTz
-----END PGP SIGNATURE-----

--ZNzIuhzsPNnY9O/f--

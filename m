Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19F32FA30
	for <linux-sh@vger.kernel.org>; Thu, 30 Apr 2026 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777532242; cv=none; b=kMGxVEbKbiZTVsHUDs2WJGKaxLZwYXA92dGI5L2yDkJ1fJAyTKvzxEqXt1WAX0CyzoNumU4PFkEhl1D6opyYNJp2ekWv3m9+Enlo07geKSBalXDvTFSdauZOKuuILaJ+TRNKoskBE5uivUqxObX/1OvtfMkVrzVBpZ6aov0DNp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777532242; c=relaxed/simple;
	bh=5UD0e6cJEX+wwJSwHRg+7EuBMLWWXil5kUPa3SoMHms=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XMch82BshDYo1mGLb6vxDNZODziNjXUU+K0EcB7PFt2w7MJL8dHYnfMxLL3KXp+tMaKl4DHnPVGKUH61yoehjTnUSYHnMJIVChRRYrDDi3YudhJt6BKTZblY/Lu+6FzTn9qiHs6H58HmkeT3qqrBKMIOTmgJW1ZiyjCbjhP1jUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=BkTHbxO7; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="BkTHbxO7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=eMtvGp12gD3p9mJ6Jw4IcXhfLdJ5ANf8Thq4sfB6rDQ=; t=1777532238;
	x=1778137038; b=BkTHbxO7g/TEvC2diKxPUgvf+7KQLiabuJdd8XT9Ut4HBST4ySAo5Vpzrf4av
	ct5T5FG6WRez+y2DbQheMUj4GQYc7Oo/NuINf6e74M5w7lTQ97+TSYnGVVCQNExJT+jGsYC2gO0xN
	oLKvWCmNJM0tMJ6tqV5mo1zSJytEONkXHX+4eD6xoIoCUWOUnSx3sN2n2KutbRvAh2UVRnnfMBBcP
	1FyfQr6qi+bny8g+hicS0oEvEPe9ePfjWCRrAGDO080RsDOjfXm7YCh/Rbr9zqiE0tWe9bz07jRix
	sQoGhoxkMMaFWmK0zEXjOs2xq3dBi9QnLch66UF52eOiquSv7Q==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wILKl-00000002QDW-2Qc0; Thu, 30 Apr 2026 08:57:15 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wILKl-00000000bPe-1Xex; Thu, 30 Apr 2026 08:57:15 +0200
Message-ID: <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
Subject: Re: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>
Cc: linux-sh <linux-sh@vger.kernel.org>, Geert Uytterhoeven
	 <geert+renesas@glider.be>
Date: Thu, 30 Apr 2026 08:57:14 +0200
In-Reply-To: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
References: 
	<359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
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

Hi,

On Wed, 2026-04-29 at 09:46 +0200, John Paul Adrian Glaubitz wrote:
> I'm trying to build a new root image after updating Toybox but that no lo=
nger works:
>=20
> glaubitz@node54:/data/home/glaubitz/toybox> make root CROSS=3Dsh2eb-linux=
-muslfdpic- LINUX=3D/data/home/glaubitz/sh-linux
> mkroot/mkroot.sh  -- LINUX=3D/data/home/glaubitz/sh-linux CROSS=3Dsh2eb-l=
inux-muslfdpic-
> No ccc symlink to compiler directory.
> make: *** [Makefile:108: root] Error 1
> glaubitz@node54:/data/home/glaubitz/toybox>
>=20
> It asks me to create a "ccc" symlink but I have no clue where that link i=
s supposed
> to point to. The FAQ says the link is supposed to =C2=BBpointing at a dir=
ectory full of
> cross compilers=C2=AB but I don't have that and that's not my personal se=
tup. I have the
> cross compilers installed in my home directory and their bin directories =
added to
> the PATH variable which has always worked in the past without any problem=
s.
>=20
> Can you explain how that "ccc" symlink works?

OK, for some reason it works now. Unfortunately, the toolchain doesn't like=
 the current kernel:

  CC      net/ipv4/inetpeer.o
during RTL pass: final
In file included from kernel/nstree.c:8:
kernel/nstree.c: In function '__se_sys_listns':
./include/linux/syscalls.h:261:9: internal compiler error: in change_addres=
s_1, at emit-rtl.c:2275
  261 |         }                                                          =
     \
      |         ^
./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DE=
FINEx'
  236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL_DEF=
INEx'
  228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA=
_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
  763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
      | ^~~~~~~~~~~~~~~
Please submit a full bug report,
with preprocessed source if appropriate.
See <https://gcc.gnu.org/bugs/> for instructions.
{standard input}: Assembler messages:
{standard input}: Warning: end of file not at end of a line; newline insert=
ed
{standard input}:1592: Error: missing operand
{standard input}:1592: Error: invalid operands for opcode
{standard input}:976: Error: displacement to undefined symbol .L339 overflo=
ws 12-bit field
{standard input}:1014: Error: displacement to undefined symbol .L459 overfl=
ows 12-bit field
{standard input}:1028: Error: displacement to undefined symbol .L340 overfl=
ows 12-bit field
{standard input}:1040: Error: displacement to undefined symbol .L461 overfl=
ows 12-bit field
{standard input}:1060: Error: displacement to undefined symbol .L462 overfl=
ows 12-bit field
{standard input}:1082: Error: displacement to undefined symbol .L463 overfl=
ows 12-bit field
{standard input}:1100: Error: displacement to undefined symbol .L252 overfl=
ows 12-bit field
{standard input}:1201: Error: displacement to undefined symbol .L286 overfl=
ows 12-bit field
{standard input}:1211: Error: displacement to undefined symbol .L468 overfl=
ows 12-bit field
{standard input}:1221: Error: displacement to undefined symbol .L298 overfl=
ows 12-bit field
{standard input}:1234: Error: displacement to undefined symbol .L469 overfl=
ows 12-bit field
{standard input}:1256: Error: displacement to undefined symbol .L349 overfl=
ows 12-bit field
{standard input}:1341: Error: displacement to undefined symbol .L314 overfl=
ows 12-bit field
{standard input}:1488: Error: displacement to undefined symbol .L454 overfl=
ows 8-bit field=20
{standard input}:1498: Error: displacement to undefined symbol .L471 overfl=
ows 8-bit field=20
make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
make[3]: *** Waiting for unfinished jobs....

Adrian

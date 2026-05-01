Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA5346E4E
	for <linux-sh@vger.kernel.org>; Fri,  1 May 2026 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777627278; cv=none; b=hdR+ix3czBQBBu2MuPBnEaLQWmzwW3uUNnZ9McwgTuMV1rsWHML8oSidmM8yXpOB1EsxG9q2TkZrdNjoMnTm+wOh5sBu77WrXVlZxVFmnRxbvZJ+psuIj/C7Kh/sfYBaozHNKve2aE/PSIl+HvHKp53YlbV8U3mNg7VOREkiB5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777627278; c=relaxed/simple;
	bh=6EvoRa+WaKGPBpx/zlAa4PPIwe1wtr1hDsz6Q35hieU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ixJSXl8sptGSqD+wuH0rJWCN51rcAyb+bxYLBUQKs+McIx2R9RVFDRbha10V11cKXTjR0ynAFN6C40HYuwH8nTlkCul3vSMVQfz7MpQPqe7/OzqqiZzQ1bI9Z5nSjMjtg0QDvwOEvBZtfesMRVK07PU9rg3tdck/JA3A2/8q2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cWJmA3CC; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cWJmA3CC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9bAdeyMA64dN1TDYRdnFnnWS+lqMR/tiHprthPdCUNo=; t=1777627275;
	x=1778232075; b=cWJmA3CC84enoPiL9rGJdwLtAoia4eCbhG16bw9SXD81jTQh+zoYguoVGHOCJ
	wjwkf4g83N8ivLNrsDK0T/S6CmMXW2+M5A6tJHFhtgjQHaTl1sCydaInwvapeNbgMh1Gf/IHz7Hiy
	953pyC2aH5Hdvb7+dh2vipX+s2fWlyi1hv54U6j4o+B5daJzHZwPc3wyH05HdWPspwNs+nfrZZv8s
	1vEFWHFH1RU3K9DtYQRhvRD8ieTzSuHu6BMo1T0obHNzPg/ZF/HX/CmrEdabTXZ36dgFaVs/r5WAq
	lHy0+t1G6rFJ2yGC8UIkYoYUML5dRNX+YZPm1+s0B/YawKwDaA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wIk3c-00000003FMm-2k0w; Fri, 01 May 2026 11:21:12 +0200
Received: from p5dc559e1.dip0.t-ipconnect.de ([93.197.89.225] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wIk3c-00000001Xow-1kzq; Fri, 01 May 2026 11:21:12 +0200
Message-ID: <a9acb387eb573a6b1e2cfad6bb406e8fbafda412.camel@physik.fu-berlin.de>
Subject: Re: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: Rob Landley <rob@landley.net>, linux-sh <linux-sh@vger.kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, "D. Jeff Dionne"
 <jeff@coresemi.io>
Date: Fri, 01 May 2026 11:21:11 +0200
In-Reply-To: <2C047C85-A557-4804-A531-57A98F7D569F@gmail.com>
References: 
	<359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
	 <c1cbf376-9bd2-4c2b-aed4-e7c378ac7301@landley.net>
	 <e24b35682248a0e9b3f7592e5ba999ba387b740f.camel@physik.fu-berlin.de>
	 <2C047C85-A557-4804-A531-57A98F7D569F@gmail.com>
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

Hi Jeff,

On Fri, 2026-05-01 at 12:44 +0900, D. Jeff Dionne wrote:
> On May 1, 2026, at 07:46, John Paul Adrian Glaubitz <glaubitz@physik.fu-b=
erlin.de> wrote:
>=20
> > Could you maybe build an updated toolchain for sh2eb which is based on =
a more recent GCC version?
>=20
> The main problem here, I think if it=E2=80=99s a version issue, is there =
is breakage in the GCC optimiser
> when used against the SH backend.  But it could also be the J-Core instru=
ction set variant of SH2.
>=20
> GCC 9.4 is probably what you need, we don=E2=80=99t actually use GCC 11=
=E2=80=A6 Rob uses a different work flow
> methodology, with the goal of self contained builds.  Most of us benefit =
from 'golden compilers'
> on the path, and for J-Core that been GCC 9.4 series because of similar p=
roblems.  This choice
> came about after some testing, so it=E2=80=99s what Rich Felker=E2=80=99s=
 musl cross make still does.  The results
> of that build script are used in every day work.

GCC 9.4.0 has the same problem, unfortunately:

glaubitz@node54:/data/home/glaubitz/toybox.good> sh2eb-linux-muslfdpic-cc -=
-version
sh2eb-linux-muslfdpic-cc (GCC) 9.4.0
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

glaubitz@node54:/data/home/glaubitz/toybox.good>=20


  CC      io_uring/bpf_filter.o
during RTL pass: final
In file included from kernel/nstree.c:8:
kernel/nstree.c: In function '__se_sys_listns':
./include/linux/syscalls.h:261:2: internal compiler error: in change_addres=
s_1, at emit-rtl.c:2286
  261 |  }        \
      |  ^
./include/linux/syscalls.h:236:2: note: in expansion of macro '__SYSCALL_DE=
FINEx'
  236 |  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~
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
{standard input}:1547: Error: missing operand
{standard input}:1547: Error: invalid operands for opcode
{standard input}:1004: Error: displacement to undefined symbol .L344 overfl=
ows 12-bit field
{standard input}:1042: Error: displacement to undefined symbol .L456 overfl=
ows 12-bit field
{standard input}:1049: Error: displacement to undefined symbol .L588 overfl=
ows 12-bit field
{standard input}:1056: Error: displacement to undefined symbol .L345 overfl=
ows 12-bit field
{standard input}:1068: Error: displacement to undefined symbol .L458 overfl=
ows 12-bit field
{standard input}:1085: Error: displacement to undefined symbol .L459 overfl=
ows 12-bit field
{standard input}:1095: Error: displacement to undefined symbol .L252 overfl=
ows 12-bit field
{standard input}:1107: Error: displacement to undefined symbol .L346 overfl=
ows 12-bit field
{standard input}:1116: Error: displacement to undefined symbol .L254 overfl=
ows 12-bit field
{standard input}:1119: Error: displacement to undefined symbol .L256 overfl=
ows 12-bit field
{standard input}:1159: Error: displacement to undefined symbol .L339 overfl=
ows 12-bit field
{standard input}:1322: Error: displacement to undefined symbol .L451 overfl=
ows 12-bit field
{standard input}:1335: Error: displacement to undefined symbol .L355 overfl=
ows 12-bit field
{standard input}:1379: Error: displacement to undefined symbol .L588 overfl=
ows 12-bit field
{standard input}:1436: Error: displacement to undefined symbol .L295 overfl=
ows 8-bit field=20
{standard input}:1439: Error: displacement to undefined symbol .L466 overfl=
ows 8-bit field=20
{standard input}:1455: Error: displacement to undefined symbol .L292 overfl=
ows 12-bit field
{standard input}:1465: Error: displacement to undefined symbol .L468 overfl=
ows 12-bit field
{standard input}:1475: Error: displacement to undefined symbol .L304 overfl=
ows 12-bit field
{standard input}:1488: Error: displacement to undefined symbol .L353 overfl=
ows 12-bit field
{standard input}:1497: Error: displacement to undefined symbol .L306 overfl=
ows 12-bit field
{standard input}:1510: Error: displacement to undefined symbol .L354 overfl=
ows 12-bit field
{standard input}:1414: Error: pcrel too far
{standard input}:1417: Error: pcrel too far
{standard input}:1500: Error: pcrel too far
make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
make[3]: *** Waiting for unfinished jobs....
  CC      kernel/utsname_sysctl.o

Might be an idea to try an LRA-enabled GCC [1].

Adrian

> [1] https://github.com/olegendo/gcc/tree/devel/sh-lra

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BC53F8222
	for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 08:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016874; cv=none; b=eD3XHe5wCGkaAJsRSsjoOq3egYhZM+HOL7AKaf8FKDCaOwcUavDz2VvHlQpC5O9r8rtSfDLbQ8wMWOfCaQZp3cGBHt7QC4tH9vLfyH4n/zhA4ou9yheeuus0Mi9xf1R9njVrOXfzXC5VdM/Ng+8+ZEz5j89PANrx9lIFkhnaeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016874; c=relaxed/simple;
	bh=FwIE6h5axno7hqS5eT8TYujn4ItIz7qxJmCm/rU05g4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cMulJqRoOHQN9faqwER+NR+zeXH9DGnFzj0rr0JPLUgfz2YT4oUf1av+AORU2BlLAmLpnIKNak2RqkIs2XhqbGIGzy1x/7BR8ForknHiOS2Ots5MZit+zBxVHSTaLapmzjKZ3qrjhlRuB5AJ5+LfMutpgbVOHAabAjC1TGbAXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cuUtpUqF; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cuUtpUqF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=TxwFfiSF0lVaZHjzmi2rg1JthV/YuSzhwhpkPB4Je4w=; t=1784016869;
	x=1784621669; b=cuUtpUqFFV06kBw/4zpjmH9C9RVcfkdkd50ifD2UQ0k3Uyf2zRP7IyTsUaj0P
	Zt4JBINLmA8hxLHk68Q1l49C0s+tzfPuu6vKPFmTh3ORXRy9XyhlSe/7w33/AtWve8mnZ8qODrpPO
	ED/lZnevAlYSqd7o9/ug0ap0A2x+sWOFXykWHbb9rb1M2/FJw1+1vk5BwUxvhzCjzjFgcZAExhtCQ
	saCuagvtjw+1d+so4U0XJoDdPjmG7McJ+/RKjSgqTIFw9z1TdUuGZA6EpIiVCwDr0ngsjwYFSBCNO
	lciVBA2shqcdITQnD1a1x+H+l6XmEG0Qc1ZvPTYb8Ohu4AF3jw==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1wjYHV-00000003Tf3-001n; Tue, 14 Jul 2026 10:14:21 +0200
Received: from p57bd94c1.dip0.t-ipconnect.de ([87.189.148.193] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1wjYHU-00000000QOT-3Fjz; Tue, 14 Jul 2026 10:14:20 +0200
Message-ID: <3eeb0f60a3f133bfd3ab5467b35045c904b8a9e8.camel@physik.fu-berlin.de>
Subject: Re: Toybox make root no longer works as expected
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: Rob Landley <rob@landley.net>, linux-sh <linux-sh@vger.kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Jul 2026 10:14:20 +0200
In-Reply-To: <alXpoJOjg5HrSvhE@lithos>
References: 
	<359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
	 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
	 <alXpoJOjg5HrSvhE@lithos>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Florian,

On Tue, 2026-07-14 at 09:47 +0200, Florian Fuchs wrote:
> > OK, for some reason it works now. Unfortunately, the toolchain doesn't =
like the current kernel:
> >=20
> >   CC      net/ipv4/inetpeer.o
> > during RTL pass: final
> > In file included from kernel/nstree.c:8:
> > kernel/nstree.c: In function '__se_sys_listns':
> > ./include/linux/syscalls.h:261:9: internal compiler error: in change_ad=
dress_1, at emit-rtl.c:2275
> >   261 |         }                                                      =
         \
> >       |         ^
> > ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCAL=
L_DEFINEx'
> >   236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
> >       |         ^~~~~~~~~~~~~~~~~
> > ./include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL=
_DEFINEx'
> >   228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, =
__VA_ARGS__)
> >       |                                    ^~~~~~~~~~~~~~~
> > kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
> >   763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
> >       | ^~~~~~~~~~~~~~~
> > Please submit a full bug report,
> > with preprocessed source if appropriate.
> > See <https://gcc.gnu.org/bugs/> for instructions.
> > {standard input}: Assembler messages:
> > {standard input}: Warning: end of file not at end of a line; newline in=
serted
> > {standard input}:1592: Error: missing operand
> > {standard input}:1592: Error: invalid operands for opcode
> > {standard input}:976: Error: displacement to undefined symbol .L339 ove=
rflows 12-bit field
> > {standard input}:1014: Error: displacement to undefined symbol .L459 ov=
erflows 12-bit field
> > {standard input}:1028: Error: displacement to undefined symbol .L340 ov=
erflows 12-bit field
> > {standard input}:1040: Error: displacement to undefined symbol .L461 ov=
erflows 12-bit field
> > {standard input}:1060: Error: displacement to undefined symbol .L462 ov=
erflows 12-bit field
> > {standard input}:1082: Error: displacement to undefined symbol .L463 ov=
erflows 12-bit field
> > {standard input}:1100: Error: displacement to undefined symbol .L252 ov=
erflows 12-bit field
> > {standard input}:1201: Error: displacement to undefined symbol .L286 ov=
erflows 12-bit field
> > {standard input}:1211: Error: displacement to undefined symbol .L468 ov=
erflows 12-bit field
> > {standard input}:1221: Error: displacement to undefined symbol .L298 ov=
erflows 12-bit field
> > {standard input}:1234: Error: displacement to undefined symbol .L469 ov=
erflows 12-bit field
> > {standard input}:1256: Error: displacement to undefined symbol .L349 ov=
erflows 12-bit field
> > {standard input}:1341: Error: displacement to undefined symbol .L314 ov=
erflows 12-bit field
> > {standard input}:1488: Error: displacement to undefined symbol .L454 ov=
erflows 8-bit field=20
> > {standard input}:1498: Error: displacement to undefined symbol .L471 ov=
erflows 8-bit field=20
> > make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
> > make[3]: *** Waiting for unfinished jobs....
> >=20
> > Adrian
>=20
> I also crafted a bit with gcc-17, and my first issue was a duplicate
> symbols (LPCS0) compiling libgcc like in
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D89012 I could only work
> around with explicitly using O1 instead of O2 in INTERNAL_CFLAGS of gcc.
>=20
> And errors with libbacktrace, I worked around by --enable-languages=3Dc
>=20
> I got gcc to not ICE, but it then fails with invalid assembler thats why
> I became suspicious about the asm in question. turns out, delcaring the
> adresses as offsetable, seems to "fix" the ICE and compile and work for
> fdpic, means it is maybe not necessarily only a GCC issue.
>=20
> diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uacce=
ss_32.h
> index 5d7ddc092afd..cef40414bfb1 100644
> --- a/arch/sh/include/asm/uaccess_32.h
> +++ b/arch/sh/include/asm/uaccess_32.h
> @@ -92,7 +92,7 @@ __asm__ __volatile__( \
>  	".long	1b + 2, 3b\n\t" \
>  	".previous" \
>  	:"=3D&r" (err), "=3D&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>  #else
>  #define __get_user_u64(x, addr, err) \
>  ({ \
> @@ -116,7 +116,7 @@ __asm__ __volatile__( \
>  	".long	1b + 2, 3b\n\t" \
>  	".previous" \
>  	:"=3D&r" (err), "=3D&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>  #endif
> =20
>  #define __put_user_size(x,ptr,size,retval)		\
> @@ -196,7 +196,7 @@ __asm__ __volatile__( \
>  	".long	1b, 3b\n\t" \
>  	".previous" \
>  	: "=3Dr" (retval) \
> -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>          : "memory"); })
>  #else
>  #define __put_user_u64(val,addr,retval) \
> @@ -218,7 +218,7 @@ __asm__ __volatile__( \
>  	".long	1b, 3b\n\t" \
>  	".previous" \
>  	: "=3Dr" (retval) \
> -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
> +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>          : "memory"); })
>  #endif
> =20

Thanks a lot for looking into this, I appreciate the help!

Did you manage to build a J2 toolchain using GCC 17? I have not looked
into it myself yet due to time constraints, but I would like to switch
to a newer compiler to build test kernels for my J2.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

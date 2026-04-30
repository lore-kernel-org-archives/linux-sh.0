Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54FF29CE1
	for <linux-sh@vger.kernel.org>; Thu, 30 Apr 2026 07:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777533232; cv=none; b=CvjFRMTiOEUC69ymU5MiJAD7EclITamcXLZOxFqYUjRg/yvI0F41JfHpBvdMuIBM4T6SaMy6OTm9UsXwwqpOpBwr6iaIAIznj35GH0V8X4RBG2dL6mXPToU/oc7qtIEdQJTHfmNsv+7NxVfsGNC3Fd9Y9v+tg/2sqqY29HKgAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777533232; c=relaxed/simple;
	bh=f48yvAf4K49MXUS6hpt2tVZRVK6ri//sARkg7kkv0F8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=FQTo77Qi4Kxigkeujex1L924rhv6ukQnfOcqNh/TeJojjjX2BYj2JpnKUKatPQEHuk64nvV7hzRi6UC8hop9c5CYBvjwZd6wyyVwgexCeKxYSCJUT+5W/WC7fSid7cGsG0oJBlalxliHcSru//K3aD/hkexh2JR5QZwCwH5lhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eraBsd5E; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eraBsd5E"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b2429f98d0so3531165ad.2
        for <linux-sh@vger.kernel.org>; Thu, 30 Apr 2026 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777533230; x=1778138030; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69atASl/V79Miwg2QsXutg5uvrlwAqQ/3Ja24VkXxAo=;
        b=eraBsd5EskpKUy4ZTL0w+2z+ZD9CSdSnbvM3+DQ7WI6OXwfCMuhmmDbU2Oilw9Ty9I
         ED8FC9We2oE6Xa1ACfCXBTbh4X9yuwSAw0V1WJqhlNw7yp9pLHtUdHDvewngxLhJ/4fn
         H22UQh2/QpV7zoTWLmMCvixtEtx/nGqMJdlYtAMdt8IvbYtRUsE0NIhVgBY0f3qedA3W
         wsea/0U58dtUz30n8KOd6TWkWMH9EBrnpRuGAiwfZIFsF/ciGtpTYPl99LV/n6kqu1Py
         Y2H53r/55Qg9XHe19EmWMAyP0QMyAMDlSfeJwG3lk58cBWS1mNVohoL8Py1E8/QSCsXB
         lsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777533230; x=1778138030;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=69atASl/V79Miwg2QsXutg5uvrlwAqQ/3Ja24VkXxAo=;
        b=lx3aH+OVCKirRrzw7iE/TH4kZHCrdWtlpICbn3a1FfX3GFd6vEhjc44lCzEMmtBcuP
         +tZOeWWG6lBAsC8YPzXGiH5E/xEZ8R5kGfAnr8vCzb9n3mG/RI7J57wIGCxMMBxaDi9t
         MibCF2PORhxJU0yJ79gZeYgVGxMkoEgU5g4jAFpp568sA0Yd6dK1lEAsTbn+1Q9Oz8bJ
         FN0tHxqCNYth6YUKuBfqBrbt/cAqq43Dj0i4OqEByr+ruG8auBZ5NMn0AvOPzsqCEbSr
         ibpjsABJ74RED8/1tJCW1/WB2PlVC++M7pzi7wjpq7uGFrDbz/GKXAgsLMRn42HA4xUW
         IpFg==
X-Forwarded-Encrypted: i=1; AFNElJ/HGTRV+Ijbu8djmCpkmCK73ainciRbBBuozaCndJTKYE7Hg2vk2WHDxGRTIGzQ0FHlp0yiSJZ5lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAzb/Kz97Wwuwy9HUiHg8e6fsgpoU3sGqtFBgTy99JwQEl6vd4
	VpLsjXLNZlxcaMRPSVzTvcj86C6AP58iw1igk3WgmApi06kMl6J36DWSRq3HlrW/
X-Gm-Gg: AeBDievL5mrTX8DKlyc+A5WJxy01XS4pf/aa8Nnijb8Ic7UepStY2sDvZNOJIwIpsXB
	6FBtBhzApq9FiNg2atZDsPNmV38e5Gz/mMX7FKzXQC8cqYQz8yFRfEP0ZzS2IGcor1d9h5IWF7I
	0qatnmVsRsrTkEO0vuA4IYEoxVLQdtfPGDpwkpjL6LHAGOm8omKx3/tDJGVTVqrQE9XVzJynjBF
	T/wlkjwpwdj99xnZdVB3s+2Wej7P/heONGG2kl+eCxFyJ70V1lF1ZeFPNgXIb8/WuRZRZDYU1sI
	8XXUWLQKrEtydFnxbgiSCgDH73gfny3LrRqNn11WgsAstv/xDk/Gm/UbZ47ai62Cpd5mdW2UO03
	w88r2YRLI7qVQg4iqqi8J9OA7Bt9rHVoLiTfBgk5pcYY+6cL+41g7AtkNF4iBemHRRAt+mZGRZD
	dB1YPgkyB/mtqdOoXjI0aFciSuj6Z/cgqt6fCl2LYRsf5Bn+Ib7xo2N5eCfkq3CuEawxLM3QUUs
	LW0NF1TsrGATJBp
X-Received: by 2002:a17:903:1b50:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b9a24e1d4emr19704265ad.27.1777533230118;
        Thu, 30 Apr 2026 00:13:50 -0700 (PDT)
Received: from smtpclient.apple (p121132.f.east.v6connect.net. [221.113.121.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b988798368sm43867565ad.26.2026.04.30.00.13.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:13:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: Toybox make root no longer works as expected
From: "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
Date: Thu, 30 Apr 2026 16:13:23 +0900
Cc: Rob Landley <rob@landley.net>,
 linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "D. Jeff Dionne" <jeff@coresemi.io>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3864.300.41.1.7)

Hey Adrian,

Can you do a --version on that toolchain gcc for me please.  Overflow =
and internal compiler error suggest maybe -mj2 is not in the command =
line, for instance.

In the meantime, here is the (IIRC current) build script we use to =
generate toolchains for J-Core J2 J1 Linux and bare metal.  It=E2=80=99s =
a but convoluted, patches on patches=E2=80=A6 no one has the time to =
clean this up as we=E2=80=99d like.

=
https://codeberg.org/J-Core/librelane-vhdl-build/src/branch/master/01-tool=
chains.sh

Cheers,
J.

> On Apr 30, 2026, at 15:57, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> Hi,
>=20
> On Wed, 2026-04-29 at 09:46 +0200, John Paul Adrian Glaubitz wrote:
>> I'm trying to build a new root image after updating Toybox but that =
no longer works:
>>=20
>> glaubitz@node54:/data/home/glaubitz/toybox> make root =
CROSS=3Dsh2eb-linux-muslfdpic- LINUX=3D/data/home/glaubitz/sh-linux
>> mkroot/mkroot.sh  -- LINUX=3D/data/home/glaubitz/sh-linux =
CROSS=3Dsh2eb-linux-muslfdpic-
>> No ccc symlink to compiler directory.
>> make: *** [Makefile:108: root] Error 1
>> glaubitz@node54:/data/home/glaubitz/toybox>
>>=20
>> It asks me to create a "ccc" symlink but I have no clue where that =
link is supposed
>> to point to. The FAQ says the link is supposed to =C2=BBpointing at a =
directory full of
>> cross compilers=C2=AB but I don't have that and that's not my =
personal setup. I have the
>> cross compilers installed in my home directory and their bin =
directories added to
>> the PATH variable which has always worked in the past without any =
problems.
>>=20
>> Can you explain how that "ccc" symlink works?
>=20
> OK, for some reason it works now. Unfortunately, the toolchain doesn't =
like the current kernel:
>=20
>  CC      net/ipv4/inetpeer.o
> during RTL pass: final
> In file included from kernel/nstree.c:8:
> kernel/nstree.c: In function '__se_sys_listns':
> ./include/linux/syscalls.h:261:9: internal compiler error: in =
change_address_1, at emit-rtl.c:2275
>  261 |         }                                                       =
        \
>      |         ^
> ./include/linux/syscalls.h:236:9: note: in expansion of macro =
'__SYSCALL_DEFINEx'
>  236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>      |         ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:228:36: note: in expansion of macro =
'SYSCALL_DEFINEx'
>  228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, =
__VA_ARGS__)
>      |                                    ^~~~~~~~~~~~~~~
> kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
>  763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
>      | ^~~~~~~~~~~~~~~
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <https://gcc.gnu.org/bugs/> for instructions.
> {standard input}: Assembler messages:
> {standard input}: Warning: end of file not at end of a line; newline =
inserted
> {standard input}:1592: Error: missing operand
> {standard input}:1592: Error: invalid operands for opcode
> {standard input}:976: Error: displacement to undefined symbol .L339 =
overflows 12-bit field
> {standard input}:1014: Error: displacement to undefined symbol .L459 =
overflows 12-bit field
> {standard input}:1028: Error: displacement to undefined symbol .L340 =
overflows 12-bit field
> {standard input}:1040: Error: displacement to undefined symbol .L461 =
overflows 12-bit field
> {standard input}:1060: Error: displacement to undefined symbol .L462 =
overflows 12-bit field
> {standard input}:1082: Error: displacement to undefined symbol .L463 =
overflows 12-bit field
> {standard input}:1100: Error: displacement to undefined symbol .L252 =
overflows 12-bit field
> {standard input}:1201: Error: displacement to undefined symbol .L286 =
overflows 12-bit field
> {standard input}:1211: Error: displacement to undefined symbol .L468 =
overflows 12-bit field
> {standard input}:1221: Error: displacement to undefined symbol .L298 =
overflows 12-bit field
> {standard input}:1234: Error: displacement to undefined symbol .L469 =
overflows 12-bit field
> {standard input}:1256: Error: displacement to undefined symbol .L349 =
overflows 12-bit field
> {standard input}:1341: Error: displacement to undefined symbol .L314 =
overflows 12-bit field
> {standard input}:1488: Error: displacement to undefined symbol .L454 =
overflows 8-bit field=20
> {standard input}:1498: Error: displacement to undefined symbol .L471 =
overflows 8-bit field=20
> make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
>=20
> Adrian
>=20


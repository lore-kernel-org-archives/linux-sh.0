Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A41225B090
	for <linux-sh@vger.kernel.org>; Sun, 12 Jul 2026 05:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783835947; cv=none; b=tTASXCIp//DdXTmXuGK5kYOFncWMW8KZ3ZWstFDGsOfIQTZFdmDqooLEx66i5jWa6pW3nzi3bG0oMKId/S9GE5WLKRTn6Wa3i1GFc0Yhc8pin5vKzeAJS6kQ9p9ykKA8RL2xhJXw8iCTHVtdIW8wvUV4IbiT4jD3rV8/yBBXrpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783835947; c=relaxed/simple;
	bh=U43AAegH4Aqj3ml8RtngCZIYUk/Cw2qm6Z62goEv8Q0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TXWEJZ3Xxh6dzM2qDQIc3sHIyR3UvplJvyAxpMfeuiSdir+8v2YCo7ISs7snnpH2SPZUffe/U61Lxq7h/fJ30V6oZAs0jOckHwIrDbNVO0Xn37SFxAArXjkdoUi6XExCDumTO5lBOtgG4TqfbY/FZrfq3yeHWKCpaiqbaCDoP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io; spf=none smtp.mailfrom=coresemi.io; dkim=pass (2048-bit key) header.d=coresemi-io.20251104.gappssmtp.com header.i=@coresemi-io.20251104.gappssmtp.com header.b=fYCWJYR6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=coresemi.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=coresemi.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coresemi-io.20251104.gappssmtp.com header.i=@coresemi-io.20251104.gappssmtp.com header.b="fYCWJYR6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38759bcd877so1740093a91.2
        for <linux-sh@vger.kernel.org>; Sat, 11 Jul 2026 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coresemi-io.20251104.gappssmtp.com; s=20251104; t=1783835945; x=1784440745; darn=vger.kernel.org;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iyTID/WZLHGbu2RVsPZZ0ICCWgZDe9NLggePPfx59jk=;
        b=fYCWJYR6/3QrAQim1SU1y+NBMsyeJI0SN4ARoUiJYp4MgyrlSjayWLheZ/cF+cDlwO
         lvGshQLqUAAPNWjx/pCtCMuKf8xo7v36KKq9W39jmXMllBqZ4oUIDIg+uf+VxbyYdmi9
         QzUCOFIkU2NklOA+la+5GvWU6RB9hGIDctMqH3oP0SMg/cnBmqQdE50nvOdYo+4xAIhO
         cHK83akSpEByaq0dtvwEXhhDI2iWP+igEyYb/Uae6rGLWAud4Gj6KCtXxmtw2sLafu0f
         F1AbB35bgAvJToicoz2NpX7aZkooAntSiRTnKxGocQxeIRDDFNFwPiqL4+LZtSzBeHfc
         HqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783835945; x=1784440745;
        h=to:references:message-id:cc:date:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iyTID/WZLHGbu2RVsPZZ0ICCWgZDe9NLggePPfx59jk=;
        b=A/iIWmeCipiyTJNOsIAN/qj+X6R0IpGXoJILnKBdR98wy6snNC9HHi0T6Z3+qAmsqO
         SdFGjpcn34smfJ6TlKweHtBZpzFOBbcEaFLVZPsAl37Sb3qeU8knQNpyel3NNFqnmIVK
         kFlCxYVAxyHyZuVHkJm8ReJbGltfTRDUrbIers95ayBtk5WKFnzG5j1eG8dXSp/e8Qu7
         m2ItL1PJkAXUGTcEFgIm7A7fPg6DAwTKMw7xL+SXu33/M3RI4zsoLK+FJjjjBA7weAjH
         HKGgvU8PsKLXLE0RZg/VZEBrDE1eKHwXM+02NOXuZAEG6/SQQko9fNgZS1IRL/8i+l07
         N4hQ==
X-Forwarded-Encrypted: i=1; AHgh+RofMJ/7AW9rjqHhEGVqN5jwsV98ihN0FDEfXIg9LTnYm1WD5iURvs0ToD68iWMlhH+Yu9CUVKwpxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBg1YlvrpiqcTr+p7ghvH+UX8x8LSkeEcgHrP5WK7Y6Gjejcfc
	iBnSxi84uriOEKtPMwO8AfkI0Ow0p3VL8wa1e7r8OmzNxk/7zN0NHmtftjdj2ZIYWr0=
X-Gm-Gg: AfdE7ck9Kkn7DuXl4utBaVUo0A8pigHRiuN6dqk7rgBycwBO2Rg6ywHoE5xPCHoqjUi
	tNHKzxTU0aF2QZme++oyMQes3CgYKVqv+NXURJJZMoMFLmehIg7iHJlPkktEJj7XBBU8vfNQNK3
	CVO7J2IoPaGeV/eaWbECtR86aQxOCw8A5A+ysAvugpBUHqa6kVZOisGcKaHGlnKy0L+p4Ha22XB
	BYC0FgwPBuU6rNU1gzrOXC/Gvw5IhUkF1zHee/ecdYgAFd6P6ZrYpgAE2JZf+GnLo5Oiykm/Bae
	supAfRBLFEJcXID+H1q2lT2xkytNAdgxSjFD7xWyIWF90JEEF28HnvvHa+/iAINxbjdz5RQbIR9
	Ktf19NPF2DYOTXXngDmvf+srayQf7T8Uo9F5y8fFi0buexZysXqoYTeO4Av400UOwk6/KZWILyt
	gQ0awG0xbIcyz+xtpAFniPcf2R+/YOe+d8KSJE
X-Received: by 2002:a17:90b:4a:b0:380:540:d49a with SMTP id 98e67ed59e1d1-38dc78228cbmr4804210a91.7.1783835944712;
        Sat, 11 Jul 2026 22:59:04 -0700 (PDT)
Received: from smtpclient.apple ([2001:268:99b5:9e3:2c82:f889:b81:1fd8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b47esm4682321a91.3.2026.07.11.22.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 22:59:04 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Toybox make root no longer works as expected
From: "D. Jeff Dionne" <jeff@coresemi.io>
In-Reply-To: <570e4053-9e57-4e63-9808-0b770a3a3791@landley.net>
Date: Sun, 12 Jul 2026 15:00:25 +0900
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "D. Jeff Dionne" <djeffdionne@gmail.com>,
 linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Message-Id: <A4205228-E202-4157-9C57-FE37497E1586@coresemi.io>
References: <570e4053-9e57-4e63-9808-0b770a3a3791@landley.net>
To: Rob Landley <rob@landley.net>
X-Mailer: iPhone Mail (23C71)

I will try and force myself to find time to help with this.

I noticed a few days ago that some very old targets I need to work on are ha=
ving some bitrot with even new 9.4.0 toolchains.

Rob, can you do me a favour and extract our GCC patch stack for all the sh2 f=
lavours we support cleanly from the build scripts?  All those targets will n=
eed forward porting.

Cheers,
J.

> On Jul 12, 2026, at 13:52, Rob Landley <rob@landley.net> wrote:
>=20
> =EF=BB=BFOn 7/10/26 08:32, John Paul Adrian Glaubitz wrote:
>> Coming back to this. After recent changes to GCC [1], I would expect the c=
hances
>> to be higher that a J2 toolchain build with GCC 17 would work better when=
 building
>> a current kernel tree.
>> Would you be able to help me build a fresh J2 toolchain from the GCC 17 t=
ree?
>=20
> Yes, I am interested.
>=20
> I was actually poking at that a couple weeks ago. (tl;dr when the arm guys=
 added fdpic support for their target, they broke sh2's fdpic support in com=
mit https://github.com/gcc-mirror/gcc/commit/11189793b6ef and I have a todo i=
tem to add some #ifdef __MUSL__ to that since you have to say "sh2eb-blah-mu=
slfdpic" in the config --target anyway).
>=20
> Backstory time!
>=20
> So I shipped new toolchains with the recent toybox release:
>=20
>  https://landley.net/bin/toolchains/19-06-2026/
>=20
> This time based on gcc 15.1, and I had to bisect some issues (like https:/=
/mstdn.jp/users/landley/statuses/116747488061835417) along the way (the solu=
tion of which was for Rich to update musl to the current version in musl-cro=
ss-make, which he'd forgotten to do: the system call interface missed annota=
ting two registers as caller saved).
>=20
> The one target I _didn't_ get to work in time for the release was sh2eb-fd=
pic. (With gcc 15.1 the link fails trying to build musl, complaining about b=
eing unable to find LP50, every other package can be updated except that one=
 and you get a shell prompt in mkroot, although you seperately have to use a=
n older kernel because of the header assembly issue causing an internal comp=
iler error; that's separate breakage.)
>=20
> You still need patches to add proper -mj2 support, but since j2 is backwar=
ds compatible with sh2eb-fdpic that's what I've actually been shipping in my=
 toolchains. Unfortunately, sh2-fdpic doesn't work in 15.1, and I bisected f=
rom 9.4 to find out why.
>=20
> (Drilling forward from "the one that works" to figure out where newer vers=
ions broke stuff is my go-to approach when I don't have a firm grasp of the p=
lumbing in question.)
>=20
> =46rom my notes;
>=20
> The first commit after 9.4 to break fdpic was 5d727a4b2025 which added c++=
 unwind exception support to arm fdpic. That caused the "unwind-pe.h:270:25:=
 error: '_Unwind_gnu_Find_got' was not declared in this scope" error, which p=
ersisted for many, many commits after that...
>=20
> Commit 551935d11817 then switched the behavior to the CURRENT failure, the=
 one about LP50. But A) that commit's enormous adding a new subsystem, and B=
) I think that's a separate error masking the first, not fixing it.
>=20
> I was trying to build that toolchain from an unpatched gcc with newer vers=
ion. (the -mj2 machine is nice to have but not vital, what we _really_ need i=
s sh2eb with fdpic).
>=20
> I asked on the #musl irc channel and nsz suggested https://git.zv.io/toolc=
hains/musl-cross-make/-/raw/musl.cc-old/patches/gcc-11-20230427/0100-hack-sh=
2fdpic-unwind-nonsense.diff?ref_type=3Dheads and with the zv patch and an up=
dated version of the VISIBILITY_HIDDEN patch, commit 551935d11817^1 builds a=
 toolchain! But the resulting toybox segfaults...
>=20
> Bisected the segfault to commit 11189793b6ef (back in 2019) where the arm f=
dpic guys changed the semantics of __do_global_dtors_aux and frame_dummy in a=
 way that broke superh fdpic. They do not explain WHY they changed the seman=
tics' and musl's init code expects the old semantics. (This is one of those c=
rt1.o talking to crtbegin.o talking to crti.o things. The arm guys GLOBALLY c=
hanged the handoff, and broke musl-fdpic in the process. I doubt they regres=
sion tested fdpic on any other target, and embedded guys always use OLD TOOL=
CHAINS because the new ones have worse optimizers for C...)
>=20
> Seriously, that commit says "we need to make sure __do_global_dtors_aux an=
d frame_dummy are referenced by their address, not by pointers to the functi=
on descriptors" but... why? It WORKED BEFORE THAT just fine. You arm guys di=
d not invent fdpic! It's been around for MANY YEARS...
>=20
> I've been meaning to get back to this, but I've been juggling too many bal=
ls...
>=20
> Getting sh2 working with the new optimizer plumbing would e great, but unb=
reaking fdpic seems like a prerequisite for our use cases...
>=20
> Rob

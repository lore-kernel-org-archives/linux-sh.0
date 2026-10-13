Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1CC4DDB33
	for <linux-sh@vger.kernel.org>; Tue, 13 Oct 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894965; cv=none; b=GHhZC7T4P1niCsrnc8oSp+C0haAMTmoVXIVs9eVAfd6vCkS1W/xVkDHXseuO+9pABUtnu5iorUdVCByT1cu5F2rx8dsyzB0RiiX+UX6963do6LYU5vmklKkR1v3uxhTVDeakrEBRO3AN72Lf7vUHjlScaYFv0YalQOA16oKw5gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894965; c=relaxed/simple;
	bh=KJz0ljhpxQV0dxuLmyAZzCH6KN1a+1DHS+L2+lDvs9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TnVQko9QfJmpHmxuzdC2YgudwNtvpSTz55XN2bEk+IEyfOvgVDr9aOqlifsYw4qfbxmFCtyatZO7hjQE2THLkgoyznxL5y7/g/2xFmm8Y0OKMkrt8vtr7TH7fGT4cvXMqXb7X67kjhrK7PLh4HNzBN60t8cwb3rFP6L300Wjg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfwSn7zu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfwSn7zu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791894962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
	b=dfwSn7zuZu81ewqBOOFI/l9xBxfYJhLUcFdAPbnSmoghiBOkFiERe/7H8aC8j/8PUFnFxh
	hUEDo/0FrspbXA/QllExBFUWPEDUX14/KIH1NCYfGCUalH8BbQhjiAXAvmcIhVnRttbg9R
	J1fIDjF29+kS3QGm0E5Cg8ZicDZJ6dY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-YIhT0qiJOEe1OcQHsl8gQQ-1; Tue, 13 Oct 2026 12:36:01 +0000
X-MC-Unique: YIhT0qiJOEe1OcQHsl8gQQ-1
X-Mimecast-MFC-AGG-ID: YIhT0qiJOEe1OcQHsl8gQQ_1791894960
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c3613c35145so166880666b.3
        for <linux-sh@vger.kernel.org>; Tue, 13 Oct 2026 05:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894960; x=1792499760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ooKLa1R3KGvywNv1R+3CFpG+InkWtGBVvbQRUtpRSf4=;
        b=qhHfFBgfTvbZDSnjUttJxCsWDqojld8HnbkOvRWhe5TwgfVzy4HVClzXLneIZbNijj
         OznK+AgJyBP36iEBJ5Hh4s2n1MjeRDBfvbEATPSwxbBrGt660WOTJ9G841AzwmvlqlWV
         4iGPRro5V4JPX0n4EOEXp1A7EZFUxNpKGG/YGT/2eaYSKF/nV1iDYZ4I3+LP28mZ7LmM
         6DI4YGWUXXFTr1LcNXV9QqXcE0M8S1EKbUmmAW06I5evkEQWFZ9fLoTjU2s1U73b8LqD
         PWwrmisWs1OcnjTrh+NnC3yvWolepkx7AcFsD+VIQBGlSdIuSropSt7RQZe7W+mTX9be
         OSWw==
X-Forwarded-Encrypted: i=1; AKwUvBxhtdwvj6GKVw+vCE2J6ocSl/xaICEdU6V8MZExhi+lDyfKTvaSPOZ50/CC2q7WM/IsIudLXjkwRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJilPMiNxDRHqitAwrx+zWF/HIfIkbOtMBTtcveSsZlboXklp6I
	u2cggjFVte6OYTRSnpifbBy6J/6sd4YuLo0KNJjaUts3DqMM6uz0a4oo/tKV7NwGhDryP97gliC
	6zcF2P4MGgFfA+P3GmlYC9+58WtJsuYIB6MzcW1cOXu8wZ6/T5PvVRIBsBHNbz4NZSMyLa0B/Q7
	l2n+WNgSKht5jVPvvmYPSxKp0x3onMjUNJtcg=
X-Gm-Gg: AYBFou2balrldqJnh2CXKoSwyJw8XKBAXHZ7UWX7AH74/pCWDp2znucLD7w4pdr53aK
	uUNUU5rl/vklgSuTA/5Fg9eFW3344azYRriZh7Zx43OG6832/KciZlfJjFHPqTzOapuVS749/No
	X990qndDjbwNIGxxxkANmkEz66iNLn9hn1BxySjyIr6WS7wJqPCr9AWdEoG0Q0vmmjvmR2HE4ec
	wXmnSdZ0+k9j6diKx8xU+t/usLDLWjKTLootci7uTJtHm29QqYfAiMd90m7hJNOUOK71wfgXfxE
	y8Q=
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id a640c23a62f3a-c31a9f6ade4mr1135547566b.30.1791894960346;
        Tue, 13 Oct 2026 05:36:00 -0700 (PDT)
X-Received: by 2002:a17:907:7b8a:b0:c2e:1b4d:e9e9 with SMTP id
 a640c23a62f3a-c31a9f6ade4mr1135542366b.30.1791894959880; Tue, 13 Oct 2026
 05:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
In-Reply-To: <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Tue, 13 Oct 2026 09:35:48 -0300
X-Gm-Features: AclHuK-0QABZ6yrPwALI3VDGc1f2HfQWIB06SZ96BvTfEuUJkskwg4GU5NbIk1c
Message-ID: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ugfLYFiGXQroTET06R3c-sxJXmmwtZQZ2OGIGiH8APM_1791894960
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.=
com> wrote:
> >
> > The SYSCALL record currently logs only four of the six syscall
> > arguments (a0-a3), silently discarding the remaining two. This
> > leads to the need for auxiliary records when audit-relevant
> > data lands in the 5th or 6th argument of a syscall.
> >
> > This series extends the SYSCALL record to log all six arguments,
> > by adding arguments a4 and a5 inline within the existing record.
>
> Thanks Ricardo, this looks great!

Thanks, Paul!

>
> There are a few things in some of the individual patches which I reply
> to in a minute, but there are a couple of "global" things that I
> wanted to mention:
>
> * As pointed out by Sashiko, when you were converting all of the
> arches, it looks like you missed alpha.  I took a quick look and it
> appears that it should be a pretty straightforward conversion like
> most of the others.

I've actually dropped the alpha patch as per Magnus's request [1].

[1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BL=
WOvDTt92t5Eg@mail.gmail.com/

>
> * We need to get ACKs from all the various arch maintainers.  Aside
> from the parisc changes all of your arch specific patches are trivial
> (and cleaner than the existing code IMO) so I don't expect anyone to
> complain, but getting ACKs will likely take some time.  Even the
> parisc patches aren't that bad, and arguably they fix a problem for
> seccomp so that should make asking for ACKs easier :)
>
> Since I expect chasing down all the various maintainers for ACKs will
> take a little while, and I'd like to start getting this patchset some
> basic testing, I'm going to merge it into dev-staging now.  While the
> dev-staging branch doesn't feed into linux-next (this isn't likely to
> land in the next merge window) it is one of the branches that gets
> tested automatically and included in my kernel-secnext RPM builds.
> This also means you won't need to worry about keeping this patchset
> up-to-date with rebasing, as I rebase dev-staging as needed (it
> intentionally isn't a stable branch).  Going forward, if there are any
> minor changes to this patchset, e.g. a few line change in one of two
> patches, please just send a fixup patchset based against
> audit/dev-staging and I'll squash it into the relevant patch in the
> series.  However, in the unlikely event that a major rewrite is
> needed, just send a new patchset ... but I'll be very surprised if
> that happens here :)

Sounds good!

>
> --
> paul-moore.com
>

-Ricardo


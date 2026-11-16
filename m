Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816103;
	b=3QFmE0VaiF/COkg35ZkRaZYJBnydJ42v+RvehKgv7j13Tj/3QYtuAMdVec8ueIwyMEDJ
	 d06erC3Y9dTQl5QqZGCS5FW08FxZeSe2CrYfhDAzYTfhUOtNzimx46jHc/a52BmbLD1Pi
	 lUhNzt0Qv3lWvwMNFISk7rPBwtbm0C5JMYr8rDd1EPLfn7iEgB/YWvDhr+Fh35eF2tGx5
	 6+bAXF82IG6iY3yuGO5nL9TREi81nt+Dd4+e5FO7j15715JabClCVL5x+bqBkAiIvLq8m
	 u1ZpUtn1jveNJgqJbdDC7DOP8a1FzLrlG56EtCU5xTdQjZx5HXagOukqjHOWhM/Uqww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
	b=GqWNozf4vewNM7OZFm3dsdAqxb21X3NuiTWA4dS1xo6DrQDzdGoDEzJt73uN8vdL2Ey6
	 gsbLOh08usk3w4m6/d++PkUjpBa2MoQBJpb0cLyZMOuMoM4NSPQC+ldXLV1D2KSidbUTY
	 fwnS2nz12bmbChbCSXygn5lnMENuekmzTWvXCrNgncGjzw3leE6fv0EPH9fNjnqXFt7rd
	 GgRG+Fr1/VGA+Uz+YWPGsrxgz5mxHknJxGYCjSIiJ5BV1v91jNyBHrE/8pZQL6Bm7TFPa
	 ouq9DhTEOxjqf0isBOmHfpj1NtVDhBt7Kd4i2GlmgRYQhaub3h2+WQrIGDIhULmLxqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ITTaRbho;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A1606A32A
	for <linux-sh@vger.kernel.org>; Mon, 16 Nov 2026 08:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B92A1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ITTaRbho
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c50e26763a4so55822266b.1
        for <linux-sh@vger.kernel.org>; Mon, 16 Nov 2026 00:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794816100; x=1795420900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=ITTaRbhoS4PjiN8GAOES1ZGs6qN+vgkvAKeLRlIimkjlbYipl5xqSb3TUHp0tLBeQK
         8VJ4PUMKS/FNKCoXmyt1UpKQ/ROURNkDMJToB9UBX27FhTSo6eVGNZYMsmBcZSnsq1dR
         Ti2MEJnhemD4QbEQr8R8gaYt2AT1TS0fd5CwwLuE1NYcww5Gv4/lmzn/fNqEDnizVxVJ
         w7vtS8T+P/NNNxsygBQPHeOYgpbIkL4D+msHdPp+Ee/csnwj/f3kJQ8M9JTQCcnWQw3+
         hypYmyI27q+SPyRnAGNFKfouVBKIMedzL/tbBOX0yr1VGnty1WioJvL9iVfMcx+IALE7
         L8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794816100; x=1795420900;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YsacxGE14wOKz6Pg8TZXlOHyLRTqOTqtvBl+xKa/O2U=;
        b=UiIu6Czof00DeuJR3fOYdAbAtuAIG4Vpx97lvljIaNDmMzk3jdcCmXg9g3lpkQZf7U
         +kEgWC/DGYxmHuMxLRP0H3JI7raZTXpwZNZ7JC8v7QgE/kPaL/4AGHMrgeNvpYPNnWvX
         Rht2VaCzFFohCKY3UgSpawSVxisrOqPDpHuIyQX6SjoyEw78ckI5pKfGeb1axCUIBHRe
         EuqRXgFfL/gfsQL53lmlLZhquuerhGDtDmVlFabVdZQOIeGlhug/qo711MSwXTlS3L46
         i2PXpuMKNywDuTa+Oo3AMx59+RxfALZ6BL6LEFHCP3yXHnNUeKyNDom88np88k0U53B/
         F/Gg==
X-Forwarded-Encrypted: i=1; AL+hErFV4WCeHnNTTb88SAF3ixDNI2EHfdpPu5N8Me5/g9a7y6yudOiKPdKPd8/B8LsfVie6/shdCZicCA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+d1IJZ6cxv6jPNxwusEyxer4BxG6xOgtxjxcJEq8IJiVVDxlfO
	d6shok+3uEtroQPir1EgaDp33tPdOOl2KCRGn1Z0PsYZI5ZwTVrMkFhZd0zXXVnicH0r
X-Gm-Gg: AYBFou2umWlLxcbooAk5Ap0Z1qkljIUaAVZw6tf9K6Y8Ak3nDaPJrnjTQLQ+ZvAgQWm
	gheLm+jmWVwwamOlcR9JeJ71zkyuG36XOcBXM04rLYLZ5aUDRFqUbT00fJ9DkSj9Vu0uTiCZK6H
	HrYz809Kx73UAFc2jCkhiEaJ85ibaszw2xuKuwXXj7S0slrW+r5romqLhXvNrUZP/eUJBFduKSq
	BaU1dQV5FC6UDgqPf0X0cY/hANhtCVII+drOAgNU5mPA4xw2PEo3wlu/SQVF1wEefqgWUp05rA2
	FmE1NSmiSgvX7oQY3omp30L8wlSPyOX/lEVehdSAyFTcZyDARyy0V+yaUFQsgH3WWETPnkJFPXU
	Jn5dQjIoVLeIvolSf2oZCAP4ZXXcqDH8CCZJiKouupJLZOng7tFeECksdG3hJOIIf99gDS/deal
	9B9PM+9BsKHl/ESFwZAUrBhzu2ZCwZuQaZgQ9z1Fo1Q5t8ffuHr3UjlR51WVXIkZLSiS+3OfR23
	roouCXm5u+KEYOSMsX/RdNJZBxh9wig48371MRBHuWQRPRRX2hH17/xBUwBEvaohhiuIAi8f4fV
	OH2WvlRIn/RDFHK9menLVAErPFurPqncrHVk4I4rrOkL8vPoTe0xjrlW9sJp9SY=
X-Received: by 2002:a17:907:1c90:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c50963bc4f0mr777600066b.48.1794816099924;
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm385795866b.73.2026.11.16.00.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 00:01:39 -0800 (PST)
Message-ID: <dfdd6f4437cbf8f55458b908ec5347f3189bce80.camel@amutable.com>
Subject: Re: [PATCH RFC 4/4] crash_dump: use copy_oldmem_to_iter() everywhere
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Date: Mon, 16 Nov 2026 09:01:37 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-4-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> Make the remaining copy_oldmem_page() implementations copy the page
> of
> the crashed kernel with copy_oldmem_to_iter() like x86_64 and powerpc
> do. None of these architectures has a machine check safe copy today,
> so
> for them this is copy_to_iter() under another name. But the copy of a
> page of the old kernel is in one place now, and an architecture that
> gains ARCH_HAS_COPY_MC later gets the recovery without touching its
> crash dump code.
>=20
> s390 stays as it is. It copies the old kernel's memory through its
> real
> address mode window in memcpy_real_iter(), and an uncorrected storage
> error is fatal on s390 anyway (cf. s390_handle_damage()).
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/arm/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
2 +-
> =C2=A0arch/arm64/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/loongarch/kernel/crash_dump.c | 2 +-
> =C2=A0arch/mips/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/riscv/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0arch/sh/kernel/crash_dump.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 +-
> =C2=A0arch/x86/kernel/crash_dump_32.c=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A07 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/arm/kernel/crash_dump.c
> b/arch/arm/kernel/crash_dump.c
> index 938bd932df9a0..0f2628872b00c 100644
> --- a/arch/arm/kernel/crash_dump.c
> +++ b/arch/arm/kernel/crash_dump.c
> @@ -28,7 +28,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	iounmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/arm64/kernel/crash_dump.c
> b/arch/arm64/kernel/crash_dump.c
> index 670e4ce818223..c774b3aba107d 100644
> --- a/arch/arm64/kernel/crash_dump.c
> +++ b/arch/arm64/kernel/crash_dump.c
> @@ -24,7 +24,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/loongarch/kernel/crash_dump.c
> b/arch/loongarch/kernel/crash_dump.c
> index e559307c10929..03a136b8be8da 100644
> --- a/arch/loongarch/kernel/crash_dump.c
> +++ b/arch/loongarch/kernel/crash_dump.c
> @@ -15,7 +15,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0
> diff --git a/arch/mips/kernel/crash_dump.c
> b/arch/mips/kernel/crash_dump.c
> index 6e50f49024094..078c0d1e8df46 100644
> --- a/arch/mips/kernel/crash_dump.c
> +++ b/arch/mips/kernel/crash_dump.c
> @@ -12,7 +12,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/riscv/kernel/crash_dump.c
> b/arch/riscv/kernel/crash_dump.c
> index ea2158cee97b3..0820e3db12603 100644
> --- a/arch/riscv/kernel/crash_dump.c
> +++ b/arch/riscv/kernel/crash_dump.c
> @@ -21,7 +21,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0
> =C2=A0	memunmap(vaddr);
> =C2=A0	return csize;
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 85c0e58f1a59f..2a5988b6e9d7a 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -23,7 +23,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0	if (!vaddr)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0
> =C2=A0	return csize;
> diff --git a/arch/x86/kernel/crash_dump_32.c
> b/arch/x86/kernel/crash_dump_32.c
> index 5f4ae5476e193..cb202d4e1f703 100644
> --- a/arch/x86/kernel/crash_dump_32.c
> +++ b/arch/x86/kernel/crash_dump_32.c
> @@ -40,7 +40,7 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn, size_t csize,
> =C2=A0		return -EFAULT;
> =C2=A0
> =C2=A0	vaddr =3D kmap_local_pfn(pfn);
> -	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> +	csize =3D copy_oldmem_to_iter(vaddr + offset, csize, iter);
> =C2=A0	kunmap_local(vaddr);
> =C2=A0
> =C2=A0	return csize;

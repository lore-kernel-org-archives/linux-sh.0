Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792580159;
	b=jJ5FpmAG+sDQ6eURg7FmXV2iO0LTT14u8t8f8alzLnxhA8C5AxDVK+aCEmH5AZ0L6zbJ
	 KeNWKSVnnZBQXalqzb+RXS+unt1nYAbRkYwWo87DoGe1Eb/KDSARHKV+P5pAdkrwBjHFY
	 7ImOabKZwzva50RPG1ezab3qFSWo2phXvrhVI6Sx8NaVt9lwZfi5JAstI7oGpp1i1fxn5
	 1rU7JL9EHSg78BBk39Y2QdXAvKG5QTAL3gl9SoxySVY5mkisWg0meTsElhonj6EwRvAjz
	 4S1aLmBM0RFO7wb+2f1CO8Oo8FpkFtLhqBXzqQ5dFFd3ilzxfYd8zp7E52Ia44EBQoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
	b=QF0BJNa9qLiVK04O7IVQjf4ky33bYE4fGmRMjH40/VEaS2HBETwH4ZE46ovLv+m8wiCV
	 u4pr6EDZh5+TWbC/KYiUpOlv2+6P1Ufm+xgHHUrlyBFpVWallYJo+ynpfbA8ixmqyqern
	 Q2fdj3bHZ4lrhoOr7hKeZ27wHJHyaadOxEbD5kNVK1KSZSCasqLazmBR9UXaaC0sLTeKq
	 5nDSRs23A1MHaR9MDPBxs5DVr+4pH9FdAiiaeZepElOlBtY9Cn8a93/cG+TNzRMzMy8x8
	 gzLvL/0CNhx4FlD8lpQKr+Wjh9Inz2jl2Kb7AK3xYVe0TYZuXLKUZiWgszwl3X6XaAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LStKsrBA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B5F606A319
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 10:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90B5F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=LStKsrBA
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8acda240937so4774687b3.3
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 03:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792580157; cv=none;
        d=google.com; s=arc-20260327;
        b=B5L80gok3qpiJb18tDdMFeYmKQtjeo7t9ewIOMDkCI/BbsQsMFUVk0S7blCleIa3v/
         7aNLiVUjTCc13TbG+xe9csXagtvNs61lxHcP9S7X+O60fg7YtZ9B8EDvkTOnRBzVhGw2
         WySdpqv1RhgGRXYVQGCZDISKOa+G/S3gu2X70u0K9DH/eRc9GlG0bu9QHqpgcg+jKLg7
         XCexIHPvpbB50WQNKMAZm31OqiA8ELWOdU5Qel3EsWO4oocWgsWjQ8P4jIJrmjd0yFWu
         gCQ1qRd/HM0HBOnoIyE7Cs15cytlQ1RaCylaqqm+HyAGPRK6CTM3Hbi+nDJ23JdXd4Lt
         xxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
        fh=M8aj8Ld4Kuk5JvEHdGVb4hpqV07s7TdSEaTVl3kf3kY=;
        b=f+hWlt1GyMsKBbzqLglvmo23nRfASgRd/NhHEgGUs9uLH3n9P0izVIF5r6H6/v9/T+
         PUsBj4mHVE4EFpx9VFwlMY2X8Qju4COXhFYNa+B1rkjKjTdet1b4QvkmUPVu15a3No/u
         W+rlfgmeG/52YatnABQkUdoEhpVknVzqIxDpkVLLLLnttMfC4Jrhq+muFQSrzQCO5Off
         6Uew2RMKwnje3LEZ7Hz9s+oADFAiQ4P7UZtMcCXr9kIqPlaLWgqGRgordDMggXpzUs/0
         NjDHeFq2qU6cNbkaVdkeFXOZP53r8XmMQoqc51FrneAgKHt8Qlo2X5XcP4n7U82ksy7j
         xX4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792580157; x=1793184957; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
        b=LStKsrBAmkLyaIDo7eVvgJ/m9vUfRWLRIyJ6OihLsx6GHpMB7F8VmhEb9hY54nkHT+
         XAsvZTrvDT3kC7e7pHIkkp1p0svg27WFaKT5upHJaufLe0yv7syM14crajjJrwyX9cB9
         RXQCO8tRKSb7PW0WqE9heGNj6QsK/hQ7AT/K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580157; x=1793184957;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4dkFwPF8mYUAaBh9IOGYKB+nWS60kkd0r3c1QMBo9hw=;
        b=Yml0kx1ad1gwwjFBEjA7VhiLYkUwDVa0mfrBugioceqPlYSpSpDUANBcsq+oResmwx
         jyHOlPRb7Uo9NrkRBPOkoWsBpBTnxW4a4KcI5FV1CcsQGFlvQygf8DdgulPOi4N7oZO8
         jbzEx8J1nCSuD0utGceTPQBosasFH85nSuQW4Fe/CoizI5C8VZRKPyw5Yeb95n8slTH/
         Q3WwgHhEmynhimVYHg0yWpuTpVKpcwDc+gv5vfPxV+MY10marh6AlLnhYOEemnmYeBPK
         E9mFPHfUHYCckMPXmdOxF19D4wDrzs2s0K4MvNEW5qFflKDlIhVMi3Zgpeo8q2CG+GYU
         bowg==
X-Forwarded-Encrypted: i=1; AKwUvBx5cjM24sksX3/ENzpmQlvl0aHT+YYqiC7vyg8DINvfPHuvIhmgTVU2sFe7bn/uc81J20+CuvLd6Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYK0h9CHlTIfCmlYZmkMLMOB7B78imK2xDS2GDhswN2ZWt4ULE8y
	4EhgF6tmu4UojeBEPLI8pqmC5KXXf9/HZXv2qQHiq10VRsOdOtGsluAb3Yjn9rad/Ed/3+Pc8qV
	tZN0l3OPSIVWXmT4NKjgkb8AT/I+GPpKa1Bmj5KDnfw==
X-Gm-Gg: AYBFou3t0RTj6ls+mMiENiSKvVP8CAS4nFeBB1KZ1G/NK6TjU5ApoTrBPFDFIoHSKEw
	Y56hi3lFZZrd6RQHo00XfVjrmKck2dbbm1EsONYY0bKf2ts++awU7AKhTpuXbXSwsJnnuq/mX8V
	A98wRtyS7iOmG6WKiOluV4fCkkDDl+6mlh8iGcz5jumBt0mtZWjZNBJ6OBnSEAWbBuFfnHsLo7G
	m8J5YYcrie0wQFI+6pqmTwB7zbyieX/7BuA12b/qkxXOOoYwDbdHQwwRV/wCdswqBZ/0/AXNlNQ
	6Xs8C0O7UQzrbNozr3Js6B/HVC6YhXy50rm35wwpSVekwVwERML7tPuNFRQFpbn2hXkyqqtYXRk
	2ZhWllSfMR5pMsR6d9Gu+guSOc1jNHtaChqeWI7Y=
X-Received: by 2002:a05:690c:e1d1:20b0:8b0:ad90:98c6 with SMTP id
 00721157ae682-8b134013d3cmr5679527b3.35.1792580157475; Wed, 21 Oct 2026
 03:55:57 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
In-Reply-To: <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
From: Daniel Palmer <daniel@0x0f.com>
Date: Wed, 21 Oct 2026 19:55:39 +0900
X-Gm-Features: AclHuK-tt_OVDrOG_j7NK25609Kp5bxH3a2aysFucE6vALWwnla60mO_ZldS66Y
Message-ID: <CAFr9PXmntwx06iMc200d9HPoOeCE7XURpS9jiWhB3ud_+QQggA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Colton Pawielski <colton.pawielski@gmail.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	dlemoal@kernel.org, cassel@kernel.org, linux-sh@vger.kernel.org, 
	linux-ide@vger.kernel.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, 
	fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Colton,

On Wed, 21 Oct 2026 at 10:05, Colton Pawielski
<colton.pawielski@gmail.com> wrote:
> In testing I could often lock up the board when transferring data over
> SSH. I don't believe it's related to this series and am fairly sure it's
> in the 8139cp driver. I have a candidate fix that I plan to send in
> a couple of days once I've tested it further and there's no more
> lockups on my hardware.

There seems to be two issues: One it interrupts for every packet when
the 8139cp can hold off and not storm the processor, and there is some
issue with the chip refusing to send small skbs so the network layer
starts locking up/timing out. I was planning to send fixes this
weekend but if your fix is one of those, send your version, cc me and
I'll test it out.

Thanks,

Daniel

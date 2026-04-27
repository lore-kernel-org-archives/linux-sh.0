Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63553ACA7B
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327087; cv=none; b=DsjTB3oV29OsTYV4dNg+H6s1gkejK8hKLg/jM+4T19Jpla/aVzJeX/HhIDcloY2O3UmB3d90MSS6CRf/fyQoukX9ckJ6m7Ho0+K5t53PrgTaicFURmVWicZMhriPzCP10iW8ikvEB5ycIIzLd4eU2U40BgOZvq7CpgCVvVy33bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327087; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ks70JuF2hPIH7/4Lp6vUlzANNOJQ/TFfWa3gIIPdbQjL8Ud1pNJ6nIZLbfDv7Ke1PdLKX37NFx5VcM+504Z4HLONOGN8WGKcBgemt1Y+EkLvjd3lJwL6OHAfrO/TiArTtzmxArEn1F0T8pgpSW9r4uDKVolm9TXEuZmhegTzrpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MsT8rJm/; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MsT8rJm/"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so13205387a12.0
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327076; x=1777931876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=MsT8rJm/fwAnrHepgFQrbJC04mI+ArNCEnnQ462IRE5EPyO+9ipXKAel3ZKfBhqVSj
         eJYpupj8VhdBLNDXteDUICHh2wGENkiSwtu8RIU1Y0VdgJFzmconuWrC5tBb0iTPhzYg
         3TXHgUPEOjEL81nT+ECtm3g9oQCsiPBqudHEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327076; x=1777931876;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=QYUnKD1Jrbzo0Bk3vcKMCYiVh3DXUK47wnJFrUtekjZL/ej3qP+BqhJDLuCWCajvlN
         NtFtyW5+xNjxTQj7cI4C8eWtmzIqm4qNM52k6aG5E4zi1vw5g3ySfBHnHdMKR/CsLYMF
         Ue6SYZZ9roepISQmqYfuRwvILMQbBIAGUYq2Hq+V2zuR5FcHcJbb6IyDfVbWKRj+YLsZ
         hpcSIerfUkjSxCGVqMGQT7Iy7V/NdmccDMVIEreudPjhTfjYnqtPLkJYe4sCNDmRP3i5
         0f+4Z6ybkV3TZuseI+wee1bzzjnuLczHUeDtkKWzdVLG+EvXfWB1TOyDO8JenkJxrawA
         WA0A==
X-Forwarded-Encrypted: i=1; AFNElJ/KVcohwhHGGiKkYGW7whwATZsE/Pl5f+jHEH3Utv5/bahrBLXlyw1QLEq9m2DX2hAiLJ6cfFSQxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNPHcEH6JCaFHC3CI8lhEdlsTzcKjuo8+GSY6aPiJoCfffyUmX
	zR/R8RHM+dcA9vhCuZOTrs2IPrZnaZLelPSgG75gJ3BGsMChGU9YnSK6oG6tlN+o4yq3ClwyPZW
	fP+rEX4WzZg==
X-Gm-Gg: AeBDiesZBmBSPGqdsuNUKAve5AkSt3RQnaX6Ih9miVxCvk1dPLm4nTEfIKokhK90+h/
	yE8F4cf8J1Bi1afV/dKBsIFZ/rZDhPCNXyyF4ovsE6HgBgZIJ1k8JIScO0/c24eNS2735yjKbEU
	exKQbHjr4uyPVayMatlHltgnRFdszP1LvFHbAeMzYRnqHeHx3V6qEPLpSEflkGccP3M83IVAuRG
	0rbSLPy93472TIHrGWnOvIgwTnjG15UWhBYKDFMPn/by6TmVORB/YmBvXLyoarYmquYgdow9/kv
	2o3o68uQ9arH8NZZ9Gr/N1WpAr5bipEeRdlWkYUDAommbQeZXVJuamTuuWlpwgGFrASwA25fpLg
	gPELoRXb2wSzEDR5Uhffk477ynGetY16gDQ6TPgOs6ES1scC+vBeVW2S9ZraL/ip0Y58hsioFnf
	TLCZKfvePgnDYGnfL4YxeoVz6qoCD+EAfIWZLdA7SOWmaNX/I572jzTfAaZfYaQ3Z/GYYykAjM8
	8+zgHnooiM=
X-Received: by 2002:a17:907:3c84:b0:bae:2adb:1461 with SMTP id a640c23a62f3a-bb80100e70emr29996166b.9.1777327076002;
        Mon, 27 Apr 2026 14:57:56 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853e9e0sm11652366b.4.2026.04.27.14.57.55
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:57:55 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-676e62faf2bso10759117a12.1
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 14:57:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/kpSFYkPCYc3A1knlrsGzu7ivPK9VhdH+btxA8I0V8SbJckCP98iSBTMDTBHuL/PxHe9xSdu9Z/w==@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

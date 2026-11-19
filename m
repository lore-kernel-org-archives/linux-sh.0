Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795067159;
	b=HxWpt/f6WL7E8t8dR+3DxN6zEOGRw4CmtdCEa2nKuOyr0fwt+6Fw8cnBp+AOOsNLItAk
	 TAOQ9QgmvDFxPX2YeTkskwsoWrlp4fyIV1/dPCeJL5sm2xXfeoevKyqVMQ8RpGe7cQ5lT
	 bICFjre/dsnegBSrvPoZOfw5bWIch0lFeQVpaTxaqUIYnpsPt0cKYB0Z+xRXmORb5pLxb
	 6Sg78FTsbhcPqjtlBM1+OX3OoOdckJ6DA8p3/Uoq2WSHQrwubUg6/RPkhqXdvfCUZhu+j
	 yhkRo7/J9ro3NTMHp1lRUEGAxw16zzLSw8oY/FZMLOis+W4ESTRGyKlkQoT+T+64mNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=bDc8ZZyQdvLJgz31a24r9dLdDgJoYnmRFOVaN3QCoox0vPm2zM1Ye0raGvSZZAG1uB0c
	 iQCBtm++jdQHdAWGlQ/g3m4bHii8qeRqWFjHia7imbN6nM/GhLzU4L6Nx1EkGSXkochD7
	 mEYJT8d7T/e0jzzja3X/omzix9WWAIvoGrcaeq7PCiwpMAkAmjjNOCAL5IL2PEDTFiCGS
	 6ADz+JYdB2sCzysom6LlVs6ysj5EOGMYFddePOPb85qXZ5jMg/ofCsSNDB9p0LUV40lfl
	 MVSJ+lvGkX4kOaILZwW0f7LYkUVz7LsZkgheZY1/RseiOiJz/iFRzZUdyl2dD08eYtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh;
	arc=fail smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC060A2603
	for <linux-sh@vger.kernel.org>; Thu, 19 Nov 2026 05:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BC060A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55be673e029so117391cf.1
        for <linux-sh@vger.kernel.org>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=SzNJYjii/8/T3Xz9KPTCpGGKHR2tb519BHCwqL1gMD5SbRDwp8yqZYm7Giy2y1tuKz
         ZpKKCLOrKQ3Nr7mxpvGhVRGVS/kRqLqAHo9ERGKPN87vDejxFCVV5JQ4pnh7rucxvPLu
         26DJcgVdPa9M/hUcaN42H+Jlh2ounD+0dQp7oOFRKdr81tWnhWeCVenYZKMfxwuH7eJ3
         CNIng6+dXCGb45YwKgSuvJO8MxBUHEU4zZBra77V/jJ+s1d2iSw1zCsP4deMKhAsl8P2
         3QOLsCEFFv+HsQczX00cQe3STGfmBSn7wwUx1x8TE9fd1jBI5TKD9jnGq7w/zQkJdcWW
         VdmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=g4fYGpCXJSaoGd+/lmJkKZDoN3s9NC1uZ1RVoCsGTfA=;
        b=O9KvKUu0kBc1J7X52YzL1DujZplElHI3mshgeMI20Trbw+8wDNN+9whgmkPJ7et32D
         hyot3fo2Y+f3HdHDQB1DsgnmlNG46tLI6A+1F9gZuxa+7UFQVAojRJFdemHzQ5yoxvp7
         uS0mycnccgQcz5v63X5uBYoHlR5RFjd5JZIoGPpo+7ZfE6qHdZvXjnE8Br+xTu/DQ3Wr
         uzcoefoCcXME1bRU7Z3vRiLD6J8JjHHXc3Ths0VyiwjmPUlLHQjreCSZuzrzOTdRxNlW
         zodway3UY3w964T0acoGSXjAaYiWyi/EBQ3DbI+eYpZ7ZtWQ93CFpPV8vat3x408MKbq
         oXyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=G9sTcZLhDZovHsgCx5Yv7CDMxJM8G5FDawL5JBd36y8NAy88YZsvFaSPGxL2OJDQWl
         D8l1zhaslplXpC+LH5CUyVM6fiya54hKkm3044CoRWwH6cYkMSxwEs9IE4R9vJJik3G9
         PaGymfho5RIhVhS+d5TUg18WON8Y60WBZxMM5gYyXKhy/KCwkwn+iT9No3gldijeO5tx
         xp5Gg8oePFUL/bdSJWKKtm4OA3cKKfEuUGn9FzCr/u57K1nN+6BjTy/XuUfYpf49AuBU
         GF3mrNTIV4ZWpGu4KegbuhUlLkOSriAaKH7KHmdnomUVdJlrrfe8QiZH1hsMd7fqVOCf
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=WOV5g2e0uwm3qv/cMbv1obVrniupaVUc3MbU/+0gQBqfVGCu5RoNIuAuSBzxx7+yCt
         7k6cnKwsChloeIJsm/fVvAMa6waj6arj6BIIQd/AbJAvBUhyl//KnXkW7bkcMBO/51jt
         difNNKoKSzO7AWbywBO5JLtP9x+yl33NIJIUmzzyb1FQpWpGzj4uZK8Yp2shTyfXeJj/
         IMzU22O0IuYZ1AJ7oTJwISJkoKyEzKl1iB5fkTJnY4ymuk0Cp83WkkkQUZiYXZmIg7L0
         rrPl7gy6WCa7ZwgtGxvOLl1nekhXAJqiV673ubWuZ8JdwBVEZshBgz+SILxr9Hu6dJR/
         Achw==
X-Forwarded-Encrypted: i=1; AL+hErG6xHhuV+bcAf9w6fII6FG/fjSXxKI9KLlNPpqgBG2914DRh4AveDx3YKOEJ34GEBXy0XiuA1k7CQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z82XDzxLYBpJso9IRa1QYTj2x/AirC2F+BpBPTmtXCzIwlujKm1
	pRcZY59KllcpFcMLTpUKruAd2Cm8UPfxHEbIwk9TTWviEHn1VlTa76v/0i+D1+6RbFe1PiFtJob
	8WyrObv4BtH1rKeg5rnGqLYFTFbtiQy/H1gPSkx7b
X-Gm-Gg: AYBFou3IUwI94bkR4/eCu+5OgDulc+8rG4epQcbknS0EilsR3VjMA9R4eQW8KHYEG0g
	17JXVKXGx/iERgQiLXjbzr5cgzh6/5OtZCXOpzZrrF00iM8vGNhd4qlHJ16iZUnnqg4kn6T6N1E
	6O+fDZhwcQE4xXY1KiB++EzeUkJTX1nojWvg05Ylv6/Rry8d0WEnwA1/6xBRmRK9G86Y7DHr+dr
	xUs6hZuUKGadz+A2PMKJlUnIFElwtK0pl/vs5hd7qpUwS/XHmM2NcGh8KK1VB692mrngFyeNtLh
	UxwrIovjElBF4efrySTV9bcnj7rCKVSHmzyyaB7b1IJQ+d4hYLfVsTVJZPDKWmdN90jR61mYO2Q
	NobZTHWCNsrf6GA2nEwl4mwZzeXUFDKQ1Nn16
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>

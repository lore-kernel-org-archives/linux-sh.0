Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794263409;
	b=iDyVgrpQ7z7MRKxDCNXqDiAIRp54mwifyb2aj4aJXatJMwfRhJT43dDoeykhmO4ivQop
	 yGvG73GLNzNIlYrChvkypQk6gOSFtEah6oe2u4xgSiJUdCpR+BpKPkbCY/VtrBg68ueZK
	 WYpoI8jnsAv6wQGbB+A3KfNEkT5GQ8x3m1MbqKq0pATABNpzEwpr4OQ2sNZ8HFUqr2clD
	 hBGWNAnsSbpzU9gJgcZ+g37eDnSZctRRJ4tqXBJ4SOWLYuiknm7Nh7ROpsZpzvkkFtQn5
	 e46GsKB6/rnG1Ds5sIhhmrIaVJ1h+qycBu6S5PKk+qRRxyzI2exN8vShgob5pBRhTlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263409;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
	b=dT42D4bHc91WAjTNOwuKcVgLmdR5P7yHPSKzFxWyiHaPIqSTYcoUs+Vj6roU3QfxukQH
	 I3TgMGYEbONFkmwYzswiwK5WUeRh51fY2qnYa9gdIuLRGHrTlnuQoNJ2On5Zdgd9TrcAp
	 MDVgf7YS2i50JTCATmZTVVTeUP2tU5W4HeqkudsPUGlvrRk60UuMzw/jMgY/8j7VaqrTa
	 qT9KASkQgNaB0F4qkNhgU3UPuGfQ2Ss8Rvk4RBo4SYuEmXiFlGriyzjhIamd3ucgiIZ0B
	 NeKTBhEjDm1EFIzouP1UHcF11FKaUJ2QiUe8D/xkeiCP2RoR/LvTIoVlAIP48ReHOjQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4908E606A331
	for <linux-sh@vger.kernel.org>; Mon,  9 Nov 2026 22:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4908E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bc6ecKnX
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-535f598d126so39611cf.1
        for <linux-sh@vger.kernel.org>; Mon, 09 Nov 2026 14:30:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794263408; cv=none;
        d=google.com; s=arc-20260327;
        b=juWNtOjXWnxfxeSAbmzOLMUx0Kw3FOkYjl3UIrSSgO5PcxBC7mMsy1hMfZkR/j5RHj
         j5NM4fLvykwNiLrkd/KK9wOFDqr9gDLG/fVoYZ3DjIOx4GAnbkiDUAcGCqYBrO5XDcPw
         b8oT4Qa1qsTZsBZD8LPVFBJh/v06a/ol85oG9aLI91+gS1vSv0+ErpjjJ4u0WFGhJQx6
         wwHxDy30hySHKRdwZ4ZlmMT7/n2UNe5U69ILlYNqpwpFJkK8IdwYX/7tsRet5T5DRQ4w
         hvQmy2X+SrT5QIj/8X4fPdvdcgHwugEOVUX8ldVxW0X0pwYBF6l3q4BUPamzF+JBSUkF
         DkYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        fh=aGqepDdzsQ7YZUibRGhRZ/0uulD/rAJrpkOFd23B8T4=;
        b=bFtpI512VC87v11FjjrnJ7/Z5ot9RkbBNV6N39gKzkJRGFeINq4Um88tD3bUcsv4SW
         mItQ2lC3NEK233T5L9EUfbOtYdBeJhdbQgZuTB9BRWOtRAkHXtKhShCMFDKOL5hK6ntU
         D/Zzy3UxNk2RLVQqyFOmfZXy+pQtE4cK5kgqyo5Iu+qTZ7yZ2yAKOZaW/HsSIJ6XFSoK
         /zqjPltMitNhbJovCyNcX5wb7399G2CWqITsf0RXOXtqOkF4EBwyMbeBdtbg6xukWL2e
         xqBfvVcLaq52O4uH13GwWB9D8uJlcToTMPBJ4pPcjJLjTRlPW+o40S+hh8QaCTbful7x
         93MQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794263408; x=1794868208; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=bc6ecKnXzqp5zahKN5US+W/GLFNu9bOCxLTorv75CdL/TyOgB/Qh6QFUi86M3M/XI3
         3gbxOXuAYS2+xcjqU4SLj5C27dCKM/SCCgBGdSbxDV00eICb4MzgEjo9vjECQ1QTCTmr
         MgCtojiqIWlVyB6AunwAs2qSQJP0tUdJsdT71C1y4WilJg+rQa++O5B+9FpAikzFpyGD
         TU94u5aUZCMHCz2bEPFushfsTW1bpin21NCA0WBKSF7omxyVw4eI3lnqeaGfI4JhzN5X
         ZQZwi7mBvwRBGIVH1EKWZ2xsmVHzuYxoBrVKANockiyw6pDDJKKlw7J5nTOQpM4hDjUm
         KR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794263408; x=1794868208;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S6J9qhUwfhfejNNDnNi/t39zME3R/+tshu3QmKCryWs=;
        b=ElwqBJ7epMaC9T/ZR5DyZx5O+rdxz80QqHqQNT4i7jf4k0FIObtPkNfYrsCFaylko3
         nv3w15jKlFqy4P/lGjpVPHc/8WJjGHT13CMO3U8ZRp4gn+shvITAKdW1a6G49IP6pglT
         Tt0uKWcxFnl39Ct+9C7khp/ZDkq7PROkOoKbxj6S8pUGY/5I+lNcFdXCLGl62vO+k601
         PqLWN0ebhe2ZcsonLrufJjPMI598lS+wGhjZQ7zaTIg95VZUYuZqgQoNKII8CTb/K3Se
         x1R2F7tG3Jz6X5qalbr3NiBNsX60HoGja+nkPdX9vcV/yNB/y3vK7wyZtiGAhyS1rP9n
         ZBKw==
X-Forwarded-Encrypted: i=1; AL+hErGcztlSqZO1jsH9nmr8SgK/IJXcw4PRwJH7odEDmcdeMpPIi2w9eTmsxZtzKcBW4ZobrpWYMzggzQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xxrQpfYEy4awF91rq6FIVGHI8iwU1ZA+wdtMRdP/OTXntf0pK
	n0v5tDn0El9IFAHJhqOoMurLnI3xx513Fi/i5iTrUeGejzUzOmAGxgyT7vD+ou5nJ+S8PT1pUP5
	zJSWmpFYDaHWw/XJlWo0gnirMyJoSdrRv0vDglqkh
X-Gm-Gg: AYBFou1gaJ0FpBIzEBLM1ZZuxJSOzxK/08FG9yu91P1loIYSwGpf9M6qaKZQVNw4buh
	LaQNb8mzIEfeYBgH030NWnUmBbI0SNxXSN8Dw3Mq9me+fnwXoyeB4INaszOzj9ZHnVPyY+DQXvd
	DvASHVair7ecy0XsWaJwRVfPCL8KmEBhbo90qOhIOFXpaTTahkVxcXO7ErjqjmtltxJqP0J40lW
	vaC134ymPzjhVxj3trZiDAKoC1hyQV0iZdfTo7kNBi68o0hkyFOxxyW4qBqNxZRyDmGY0WZhDhj
	1z4Lss7a7akh9KLia/7ULVX5bf19TXuQRuUc2Fynmxs4D8n1frawQ8ikTlPwm6OOok7ZZkUxIF3
	lTpIEOOy3FjDTXUDGsSBOqMfYJoan4blr3yNEUfVIpv3momPiT51Cm/9BZ05Nj3IgAGQ=
X-Received: by 2002:a05:622a:1b16:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-555290bb288mr6464421cf.0.1794263407457; Mon, 09 Nov 2026
 14:30:07 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-7-irogers@google.com>
 <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
In-Reply-To: <b8d171de-52fe-474e-96db-d119840c6240@suse.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Nov 2026 14:29:55 -0800
X-Gm-Features: AclHuK-dlWDp0B4FdK6V9QBR5LM_sA67_T-19O3ovPwDJ5RdBpzojQ18ICzxF_E
Message-ID: <CAP-5=fXd640kfaR+soPdiEV2mfqCPGDANCt04KzaXBphYP4Htg@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] xen/sys-hypervisor: Add release callback to hyp_sysfs_kobj_type
To: Juergen Gross <jgross@suse.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stefano Stabellini <sstabellini@kernel.org>, 
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

On Sun, Nov 8, 2026 at 10:56=E2=80=AFPM Juergen Gross <jgross@suse.com> wro=
te:
>
> On 08.11.26 23:39, Ian Rogers wrote:
> > hypervisor_init() in drivers/base/hypervisor.c creates hypervisor_kobj
> > with kobject_create_and_add() (which allocates a dynamic kobject using
> > dynamic_kobj_ktype), and hypervisor_subsys_init() in
> > drivers/xen/sys-hypervisor.c then overwrites hypervisor_kobj->ktype wit=
h
> > &hyp_sysfs_kobj_type, which had no .release callback.
> >
> > Add hyp_sysfs_release() calling kfree(kobj) to preserve the dynamic
> > kobject release behavior.
> >
> > Fixes: cff7e81b3dd7 ("xen: add /sys/hypervisor support")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   drivers/xen/sys-hypervisor.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/xen/sys-hypervisor.c b/drivers/xen/sys-hypervisor.=
c
> > index 91923242a5ae..0e8a2cd69fd6 100644
> > --- a/drivers/xen/sys-hypervisor.c
> > +++ b/drivers/xen/sys-hypervisor.c
> > @@ -659,7 +659,13 @@ static const struct sysfs_ops hyp_sysfs_ops =3D {
> >       .store =3D hyp_sysfs_store,
> >   };
> >
> > +static void hyp_sysfs_release(struct kobject *kobj)
> > +{
> > +     kfree(kobj);
> > +}
> > +
> >   static const struct kobj_type hyp_sysfs_kobj_type =3D {
> > +     .release =3D hyp_sysfs_release,
> >       .sysfs_ops =3D &hyp_sysfs_ops,
> >   };
> >
>
> Wouldn't it make sense to have a common function for just kfree(kobj)?
>
> In your series there are 3 instances of .release just doing kfree(kobj).
>
> In case this is not wanted or with using the suggested common .release
> helper you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Thanks Juergen!

lib/kobject.c already has a static dynamic_kobj_release() that does
this (and there are ~15 other places in the tree open-coding a static
kfree(kobj) release wrapper), so include/linux/kobject.h +
lib/kobject.c would be the natural home if we exported one.

I kept them as local static functions here for two reasons:

1. Patches 2/9, 3/9, and 6/9 carry Fixes: tags, and keeping the small
   local callbacks avoids a dependency on a new driver-core export for
   backports.
2. Since kobjects are normally embedded in a larger struct and freed via
   container_of(), I wasn't sure whether Greg and Danilo would view an
   exported kfree(kobj) release helper (especially alongside
   __must_init) as an invitation for misuse on embedded kobjects.

Unless Greg or Danilo would like dynamic_kobj_release() (or similar)
exported now, I'll plan to keep the local callbacks for this series
and can send a follow-up cleanup for the tree-wide callers if
driver-core maintainers think a shared helper makes sense.

Thanks,
Ian

>
>
> Juergen

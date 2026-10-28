Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201766;
	b=sxhyWivkh0izDaA9ZVGKaN0oa9373P5NBb1m5E0q3oYuYm8VzSLo+ezU9pn/04Emktw2
	 jVMVE1dHDSc1suCtgzYi5W61mmf5KHNarFOitsFEgyzOEAt7fjXNm0Q6m8zgtXPVgSNA6
	 svC2TB1VgfnvDMiPpZ3QBv6waMUIdJVibXONQRz2HAAysmGeOVQ7rgRZBH0sSXnaDnxXt
	 Sc9KyFlbXLWcD96AUbHeo8Y4kbsCgsdwrK8WrOIDBpl2H/1bVRreXw1Ubh1ziBcehQ9kd
	 QUaV/DQ9YcCgh+43kzG9Prp8qQqFBpIBsmjoYbkcFex5DsqZtVW19Mw7Xs3zUbdocBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201766;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	b=xuO31vu+VpTF/TKK+IMBUIHmOhWeuYkT5FKINpZMAcsEx0rVQvq+G2msQgFTzDpg+70M
	 NflovVAujbZrnQGK5uslpA5on4kcjEVicv2RQ0Cfrt7MBUfDcTViEO3/Po2dHrd32MEXt
	 J6SATnt311xtCKBbNpOI8lN45oEYE8LHlR68CD1KixToZOf5cfMSI/jmBowD5zH4jjBOQ
	 bfd1kvpvy/I5K+lqVeXbbZ3ZU+RtdnePI+NG1tBvhGeIyZXsw12NOKCiLYmGMlTf8uLzs
	 q5fP9A4zG1tCEn9NZNl1DgYoPZaffgXKSIa4dRa+qdIF/kFnUsGGSjTN4P6v3sqFIgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932E606A322
	for <linux-sh@vger.kernel.org>; Wed, 28 Oct 2026 15:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1932E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535f598d126so291821cf.1
        for <linux-sh@vger.kernel.org>; Wed, 28 Oct 2026 08:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
        d=google.com; s=arc-20260327;
        b=ooSB6BuNpo8atojozcxp/BEIZQTGXyJ+0XzTPjmbLjEF5U7drrx3uDkoHro1jqNoLK
         Qu89MyrH/qhKrc9+KNpPpaiRt0mIYIE5V0C8qHoQdhF6wZ/77L1rz/NfIgC0y7Xgca3Z
         GkuBlRfcrgJYN1QE+lUtroYojB0UmYnEpiSuDcD7a4FM261F7oa/ki2KoQHww1Y69HA+
         iOAR9z/VIqeFKCMAywFbXCFcgqafSUSw/j6dNs6wAc4isZiWoIzdu6/Brsc736/i3dFd
         d7x5teKRxrs5voWjzyP4NOIKjhvyzrlaIwbmgUacAX6uYAF2XJ9mYHH7wDpxRRhXaXDa
         VatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=Fk9cG45mQ+Mej0oxL6QfdgrHyrrmCJKCUxy2ko7kPuU=;
        b=jjQVwoWkg1aupvBr+I82JEYyuu7Ua/rBxZrOkJgsOZceYvHEK49VARHqlKMG5kwx6b
         G3dhi4x1h/Jsz0p5J56b+Gk1IuedbSFhB2MhQnhBIMclUckdnZe6Yn4uNZ0pXL4ukNI/
         0BeoLjo9NEDWinUWYMOnU0JnYqPIx51XwW4MsMdvMrRMFTvTZDtU0bOtGx28oT2hidgR
         NRdkakSFQziHXMrX0KgPnaMZqlniTDSNjHT4cPQvnIFe8dWI5mU/XK5t2Loh6lcPyeZ7
         UBKLKaeAcE8QLZSerES+dyrr2AGIil/BfqvAnsANdGrri2M6lVazc4Vo4+U0Z/eMFw1X
         9/Ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201764; x=1793806564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=iyuv9E6ogXiaYB/Kf9bGMjc5uDovw1VYZpmRLrRXT+kN2fxJMnJdnor+qZvLAhWzf5
         5ZpgEidLwgoDr/m7PqAQNgkvMJs1jQGMfEjgDsfaqWJdA0ll7UHpSzdRyuFyqOtcPvQf
         74bwXpyLamSNVYlWo12Hkt8sY/BkzbtDkw3FeAjFHel30AzWVvD9K5nLau0ciJ6j7CSK
         ZH4qBM8JvT2aPZPJYm3XwzxSYHZi04WkjIZrQEfBjgxa7Wsg9Sh5hAk/6QBMmPYkwRlc
         e+Xy3nhgo0JAgGmpn+QnHGzm1VxXA8IyWASy4/EEGYKtjCnWmnqGfUf8AjkGoqR/opbF
         W1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201764; x=1793806564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=wcMT2gK++m4xrnQLGZazQK1iIDoDu7MDMXfzmwVwLDFKK8kPsnis1DsNse/qLeosGf
         uCjgriWnYDk8Y8JqlIloMVTWyn+aejXPBSa0D55DLI2ybOPXVQlnHVigamLi7dNNGGV4
         hdhTV88ro/NfjACF9HkmPLvxUFtMPIg7nHr7oquyEeju9eQrtlrxhQjKS3vxVCzihLXf
         /fh5+uHYyQw6T2QGm/1zIQxBVU+gMBdY4P20DDRx5uDDKDJg0H97qvGsx3Ba5CTQgA2v
         eh5vJ5QxseyrUbhkgoYL55fJPkxNMavMafswDv0+uYtkS7y5OS7cNljD8KB215sbnT+o
         0mfA==
X-Forwarded-Encrypted: i=1; AKwUvBwkDO5TefOkgbZjqqY3k6ksgq2QmWcctqVyf02PP7A9rAg+g8ntcP8m/+FejIBqUwC2unqfZhXmvw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdtQxsh1iYhEvbtphdtUBydg8ateYlAAFmv1vKglyhBjJbbxgl
	l+OdAoTtFQrCrWNSyB8VivdkLXZGzuOVw+4uYK6GEPwkQzhx+FQiEOfVapPSntyDr9dyeAnDIlj
	KtROmJyxtFKiYa/dtDchjtVLQxJUhjOo2a43BmGGL
X-Gm-Gg: AYBFou10wPJIDbIank+jmgPybBnv56HnSau6J6CLKIUTsVOquP9SkH/mfH2c0TtmGFr
	/ynN9tL8dSTP1BqUBpLVfm/1z9reWzSLIqpHD3yOT9XsJSBGUBz5D/k2+Y5nVICIsPUqoAB8V/x
	PI1M2g7SJpN31u7PXxdVU9osjtiS+TS2NH8PilgUnfBeY1cHwO+pAFTkI2CNsT04E331CKKE3lJ
	cMWrrKF0gXSr/hVOevo3L8hv/ecDDsFuDxVme3uldROFklUAkt9WvQvOWI3aYO/OdJCrlz2klNv
	ggfu4KC+zxB43sAMDCLDfs88SmopIh2uSe06zitkZosrinMDNuMPGwjRFPU4V6weTScgGW/rYIP
	21VGrF2nB3aZlUQdGcewX7LbOvVhS+i4/2WHau2pApxoqODgB7If0A/352+4=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >

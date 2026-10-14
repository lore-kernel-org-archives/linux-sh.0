Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9035616A7
	for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791996100; cv=pass; b=byjW2xZtBMeziFqnaztGWzlCHhtf0HzRZ/x0jLpAhW5iZ0Z578fGDHWEmxPLHSRDGIKhKfPvGFTiFPDv3RR/R/t6rsm1cHH9HMGacQzG1Fb0qdlO5dcgBi4URm9T9cXvmjNord1w+G0n9hwNCS7W0qfdBtzbN7RKdQ84RN4Nu/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791996100; c=relaxed/simple;
	bh=3mwSDPTFjJGkaatL1Lo6Mh8o6JdUk3CgZRH07sGguXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hlog97HNCX8TDOyyk55Ir7lYwDVkJOxjxQE8oKsyLX9Pv0q5aqakeZtQApb4MRSgEi0o+VjGYbEuqfBNMrJ0Wj0GaSBGXXrlycBav2mRgLt+Ep50uYOyDzvL88JJ564iEAqzXKIrhIBpYgCFwvNuzMyVza2ETu4a+7jRTSDTO68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PSHV793O; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PSHV793O"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535f598d126so605721cf.1
        for <linux-sh@vger.kernel.org>; Wed, 14 Oct 2026 09:41:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791996098; cv=none;
        d=google.com; s=arc-20260327;
        b=Vmc7sSTKtFZzadFcvYIcaLr613AIOXDqi8IB3/o9muLXnzV1ditVNquopuC7GO5egv
         YiiISNq96NtASCKEGXUTmkQ5MmK0uabQJpkUfzvU1ZhbrUGpnxm67vt/bi1lJj+Gxf2Z
         +SaZCWnFW8xL/TOnqx/5vZDBfOe7wr4CkvQV0oSU/HBgRKIAowabIpRCM0+YqvocLfHN
         CL3koLIjhyLwmmKCcONY3aZcr0zG2zSORAFGqEaXrvo/zOSwUK15BOY1S/QFSpJqA7SM
         W++3y6tQwhKZQCIX0GdyrpcsMx5bD0vK1BLSHd57BlWrXIXF71+8kwEJXN2lXYfLgtDq
         ywZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        fh=WPf5KF/Js3FhSeXkKyPF0ATDyKngUrTqMLfbfysISC8=;
        b=QyiMrP0y8hJTNgF3PFUsurjPnR96fDBDkf7JUsDzlt+vo/A+zNWFLKS8Etvrh/xWWr
         Bl77O2/aoltr1m2dDn6Wa5LU8DlfiL/615QpVG+Gvqx1NITUJTN1UaJ1JJba/Kq17JuZ
         +PARm6qyghcGv53RBEXOeBL3pIhqP9o1Q388Dcl1+aPmeo7FmFEQlwDW8u133vFX3F5V
         Fh0xxKuFetrC+DqRJhLj5/v/4nZ3ivlIEP5Yd0jRooHj1jhWhC+x9uQ3fTlDWvZi0B+z
         ca5kePqZJeepqKyDWgVcFQwzGfyy2rUg+fv80QlZ77SEZO126ptEYAkaneIR9+kZzFwc
         t9bQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791996098; x=1792600898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=PSHV793O39//GSS5VtLaFYRrP0SGllChdzMcn6ZGcDyfZ85ESv9NC8wIeCl/dvte/B
         dACE9DAz46lhiOh3K4PgqRYjBoyujnaqj0SJuXq9MCwdaPNnp90m6KVWLbODsv7i4ZYr
         yFwFt6qr3namaz5gqvVnzSO0GsNnRQ0Gft/WEhYzn74CabNzDwt4mRqcA+DpejTUraFe
         5aElp6XMeYVuzhWachsTF+v4P39+XqDFPKsQpnofV9TWkL+dZ9x3Xv15S5VHyWP74hk+
         fUmrxBEg51fkCKz8184kICpKtFLDn908ULKD9tL8rqzKD+xoFKnzUH0iorhDJNfxtpkB
         uPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791996098; x=1792600898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NIItl0pCQ/aBq2U1h8kgQBz3yZb99mdO46VMaoMNnUw=;
        b=mGd4gH+2yFfhcErMWkGGs9dPu0RThRr4K7ikLNUfsakJY5ZHZ5w9rtBuhkh5qzE921
         FMp7KXCjx42SV6ana3nl6lv3CDIXpdy3zjjiFdipkQClHl7jaXCd8Z5ffIt+ELpaJXcF
         Bi+mani3s8q6l2TjHAMs7zdX1HIiYgzuuRyesdgrwWUdCCDSohfuDztr6O1Rur1e7ZYo
         rnyVCeMT4X1El9XQG40zcrpB/S34T4zk3MoeugXMY7V9+a/Q7gnzsfzeDIeleOaacU23
         th3tsRWITpjvdwlX/CagtXaoKynocaeOug6HDz5Q7Rj8zRXC6RiyLp05Ry70melhw23B
         GIUw==
X-Forwarded-Encrypted: i=1; AKwUvBxOv3qygQcAApi7Y1D5yMOhx339QKMP4G009y3CaMFuN9wYUg5fRnT4SDiIM6jaPnzQrMbvTwawHg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJPxd9oruFF2Y0mCk5Dzg+fnnZzlJRQFh03+oQAAxg8deXIzctB
	Fj2GJaOPsD2Sm2NAmBfTy/zgqBAnuDSQBXYOdX3YxjyEOjak/xrceHoC+a8SUErcLDza2OxA8dL
	PvAR+5qs17WNmI6vSEk0H/qcrx3iSfMtPykUslqup
X-Gm-Gg: AYBFou0/QkvRFidd4jxCt0rgYRL1JOe1MLSVECpdCTeeJnOa7Tq/dFTR+HEbM+h9Tlv
	SlcYF4RnLK/SSpGxALZea5FFXeKUyluPlqZ2TkKoXMannm9Pmk+8C0plkLf4tyYxqbCiB2G6PSq
	FX8o3QKChGd3ucmOYgwMj2lZC9ZDa92maDncVC0cUmZqIhYEZKGIp/F5f50P0V7I3pV3eW1e/mf
	AE6XOjEkin+szcmyNvV9WiH3iv3iLNUQ/A83tV1bfEmNLdp9RJB3ywuJfpspczs+DCUHJeNh/FW
	W5PphSnXpkmY1hQzEqTHymvQMo5hB+nFHujl+Z1eaQqWMWRUizRoipl2/tdRK6L45mJHPlC8G/k
	llUgVzoZHMQ==
X-Received: by 2002:a05:622a:1108:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-5360573c96fmr14813151cf.5.1791996097367; Wed, 14 Oct 2026
 09:41:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013223946.1836757-1-irogers@google.com> <2026101425-why-boring-4f2d@gregkh>
 <202610140932.5F9CFCE5@keescook>
In-Reply-To: <202610140932.5F9CFCE5@keescook>
From: Ian Rogers <irogers@google.com>
Date: Wed, 14 Oct 2026 09:41:25 -0700
X-Gm-Features: AclHuK8_g-YOJgMR77fEpf5RTsveF4u_ERdXz6lvoN6wh_uF7KP8ZsaUSV1ti8A
Message-ID: <CAP-5=fVLWh4uay2HGy6DOpZmtTr5WAd-TehAkN+P-pQgq_BZhg@mail.gmail.com>
Subject: Re: [PATCH 00/11] kobject: Require explicit initialization of struct kobj_type::release
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Viresh Kumar <viresh.kumar@linaro.org>, 
	David Teigland <teigland@redhat.com>, Alexander Aring <aahringo@redhat.com>, 
	Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Richard Weinberger <richard@nod.at>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-s390@vger.kernel.org, 
	linux-mtd@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 9:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 14, 2026 at 07:36:41AM +0200, Greg Kroah-Hartman wrote:
> > On Tue, Oct 13, 2026 at 03:39:35PM -0700, Ian Rogers wrote:
> > > Clang supports the 'require_explicit_initialization' attribute on str=
uct
> > > fields to enforce that the field is explicitly initialized when an
> > > aggregate object is constructed, emitting -Wuninitialized-explicit-in=
it
> > > (enabled by default) if the field is omitted.
> > >
> > > Following discussion at the Linux Plumbers Conference [1], this serie=
s
> > > introduces __require_explicit_initialization in
> > > include/linux/compiler_attributes.h and applies it to
> > > struct kobj_type::release.
> >
> > Cool, sorry I missed that talk.
>
> Yeah, I'm really liking these compile-time checks. :)
>
> >
> > > As Documentation/core-api/kobject.rst notes:
> > >   "One important point cannot be overstated: every kobject must have =
a
> > >   release() method, and the kobject must persist (in a consistent sta=
te)
> > >   until that method is called. If these constraints are not met, the =
code
> > >   is flawed."
> > >
> > > Annotating struct kobj_type::release caught 30 struct kobj_type
> > > definitions across the tree that omitted .release:
> > > - Patches 2-10 fix 10 struct kobj_type definitions where dynamically
> > >   allocated kobjects, ksets, or enclosing structures were either leak=
ed on
> > >   kobject_put() or freed prematurely before kobject release (risking =
a
> > >   use-after-free when CONFIG_DEBUG_KOBJECT_RELEASE=3Dy).
> > > - Patch 11 annotates struct kobj_type::release with
> > >   __require_explicit_initialization and explicitly sets .release =3D =
NULL
> > >   (with explanatory comments) on the remaining legacy struct kobj_typ=
e
> > >   definitions whose kobjects are static, per-CPU, or embedded in devm=
- or
> > >   parent-managed structures.
> >
> > Sounds great, but let's fix up the users before adding the attribute.
> > Looks like some of these need another version so it might take a bit of
> > time to get them all merged.
>
> I'd really like to have the attribute available, and I've got at least
> one user I can apply today that don't require fix-ups (seq_file), so
> if Miguel is okay with it, I'd like to snag patch 1 and send it with
> my seq_file "first user" for this coming merge window so it's available
> starting with v7.4-rc1, and we don't end up needing to wait 10 weeks for
> other subsystems to be able to use it. And the kobj fixups can continue
> in parallel. Does that sounds okay?

I'm happy with that. I'm working to address/incorporate the other
feedback for a v2 of this series, but I can drop individual patches
that have already been merged. Thanks, everyone, for the positive
reception in getting this landed, I plan to follow up with patch
series for the other uses I found.

Thanks!
Ian

> --
> Kees Cook

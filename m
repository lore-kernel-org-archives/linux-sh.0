Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5F7364936
	for <linux-sh@vger.kernel.org>; Wed, 18 Mar 2026 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773814601; cv=pass; b=bY3I9QNZ42Ilr7WnisrzZEN0UhDCpCNAYVCflKT+hZK79TdrYrCqAO/qezlhm/hGXoPHM43RQ7TV7Uzx+oDdNwLk/H4021lJkKlBXtCiXJ4zuwKNfA6aCvHfKB76GwQYMy1u+ItMjwGvSweHqXHkeL06IUZCSY30QYLpFq56TaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773814601; c=relaxed/simple;
	bh=LyvuvQqufknbMfPTy2o7n/T+OqohBBDpzWX+jX0Ni6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYQlt6B3tQVCTEjGziBmH/WelTxG+Mj0Qv8LvyHY4DlYahr1r3ewkKY90ZNpKBbInuzNBn5AQlXXvM5SygxS95BqgW7UGVcItheTphgprs44P8ViblKujQyPUVwNz+LVkIwHdA6zavj0YP9DXseDz4Zc4ImDK2pYoBa3bP6+Mk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czA+VIq9; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czA+VIq9"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-667acaeae82so1291113a12.3
        for <linux-sh@vger.kernel.org>; Tue, 17 Mar 2026 23:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773814598; cv=none;
        d=google.com; s=arc-20240605;
        b=MsZhg2KY7yvR3Sw1cATlGBY9prRhPuItDSW0/rq+fmpnQyQ1LOwDeRykBKVF5x1Gjs
         gVPxSDFh33phNDtpu9puE2QwGzcTum7Is2hauPbxvM8EH69kT7WPl8lvoEthtj9LcnN2
         O0FeEL3PEJN3o1LM0+z9z1iTQZnT3yEJyEjmpeNQZrBV109qJw9GxUdXGNSx0dFF2UHt
         5dd2NgwkO3rrra31oFlcNviul2L31aj3RWrgAdoWLHmTmhm//mbCxMc1V1oImBWQ4dP5
         YJ4g2JmscrGNvaKxpw+kieucCvgiwzEnQhR4vIGYJhk0/5x5Lm1IEZg0T91yZbu2rMvM
         d2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        fh=+Of8vY9fbM4qCfpY2FSeIyS0GA5fNpyvPiWkAUCRTfE=;
        b=WTjRCXiGAc8chjeaPgDenWlIhH21XhZwzXjqJskj4rmba6nIspUDt4i2eEIxB7VSOr
         BVF+I2NRVZlh6GN0PycS/wRIm4NruAfLi7rdSp/azG+412LnDgAihPXq4Fh+UUlvIrBV
         he1rpi7AxWNhglMK3KmQTE8soNEswrXoEzqQugSEKxI50vsPEr23e7hWkpks+82cEX+7
         FRaq1EnboMy/cVI5eDpN3Ud70fUIM7xyiWbj1OMIJKyWdoPxcNqD5Wq3w/DVmOUtAcT8
         QJJQJ+0QYNuRrvCZKOqzNx5yRu1i7IYLUGE25vsRbQaarviR5WR4LeoCgL9M/skgE/7z
         edJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773814598; x=1774419398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=czA+VIq9QGWQxIWviOuOrte+AkszdW/h15AxwnnBl8PgQdCUSJeFt/rkA58JF8bw1z
         MYdnPYGFr5y46Y9Ze6hH0uQbYgBxWhk4ISCFrpb1oCRqUKW8TesUGp2nfyk/tjdH6ZzI
         DwOCFfQmjthVedmcIE7z/9904oV0s5pfRk6WMlT+ADyKZllzFK45VHyMvAMFKoo37U/j
         J1nqKAueMk09QeZKqRnb2BbN9+d1iclFRFK4eWers79RzlXUT6c5NL6yIGsvvdDwBLkL
         mIaXTaJyIolZxl+55rCZtIapNWvPnqXYQeH5Kjuv+rgtZgAO2r5C3jf4lHbFErXbdAiD
         Zyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773814598; x=1774419398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNXx5fLw5itcSqfItrsW3d6my1DlKfO6NqzxE5+AiMo=;
        b=J40komiCbxIgNXz1atmcEDxEZ6st9uiIAhrLwuF8ODzWMgx5bBkto1LvngiFXo2VG2
         IisZexp72reLBn5I+RyZPKpQg/GONv5SvNwyh/LomzFA/jt77EheWnSOul4pY7uKubIH
         Os1muShIVwzKIB5efxwhi25h5DyqzQ4iAsNMSWtgtnwe63i8eIkDBy6hO3RwKQmAoP+J
         oiTHbJ/Ybw4m0WSR7VULA5VTcnzVR+XQvyJfx/kGU2jY78xg1A6lzBzRekbildIQuLQ4
         1vkf6QPHdCXmgh9d86SL894LgTyJ8h/HZuve46OF7HhIrYQLLKaynj0qDZ2CVyChOj7t
         Qfjw==
X-Forwarded-Encrypted: i=1; AJvYcCXNHoTKdUa4xDDeWFNyqPnOgsHk2heUtv0cJAgxYd9ezGXpNI7J7LKvXM4ADStyOCUlVoVYUxiwqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzO9tYU+QmEJRQR/N3uHVMOVoYKEMYy7UfXyCLFhtN3JZ+Evgdv
	HFiBnRWEuYRrsm8aFsgq8EjTqv3zVa263NoSbFvNlX1JGdWlfYlNyRfxWWPbnpLhIP2AV+jw3yH
	zn6i1tIMVzUdZHDdSdwA9LqglFKmG7yo=
X-Gm-Gg: ATEYQzwpo5fdBZiVTbQDmP1T5MN8HqwXRfo2J1a0tv//pKLZEkCDUR+GvhOxrKQiezd
	tEtGkJnav3DUIEhEUtspTFMkVGiKlz7sT2vjuTiOXN7vufRKCWQ7dvaHSNuq1InSChe2vH1b+gs
	OJjElgpzKG/5g+8vLJ4nZPm8PQXfwCul+VoPtn6FFbCmBFV1Dznix//YjRXdym3NEbqS3HfbS3/
	Lwno0KXX9tM6OZ7Cl3CDMvMSV+mCecH6uCHGDoy8t4w9SqBbLhQk2oE10plMR/J8tUr+W2YmgxQ
	0qoDh+u9++EwqMRa0IHbwrwtkbEsJgVuugK5OtFYSulr0+lTt8Q=
X-Received: by 2002:a17:907:7b93:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b97f4801ab5mr133040366b.15.1773814597747; Tue, 17 Mar 2026
 23:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-at-vector-size-arch-v1-0-a11f03ba2ca8@linutronix.de> <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
In-Reply-To: <20260302-at-vector-size-arch-v1-14-a11f03ba2ca8@linutronix.de>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 18 Mar 2026 07:16:26 +0100
X-Gm-Features: AaiRm51Xx89jeaivgNYAhMk2LxpIu3kD6j5N4SuQDZ84WCnP1EAzJIW2dMNKGiE
Message-ID: <CA+=Fv5RLtUPp9BhXfFEUk3roE3Gah0iUamDEZ-MXCNM_xKm3PA@mail.gmail.com>
Subject: Re: [PATCH 14/15] alpha: remove AT_VECTOR_SIZE_ARCH from UAPI
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 1:32=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> There is nothing userspace can do with this value. In the kernel is
> always combined with AT_VECTOR_SIZE_BASE, which is not exposed to
> userspace and also changes from time to time.
>
> Move the symbol to a kernel-internal header.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/alpha/include/asm/auxvec.h      | 7 +++++++
>  arch/alpha/include/uapi/asm/auxvec.h | 8 +++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>

Build-tested on alpha, no issues here.

Acked-by: Magnus Lindholm <linmag7@gmail.com>

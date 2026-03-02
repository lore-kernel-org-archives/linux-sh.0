Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733335F5F5
	for <linux-sh@vger.kernel.org>; Mon,  2 Mar 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449504; cv=pass; b=dz84xev2SfJECkYmJizpsKTAbzBObC61u4bfqQNx98BVPke9r2JAPKwJNp3Qg7Oi9MvcC0eBMDwBT3nfH+U8VSe9We406zwGx8tenJTlRMvCxTa26F+BsR0178CPtkRp6ceSr1sqFInXs7KQLe9oBFx0a4CnmF5zWRuNW3wYPp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449504; c=relaxed/simple;
	bh=MNN0MxQutkVAICnu21/rtSu7MZP/rEU4Ta6qHPWAsoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zhk3FrB2JSky8A6g/EW6gIe3X7WQOK+2zJLf0wFxCgZs8Z5ZTfUdiCKrRVoBUIQ8lEBiVnsB8p5fRwNXwHGEBEDo7OZfeDp2eAm9q5HvAMSBMl9VMN/OIh9FDP65M9NubaSkoVWMm4lFvzrVuIWQ6qLuNgcEb4JK32Um5AWA+gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFI7GPod; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFI7GPod"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so4782176a34.2
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 03:05:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772449502; cv=none;
        d=google.com; s=arc-20240605;
        b=fMs+ij8YoF66GqCgVFAI2vCdPvbMTiqw1Saj4To+1+f1bCq6iVW+mM3SLcTm+lEZ97
         jBNrk+bz34QPCglZCV9d3aEDM8A8fsGOofb2AXz4TEAvXWiT3e4cH/SmMugOzhOMyYvT
         h2bEVf0pClpp2uJX+h3f1RCG+mERBT4z6S6pSWvZTBmXnhppLS3naLoxgXAeIhcPrfhL
         sPyx/6BaJq5ndobEcVqoE7iyh4w4lF8+H2Dz8WP4tm9iGQ1D345LAMNMPmFjfEKB945W
         lsVLNYcOZ5Dst4UP+4haeLCu0jEA/CS+/j4g64zrKwmvn53vqBYQM5JDXS1BI3yO/hz5
         79mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UpW1qD1SJXhXQMOWzRKDDnDlmrJmewCs6uD1CPB0kj8=;
        fh=CkYkHbYH09mZcG5n7Ve9g61xfJCNQZZ7O69cgJBpHG0=;
        b=D8LvI+r+M7d6q5DoOSzMH+ebieCS0+0IAMD6IZlzZmh8G40SQRUiB2A5sXuv+0CUB3
         EinYl+CTkYPwQHoOksIBuwQu4aUCvChqrJzA/PBmj2xTycTMEMbxeO8CqYVAHToQXTDu
         IykMYZrcwTCkr4qBOgdxq7tW5B1GOQ+xXIIqs/okVHwkOczz6WNdEO+76LEb953zhu0I
         a+FW/YyIu0yIOiXH97Jr7S3Ldf1FYdumvoV1UBkAqhEqO+rEnuiXJ1kjqOOsfqVVXdqq
         rI24mZtxUeL7wfTIXb7D3B/Zlkfm1pcpgDNcGx27gtqz8hd83eJcEW5C+LiAkVR6oPcT
         QC+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772449502; x=1773054302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UpW1qD1SJXhXQMOWzRKDDnDlmrJmewCs6uD1CPB0kj8=;
        b=nFI7GPodwr4K7PC1HWfUVpPzdSjla2PQOIxDuEcBwSuSUvTWuwE5h20gW/c+gCy4t2
         u7QR/gPdyhMLyDTWmpznLdei1863tjE2BSGZTCnbBiufkUiS8X2sFkbHvf3zZU+SGT85
         Zdsw87IoZOF0vQlTKF+4+Nc/XEH5dCA0fEA1vh1IIJpbkto5aoGMyyrDS+SrhIZjaZVs
         vRYmlqAhwrxFdRyUdJ/JrIG2/Gpu+z6egxQjMYD3S0qZzGC7YK/grNnR5wEECaM1p0lb
         LeT+svI9a4QLe600affzmHLczk+PGzyC1rZ0JbA9hsMhED94j2TQnwiOMoUmvSFiGP08
         Ydbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449502; x=1773054302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UpW1qD1SJXhXQMOWzRKDDnDlmrJmewCs6uD1CPB0kj8=;
        b=D2LTLbbUpD8k9/YW9NBLXQux8+0wOB+9pLTfev6l5gu8uYuK6rJknENM1V37vWDtvT
         ipoFDgnbMH+p0WuWmrRSF0qDhj+EvhcR/wnbp86YaFxQQXkO8bRmFsjz4MCk75+/9bXE
         K1tNqYOZOQRqPkMugwPVVhewD7M0MQmt57y9zAHLFr+nsnAO8pdCZmmgaroNe3TvIy77
         dmH37hHhphMuph1QReaOCp6WJz1WfJzW5A4r6ZoyP/iY0NYIKiU0XShXAFAOkOKHeVeI
         vJ3iF2A8StjVJ5O/2WR07+FbRCxeRvcDy4msbJz/i8STNSf4+yiLUXt2dnndD8H8PNnV
         Xpdg==
X-Forwarded-Encrypted: i=1; AJvYcCXN2laGPyGPj3PUV2BrXIzNei77j0YVsqEBOsoDRw8MYsSFzeuCux3Zm2Cl08Yo7liRQ0ogYakNwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzmdhpYi5eo0c+oUz4mU8NKjCvz1a3gwSMe+VPPfsNLcWxTvIDl
	ZXAi4ifOkWYjJG0SU9wEhf6wgOkv0bMWaFw0Ch8vP8DONfyd3VS4yEOg6eV4DyWjhkJS1eepNQi
	lcTefVL/ItlRoUQcrAyOJ3AVwCT3d0AI=
X-Gm-Gg: ATEYQzyT9TsqPkT8p2vDvcGQl+Wb/MkHRhogrsb/y3Oqe20ZDjti6/ePEK9+ZtcloPG
	aGfgbtZzlnLh4BK1uZrqFbDspdEJE3x1yU+cIAusI3A4JAB5FCT/f8xrDIoCxX+ACwLm72pI7P0
	cIA3ipDNxGHtVN/v1XMUNGjgnqLshoPBW83Kge0CI/Hv3F63fzCeYvRrVZxHrFc0k+x5wt7p0lV
	lHBqnlyIISWmmn04MC9W9HOyQprPP61gIXIT5QsQmPQqIQwxTPfUaHBEnNMA4nmAbEwJug7TaCW
	UhSqBVoHB9otFbpQEne6awQIVicG/C1gd20gGsaYPliWtOEP2WmU6USh8+HvSavXUnUI+kHi+1g
	=
X-Received: by 2002:a05:6870:ad08:b0:3e9:1643:5977 with SMTP id
 586e51a60fabf-41626e0fc5fmr6099442fac.18.1772449502199; Mon, 02 Mar 2026
 03:05:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002729.19438-1-dakr@kernel.org> <20260302002729.19438-2-dakr@kernel.org>
 <CALbr=LYqfhMi4eGp18r20XFzOWqRYCB8tO0mc_TAydb5cgbX-A@mail.gmail.com> <DGS7NBNUSBI6.16D6UP28IAXYS@kernel.org>
In-Reply-To: <DGS7NBNUSBI6.16D6UP28IAXYS@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Mon, 2 Mar 2026 19:04:51 +0800
X-Gm-Features: AaiRm52arKfwi8YCxjpEdTXQmweggZZESyxe8RNIzUhwuktCE_TgfQAoQ172OQc
Message-ID: <CALbr=LZ6Qu+oi0XiTZO4u+H2Jsv51jWazmK7xPt5EgK9DOy-hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: generalize driver_override in struct device
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, abelvesa@kernel.org, 
	srini@kernel.org, s.nawrocki@samsung.com, nuno.sa@analog.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-sh@vger.kernel.org, Wang Jiayue <akaieurus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 6:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> On Mon Mar 2, 2026 at 9:36 AM CET, Gui-Dong Han wrote:
> > Applying the following diff fixes the KASAN issue. It was just a minor =
bug.
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index a8cb90577d10..09b98f02f559 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2556,6 +2556,7 @@ static void device_release(struct kobject *kobj)
> >         devres_release_all(dev);
> >
> >         kfree(dev->dma_range_map);
> > +       kfree(dev->driver_override.name);
> >
> >         if (dev->release)
> >                 dev->release(dev);
> > @@ -2566,7 +2567,6 @@ static void device_release(struct kobject *kobj)
> >         else
> >                 WARN(1, KERN_ERR "Device '%s' does not have a
> > release() function, it is broken and must be fixed. See
> > Documentation/core-api/kobject.rst.\n",
> >                         dev_name(dev));
> > -       kfree(dev->driver_override.name);
> >         kfree(p);
> >  }
>
> Yes, we must not access dev after the release callbacks has been called; =
no idea
> how this kfree() ended up below. Thanks for catching!
>
> > With this applied, along with the PCI driver diff from the WIP patch,
> > the issue is resolved. I tested this on PCI and both PoCs no longer
> > trigger KASAN. I also ran with other debug options enabled (lockdep,
> > sleep inside atomic, etc.) and hit no warnings.
> >
> > I was working on a similar patch recently, but your version is better.
> > Not returning the string directly provides better encapsulation and
> > makes the API much harder to misuse.
>
> Ah, right, I remember you mentioned that! If you want I can add your
> Co-developed-by: to this patch to account for your work.

That would be great, yes please. Thank you!

And thanks for all your hard work on this patch series, it's a really
solid improvement.

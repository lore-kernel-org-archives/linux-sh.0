Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3232AABD
	for <linux-sh@vger.kernel.org>; Mon,  2 Mar 2026 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449325; cv=none; b=YQgx5xR98QTrQc8cexlPqJUxMbCICg+EElyhdXo+AoPCTpEVU9cFT8RIVgTvlJttCVrtjp3oRkC+H4gZtmfzeLUUIj6CAGRlZ6fZ9kPJ3qeyu7Or+G2oLSWrptSmp5uELFC4wWhEyoLp6HtujyWRHnqa2QDjhj67ym7SdWq1nqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449325; c=relaxed/simple;
	bh=FPUUwSTSnHifTg1q09fFBxiGrVRvJtWxYMGk/Hf/oPM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rmBzPUXgEUVHURdw7DdKKXyOfPSVtQliyEFEfj8asiRhZDtxFScWKgILDzycW7PzUuWDqx3P0i3yOKzlSN8HehQGSVZz/gllfPwODh0OCS/xHmsVRWT5gBID13v+bzDJnTbYr8xy15m1vp0yDBN78Y3E1cA5xilzvk1BCuEJW8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MWbYPDe4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWbYPDe4"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439b5d78592so860914f8f.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772449322; x=1773054122; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l+QuPdQBDjcL4VBMNAL4KvWg4+YAGNXrbh3ohkf1cXU=;
        b=MWbYPDe44zed2KsOUc14yPFYKO+jR1+crKAFR8UALOdYgwe6zoku1UeiELG5KFjJdT
         Z282fgcSIpF0sQSeERm28ejPpbskvZa398Yg2UiSpx2/RC7juHgpDGMjtvTa0Vc0FA9b
         46PvUbwynXZump/jv4UoWLj4K4kXg9K29BluNYLnh7un1liI3grXJDye6PxieBHBLBXl
         ipl2PYX8tQGayaIIpWFrwUqwqay4Rm7K5PsvOdjj9kEMVN+H2IYYMgLJirw5nIQfVKow
         +RsSDNN56oa+ozQd1RHvYBxRt7sUjPfLNeHxZUqmbGeeMXcbFGFqeigVwSnMxRxMEKa2
         Nb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772449322; x=1773054122;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+QuPdQBDjcL4VBMNAL4KvWg4+YAGNXrbh3ohkf1cXU=;
        b=JahfXZ9kogRWzuHprda3NQsu+gHjqV94SoQlmCcIVYasRuSNdDhr82AZ/l+LfktGhv
         ONYYqo+tSPL3cjTuh8553HQXWeqSzrdBXD/ihDalcwtQWXOnEkFeaJRxv+3+QMiJ6wL5
         275HDuSzysO3LFeCL3QZ2T73xSKnLW/iAQwtqDq6+5H9OsP0LQEGdTka5UYC3SnvLOQX
         PQwK5L97alqftaVmexx7HGTZrXiiVsu+ic05IZ7rTHMng8L1jSg073KfOVHIQXjHUHCY
         fE1LnhXl81HL4zgBaKSFGto0uLtCmjyYz5ba6DHHsvxLxSKnSP95vJh35J3tmcTNJCBq
         NSNg==
X-Forwarded-Encrypted: i=1; AJvYcCXjuiNbjq4ahy+Vmea22v7Q9hpfeyJn3hGaSLuhnZVG1VYOg9UbrdNWSo09t5YgKIb1v8+sgONlMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzatWJLECMMl4Uwr0bM+wPc/6iOG4JGKrs4oZf+IA7wxVdz788t
	f5r6RglhsbbXWKdtFAbcpDb+kbybZ5MbMdCYnNb5AwusAZYzpUFeRZt0
X-Gm-Gg: ATEYQzy/z9apV0YTEZ4X5gzxM+gfp3J9iXo0peirxzjCpsOrSQOdTvE+KCa0hCJZwhO
	mN4hEurf2d7UEmtsxvkDM7qLZ3aoGnsCVX2kkATGx48lBUHK2m4IsjwREGBnOgPOjuFbktnhAxo
	nzVU2rXT30HOO7L2sCtFZd7eX6dPbVBVLQfBHEJxCzcX0G5YlkuwyP5EFsTENcPByh/SfnyKAKK
	Ik0Nmk40by+8la5AWn4v+DtEPwQ4Zf4xPt2gQHnOUlOaKJEVzBi2IiQyNkNGjBP4Frx4T8Iyqqw
	jDBgBdecArLbzcUggTTLj7AjKfKX6UkbzLyPY3ZQ1uvP0J//ylU0yB2cIvkcJvVI4xt/XV19k3o
	BIa9apuRoH2YipaHW8lvD3I90JfYRNL53OBWikd+p7DDUWeS9KbgFu+6AVzGeympl8UriwlCxVk
	dnPnNQtA5dEmED34IjSbRh/BPY4lOsM6Q=
X-Received: by 2002:a05:6000:2483:b0:439:ac53:a94d with SMTP id ffacd0b85a97d-439ac53aa50mr10380328f8f.29.1772449321007;
        Mon, 02 Mar 2026 03:02:01 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c60e40fsm26841661f8f.7.2026.03.02.03.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 03:02:00 -0800 (PST)
Message-ID: <de48f967a50b8f780dbadc562833ae6626be5268.camel@gmail.com>
Subject: Re: [PATCH 2/3] hwmon: axi-fan: don't use driver_override as IRQ
 name
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>, Danilo Krummrich <dakr@kernel.org>, 
	gregkh@linuxfoundation.org, rafael@kernel.org, hanguidong02@gmail.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	abelvesa@kernel.org, srini@kernel.org, s.nawrocki@samsung.com,
 nuno.sa@analog.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, 	linux-sound@vger.kernel.org,
 linux-sh@vger.kernel.org
Date: Mon, 02 Mar 2026 11:02:44 +0000
In-Reply-To: <6e1c57f6-ac82-4e64-a49a-8b3ddc782b54@roeck-us.net>
References: <20260302002729.19438-1-dakr@kernel.org>
	 <20260302002729.19438-3-dakr@kernel.org>
	 <6e1c57f6-ac82-4e64-a49a-8b3ddc782b54@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-03-01 at 16:51 -0800, Guenter Roeck wrote:
> On 3/1/26 16:25, Danilo Krummrich wrote:
> > Do not use driver_override as IRQ name, as it is not guaranteed to poin=
t
> > to a valid string; use dev_name() instead.
> >=20
> > Fixes: 8412b410fa5e ("hwmon: Support ADI Fan Control IP")
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> > =C2=A0 drivers/hwmon/axi-fan-control.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-co=
ntrol.c
> > index b7bb325c3ad9..ec4bbb104449 100644
> > --- a/drivers/hwmon/axi-fan-control.c
> > +++ b/drivers/hwmon/axi-fan-control.c
> > @@ -507,7 +507,7 @@ static int axi_fan_control_probe(struct platform_de=
vice *pdev)
> > =C2=A0=C2=A0	ret =3D devm_request_threaded_irq(&pdev->dev, ctl->irq, NU=
LL,
> > =C2=A0=C2=A0					axi_fan_control_irq_handler,
> > =C2=A0=C2=A0					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> > -					pdev->driver_override, ctl);
> > +					dev_name(&pdev->dev), ctl);
>=20
> The devm_request_threaded_irq() API documentation says:
>=20
> @devname:=C2=A0=C2=A0=C2=A0 An ascii name for the claiming device, dev_na=
me(dev) if NULL
>=20
> So NULL should be sufficient.
>=20
> Nuno, was there a special reason to use driver_override ?
>=20
>=20

Not really. That driver was one of my first patches so most likely it was j=
ust some
copy pasting. NULL should be fine.

- Nuno S=C3=A1

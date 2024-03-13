Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09766171AF
	for <linux-sh@vger.kernel.org>; Wed, 13 Mar 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710315577; cv=none; b=mTg/hbPM9klYdcEJqueZbzIXqIdFSZ6VmI3QA3+SBaF1668EzKJamHIa8r9CMMd+gp8rYTttql07VNrkF6koF7gw/NP6d6ao7CtfgjK2v6y6QdjJNKUupchN/bI9iFakSMHy3O82yR42EBQVTg5L8qlfh6jdRYvhDfNKNuOhsTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710315577; c=relaxed/simple;
	bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f46uC6xpTb3wPHYhtSzPqm/cqVnhIIV5zEvG91FWFc0lMZRkVOoeEBbNDmjZfDoZ7Riolm0d0euFCXtVKwf2txrTR2K23+JVu8MbHnuDWsPUJafUoPOPOFa+1PHvlakuOijgJ+QV/aFkqmeWkkGhIQKltO2L4Gm6q6D+KZF+YZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GdnaITHH; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdnaITHH"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44e3176120so817003966b.1
        for <linux-sh@vger.kernel.org>; Wed, 13 Mar 2024 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710315572; x=1710920372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=GdnaITHHnDyTc59DrnY/aK1qBmW4s8v+1Wlo7OaXKXq57D0uGr0gsQX/ItX/BACBPM
         mCpMOjziUb+3Mn5COgkXtUpoeoLEcXZCGTpgGjzVyLc+VMKae2PiFkxwSu99rRhGu5PL
         h0DwhApPO9cJtQFK8IR03dSWBM+quu8+QvheMmkAeD9cyenRXDT5FzO/WA+ETkmUxyZa
         SN1VD6WkfLXCEc+IYf4zf/JHE0Wo1vDZsy4xcu7u+lDW5Wu0D+wy0+1TtlvzrncNvHlr
         tpridwRMpXbbySaNM/TBwn2tAXOaruwSht9ctgRneZZUslHQzUPXkKVV6MMDE1ceGHf3
         4nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710315572; x=1710920372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=cQ24vYeRU/bA2edwE5KoqFpbSXo0kFef9/nQpLB//j7PkAHLRL4nMCEFXWl4B3zVsh
         ZhHbedQiH8fbU4Q3YueADLcr1iNQe2beDJ48FUepHK2Sllt0zC+19BT86fQz81ZT9HLd
         vghiu+BAEQk6myh8/arqG2qOIm2nKs5S6nSyCP6Tyh3rzvGkEdaT+zmNpzzA1BgF4gsA
         jk10tIPaCEblU9CcNE6TZCWPilA7Ebn2pc61TWsjocWFeYuPspUjnEIB61PyRmChiwfm
         5x8Yt3FL8sl8yo3g0SQJywplwjZZMkXUavRSiwvrC4PYbrQj81C66z2fw3r58hCdvawt
         YtoA==
X-Forwarded-Encrypted: i=1; AJvYcCWx5sPmx5d9AypBzRxhOzIS8ASGh6aPTDnjnch+pE3+ZzMlUKq04g88Gh+o8RTyZvIhjebPZND9o/8xw6sjSgcjWCAJ+yeAFpE=
X-Gm-Message-State: AOJu0YwApPhYCTi51NIY7BK5amUaPATlf6m1kw7Q08r4ybKP4ddBg/sJ
	yJyBiIrCTt2Um24LoO3mVcWkFghsnhXstCXieWNrd0dYFCYPVmD7KzMN/vr8pQo=
X-Google-Smtp-Source: AGHT+IH38GneADkyKtRbEkb8+HLK5ZsZNpyhD22lE4uk6eUmiwmdHa00scLatPQEFNYx/T2Y2VkSUg==
X-Received: by 2002:a17:906:2ccb:b0:a41:3e39:b918 with SMTP id r11-20020a1709062ccb00b00a413e39b918mr7484516ejr.24.1710315572226;
        Wed, 13 Mar 2024 00:39:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qx26-20020a170906fcda00b00a45a687b52asm4578781ejb.213.2024.03.13.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 00:39:31 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:39:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Kees Cook <keescook@chromium.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@lists.linux.dev
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
Message-ID: <43ef4ef4-303b-45c6-aa50-3e0982c93bd7@moroto.mountain>
References: <20240312170309.2546362-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>

Thanks!

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


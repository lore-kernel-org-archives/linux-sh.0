Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BE39936D
	for <linux-sh@vger.kernel.org>; Tue,  2 Jun 2026 22:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780437981; cv=none; b=cyJJeVWirfV33bP6drn6kzN+HDnT2PU1gbYrtVnGhX49/j1d/XjuxQjNC3XYS+6sorpzsSjmpjc0XvC4mOcuOP2Kn+4F7kDCinTRlGIbbCAjzavYM4ebAgxGqECqxU9e1AZYWPWQNuAxVrZUugbNGz4VEf3c8uAAqCbjkw6jYts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780437981; c=relaxed/simple;
	bh=6bFM7RnBqOusxScs1N1KTjygnjpRTHNuBBIsjnLMCIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+Fe1GMxsQaYsPMkj3InGV0irDo2o4U79KtiNBtk7S18ieAsqB/u1hveInlnKwASUuHNDW2B6ndsqUf1Yn9J4Ub68qyNjNdUv+wJSKqjXf9dxsf5VJSRHksUJet4GWPg8HoO6jJrUGcIKhFLkGbqr3JcVIngkTrauBxaugETV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H33pAmsi; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H33pAmsi"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304cf518c9dso8690238eec.1
        for <linux-sh@vger.kernel.org>; Tue, 02 Jun 2026 15:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780437979; x=1781042779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83NdS9WzqEj31Fng8v49SeEyE/axOdCOAa4Coh7yKjE=;
        b=H33pAmsisBQDRPLsbYm0cVUb/O53TYIcxuMSb+61rFH3b0zvPP6/PnioK97SW5iJnV
         4YvyXFmdo9/4eqMSyeQ88KLMwpLE7iVwCRq0qJ0ibhzhJz22slGn4EI+ZGCkQrir8sd5
         AhmkwAuwn4e+z2Yjm2lwkTUDfcowl62HYkiK5MB2uioh8RzWfD9m+iyw/WfhiUHrYBiB
         9OKyGq64X/VZxOmCgupXrtPi3frs16O2ypOwKmi9vxRDf+onlDy1Nm9of8ioiaVA69Z3
         aGFpWyazAIHu5LceGB9vdQXSGlqGwn3Y6WvMTWogCJzmcrcrAktKSQVxCg7Vl+3s4kfz
         Yslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780437979; x=1781042779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83NdS9WzqEj31Fng8v49SeEyE/axOdCOAa4Coh7yKjE=;
        b=M8FDLn3NyJE/3+P0My9Prmqlysw3CqPnVjviOfD/iY/euwk1DCyueLwYMSoyL9Cwze
         d11roeQRUy58nf3bO0GpIuwSMrrfdUX9b10FE93n+8Aur9db7SUFPq4nfTYhKwiDXV3/
         yzFbExkPpgupg9srZyhlPu8ugylET+RJbrQ9HsDoKL1EBhVki4UnTAiKc8+8eTOodsYL
         qazx/x0NKT3qaCWVAkajvpEtrIFRiBcLgQ7uRZpoalJF+bEE/RiTbMHVwaV8N5a0FPJZ
         8i7galep6s0AN4mu5FIIaz4Ryia1dkqojv0aeV2yWhioJ+mdKD51oUBon3yc96WhNgVd
         IlPg==
X-Forwarded-Encrypted: i=1; AFNElJ81QAgxQr9KX58hldRJYIKK57QU3Mfh/CUUnhdl2z6wCEM5AHt4yeov9q+T9Wz0z3blujQJyXkxjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2tt5jZ7BZhoL9x0yA8WZ/StDNR1yid+U0rD8RdbizMegoEkvU
	a4DO84wXNaKI2MUzzwG1YH2syBNMjp6aPJxNVVJ+dNG+lWf1NTHoSrQA
X-Gm-Gg: Acq92OHT5/d8aPCn2skgC/+41IDAxtNeHwgIUCtG0K27C6ILRqPl14UoDK9MInd+x6O
	BdsmBda2QblfCqlfHPNlY7Z6GY5UjH7S2coEjyvOLOPxOyCYm2VDH5EyjfMc4k5vl0Ti9mBbzXG
	dYIJaIt/M1C+WT/DjxV+h7sB/EXuOc6JGpr/6ZdDMfOui3Lzt28TwfhmyuTHMoKxDzBqLPmx7aI
	U7GSvztMJ1ag4DUkfDV30V6u0DEoJb7zmzKu0bZ60aT4IIN4tV0I4gOUnY63M3seiZyg9/O50ev
	xfS1GQS44UsSYDx34+F7HQtYbx5ocWmXx5tfISNQwugu99Q7lSkDcn0Iqr3UWuN4Mr9rZ0oAaqa
	I5cURFU2cZDmHalx6ONa6CnEc7/THzGDpAGxxTBiyFr2zJh8bYwbEM3oe6P2NgXM72ZoebayyDl
	NeUadaQR13ajjAGBhceUlZTzc0JT3EwmUlvicPXRFAmt1/8N8NZ1m+bt/wgyTZYRytpMz0PlJmP
	mM=
X-Received: by 2002:a05:7300:7252:b0:2e2:4979:eb5 with SMTP id 5a478bee46e88-3074fa79f08mr317280eec.10.1780437978893;
        Tue, 02 Jun 2026 15:06:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:c4f4:520b:1304:b259])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dfa3a2asm1102723eec.31.2026.06.02.15.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:06:18 -0700 (PDT)
Date: Tue, 2 Jun 2026 15:06:14 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@kernel.org>, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v2 3/5] sh: mach-rsk: rsk7203: use static device
 properties for LEDs and GPIO buttons
Message-ID: <ah9TXCcBPNh77Ut5@google.com>
References: <20260520-rsk7203-properties-v2-0-465f3308021b@gmail.com>
 <20260520-rsk7203-properties-v2-3-465f3308021b@gmail.com>
 <ah9TEJ_jrfcJwrb9@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah9TEJ_jrfcJwrb9@ashevche-desk.local>

On Wed, Jun 03, 2026 at 01:02:56AM +0300, Andy Shevchenko wrote:
> On Wed, May 20, 2026 at 10:13:19PM -0700, Dmitry Torokhov wrote:
> > Convert the board to use static device properties instead of platform
> > data to describe LEDs and GPIO-connected buttons on the board, so
> > that support for platform data can be removed from gpio-keys and other
> > drivers, unifying their behavior.
> 
> ...
> 
> > +	for (i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> 
> 	for (unsigned int i = 0; i < ARRAY_SIZE(rsk7203_devices); i++) {
> 
> ...and drop the above definition of i.

Why? I do not see coding style suggesting this. 

-- 
Dmitry

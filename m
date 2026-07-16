Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C4B372B3B
	for <linux-sh@vger.kernel.org>; Thu, 16 Jul 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224333; cv=none; b=sg9yWYum1vj8Pr6YUEy8HyfJWLtHfakaUFQFEEC1Y2hWVoX5yb75616MQ4tdigboUN2JCvwavVj35OgPtbv9HNs1jM+XQaP6pkatHQAUixvK7FXYA4xlIcBKvJC/9cWcqWTUGcf0CMJEBQLaB4X7IHdzys8n4R0tDCCrmJU4IUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224333; c=relaxed/simple;
	bh=J6v4npz3OThd8NQjBNodgNvNGgFRWZH0AmcNMYfCyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tFrEvWIeRgLuyg6In0jsrSVHwKNZEX+yvtTFRgfiz0HvZu8lTikKeD1l3p6GybidPvR4/onptd/qkT8XzKc5XFI6xuExCIP13H55iX6U4MuuA9WHc/RA4lH+Ped4dWTuFsIgteARA1Myum8HMrGxE/3i3548kIfOJGeQbWRm8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITU6MBCT; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITU6MBCT"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4629051c9d1so2208762f8f.2
        for <linux-sh@vger.kernel.org>; Thu, 16 Jul 2026 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784224330; x=1784829130; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d9HnM57cPoFNZBFEZlPJlObGF0jJpBNUfGKI2DBSN2g=;
        b=ITU6MBCTmY8cCiarH4sBrVD+51WCwM3zv7082fKRygB7cSBDc/7nx95vfc+fDD+QCh
         N4/w/M2sjFhgn8LNLDqosve+RStW7SVvgYbd7Mp3r+2hQQ+9K5XAlL0cLLtPA6HyTB6k
         lPxuFTGtDJeBqxZjs3ivizSFWu6QcDQ8hb1IyER4km+yVKYDCgNFgodz6A2zWr1yS4/V
         pXUBfTIZMEZlD3kRaCnC9rMCaSKvWAcea91gMgfrqlAo0hObYhpTJXE1tyxfSR5KSkG+
         0Q298cYFyE6I3OKIx0HMCFOjio1bdx8z/M9X7Hxg+FXfuoGEJifj3hLDXNphESAdRsRR
         XYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784224330; x=1784829130;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d9HnM57cPoFNZBFEZlPJlObGF0jJpBNUfGKI2DBSN2g=;
        b=qWp1VAS7SxGRSfs0r2f55ZMT49Qgjb6hrY0N7VPlSpYzHkOoWnNHgg9OFtnL0Bp43O
         8PKHEZ2R9Ly0PGcO0bWDf733D4i/ve0sVP1fvdMYz4LXZfinKPLbmv1Ha99bYf412tch
         zuoQz+y/oAxSwr2tiZOULh0FORa9LFi4WTJdvPKucqhjGqbfPjp9TQMCGogS786Iz9X7
         ov73SOn4e9Zk0/AbZ7/IkGV/jf/l3TE+f7VAO3XsG6e/38dIDBToA2GThPe2+iqYEMnG
         WgvjXAXUNixKZyUL4ziDjwD0KAMfMmHFRBrw7Ax10Sdq8PwTVf1hWh0U/iLmaQdpNl0Z
         VROQ==
X-Forwarded-Encrypted: i=1; AHgh+RpkkVH+4TNn0eEdvVq5DxXPvPSkg9efPys0ItUTAwue9w6Ufeo3kb26JvluwwerWADPZODWuc3Hlg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVI09goLGBTdGh02xkRsQAXW9K2ncuX/56/JeLEUm9V4R5WNKY
	8Uau8/TXCdRqKD3/RmehInUyKckXKM4pgE/qv9HXgqs09iHQUxfFpFMm2gRqBpzA
X-Gm-Gg: AfdE7ckrs3A7GluIzCFRsib0syw2O17VZKFTrbXny229KMKae6XO1O1Y/G54ECT6NHq
	H0Eut7ife9Y1f4VHM356/glfM1hT5Efxmo9sbRZrwo7+YGKaTjNy0VlXH2OiF9D7uvlJ+LwNqZC
	e5PAUtu4JlzMvOiL7fDOY/OtxAyZN7Ja2pxM1aaElF2T0ks7vDojFMdsuth2Scv9+x6azReT7NR
	bhMMr3ky8i9is6hqywdThrxCQAA11scCvPeUFVHEjAopwIET9rvCQxnF2nQ20GhD9/8T4obBg0N
	MgGX1jlHBq2FsDvDeCaPbWpEAmT5efK4s6NMMMagmJeD3ZvhFNuhoyMMnJytHoyVE+Bs0l3Md+D
	N4Yp+h0v4ZqGkSFdT5wX5q7zIjSYpbcuoAKLkJL2Ad2b5hXYqtsYSkvuofkl/rFEMe08vEWu7Ig
	BcMYghrEgtb/wFtxiexDmygbJmJg0S3c+NaW7wHF0=
X-Received: by 2002:a05:6000:70f:b0:47b:69a5:7264 with SMTP id ffacd0b85a97d-47f6078d365mr30313f8f.5.1784224330442;
        Thu, 16 Jul 2026 10:52:10 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c30a9sm24929886f8f.31.2026.07.16.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:52:10 -0700 (PDT)
Date: Thu, 16 Jul 2026 18:52:08 +0100
From: David Laight <david.laight.linux@gmail.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Florian Fuchs <fuchsfl@gmail.com>, Rich Felker <dalias@libc.org>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: uaccess: Require offsettable operands for 64-bit
 user access
Message-ID: <20260716185208.74ed22fa@pumpkin>
In-Reply-To: <c4177b44450a909ae8dad60da39523f14b5f2005.camel@physik.fu-berlin.de>
References: <20260716165329.3418962-1-fuchsfl@gmail.com>
	<c4177b44450a909ae8dad60da39523f14b5f2005.camel@physik.fu-berlin.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jul 2026 19:05:03 +0200
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Florian,
> 
> On Thu, 2026-07-16 at 18:53 +0200, Florian Fuchs wrote:
> > The 64-bit __get_user_u64()/__put_user_u64() paths address the memory
> > operand as %T2 (base+4). This base+4 requires an offsettable address,
> > but "m" also allows the indexed mode @(R0,Rn) (e.g. for a variable-
> > indexed array element), which has no displacement field for the +4.
> > Depending on optimization this build fails with "invalid 'asm'" or an
> > ICE in GCC's change_address_1.
> > 
> > Require an offsettable memory operand, allowing GCC to reload an
> > unsuitable indexed address into an appropriate form.

An alternative would be to pass 'addr' and 'addr + 4' separately so that
the C compilation adds in the offset.
With a bit more effort the define wouldn't need repeating for LE and BE.

There is a bug in the __put_user_u64 code - it is missing the exception
table entry for the second word.
(It is present in __get_user_u64, but a separate label would be better.)

I also wonder whether there should be non-mmu copies?

	David

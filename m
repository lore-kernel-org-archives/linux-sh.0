Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6AC356765
	for <linux-sh@vger.kernel.org>; Sat, 18 Jul 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377238; cv=pass; b=UnLQT6t+ZV+YezwqSF5rfOQFSQngayweZVR1oT7WrlaL6UMvN8WfWsvYvBF18jrD7Ta+qMHJropWvIIcqhvyRR+JzZXq23jFE3tOudMJAMknDMZaY6fXuRxpRipcSHCkZmlN+rWVfGPh2a3FLQKmg53shZd+byu6ETLIo/Nrlng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377238; c=relaxed/simple;
	bh=ke+GY1jiOWdQZMpOocTRJf+Tv1Bcwwp4aeT2me2amC4=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DsdoRd6soUZmAJVFXsIcTR3stpwOJ7psYq6CeMd70j/9wiHZ64ZS/0SvmCCwFeTyZykp7PD6F4h1PDv5j939cmD3PGip5VIyi4gipIw0IK2mYLzpHabomrXR83H6o/fP+7VvMNREVXcN0oLOx1+88wULS0OK72iSB07oBkJdJmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RjHFWcsZ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RjHFWcsZ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6611669cd16so5283448d50.0
        for <linux-sh@vger.kernel.org>; Sat, 18 Jul 2026 05:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377236; cv=none;
        d=google.com; s=arc-20260327;
        b=ZVGHyig1P3w+82BtJf6cLWv0ya6z4y9ynafkMjPF82k10mNOQToDn3+SdyV9urL6Uw
         nlHbGBmyqXI4Pz5sMhw5gQ9kPP1vTYaioHXExy3uy3K6+aMWUoQW2/mpGAPVlCdSrbJo
         s0xBGqOjOYhQbdT3ceeBqpyYnZRhlwQ/60yADaPBzz4sLhKj1wNEUixoSyTXWg2bQ3Ze
         mab4mvTInJQPznf5zQe19EA3bo3uYqUAu4offvb5rW0IORdz59vzMDbgokbQMfnxjNUU
         1jupw+BsqV3Qd1eUiB4OEGcG9gxbDDsA8k0o+aM2Z7/cZVxwrPrLoGP+DkZ69J9mBI1j
         iKYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=ke+GY1jiOWdQZMpOocTRJf+Tv1Bcwwp4aeT2me2amC4=;
        fh=/E//IiYt02+fIxilR25kKCsbm9kJ/8YxVS9452nL9Ks=;
        b=ah+5GBIrzVzdZlPosHr3xAaDZgUikbwOblgWCWlPwqwK5bneLPoXPkJqaTFbzsjChF
         Q3QCNnIF+R6aVwoWff/DBXIHmXYW3smf3qJwDAegDZVNBU4HDleCYiXMe/3JEW+2VEBI
         7utDddXnLtNJRzovzmPEE4NmLjXiqrK2N1tJ/tMqrKT2y+DnO0ISU/NFPhoW4aGna6iZ
         RWTvN1R3PG8UCeXsnizBLw74cXKaGaNXfB6c+WfkILiqw/Ta5ilXoY59LYKy8HVM+N5/
         pp1HgPQjSqQzw1OmhLnSdyP/+UaZg73z74YSPvKSXoFCL02e9wE5pphNsnu087BcS2k1
         N3wg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377236; x=1784982036; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke+GY1jiOWdQZMpOocTRJf+Tv1Bcwwp4aeT2me2amC4=;
        b=RjHFWcsZ+dy3ruDmN3RhJF5U54GdJPwsc/Sx8jRW5G5xSMQycA4r1Yy2rR7SNEYyLd
         /iWCl9KKuxUyvVNnfcnZeteNRYet/F8hBX1N34og7LwsIro6icBwILhR1IyVHWcz2FSr
         HKj/k6i6nvU2OOueeKNtUKVMIxm8MO1ffKucFGQQEWZ/oYgv0HwrxmylIzD610sjU8nD
         OiGsEx07it3Qjm3TMVoAeJlssnTSO3gwcmK81OzCMrb5eiCQHlmRFKwZwn3sTTPbYtIX
         LcqJGHL2rrnXeFEz64ozTaWGREPGtq6WEwuKjm2bIIVD+jPrmgaBTd59bHIlEap58fRW
         MQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377236; x=1784982036;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ke+GY1jiOWdQZMpOocTRJf+Tv1Bcwwp4aeT2me2amC4=;
        b=JzDARpbsrAwZr3ISBGoMPks+6RN3reBQAWwyYGc+Fv4bqPpdsx/OEN4/ZOkD4qhu6c
         63a8n0toENn4OL/iMRcS00sbvSQfE5IMMT3idbKKh2DJkCyuADwGHk7T3Z5Q735uo91+
         4ahbJZyvl9raBVTxGxEQcCJD29R2So9hNC2ERJ1cGpIOzVDrVx5n2OABBiuewNthxWOI
         qUM6RFUG5veXfB6ekapINI2TZq9yddBI/rIee/6DQeI+C5hkMccA7KEQAkkIMJIG4cw9
         nUnR8DhzGMc6TfCQMpMiutHVkS6UeIr78aziU+WRgWuv0VIhWinib+5jSSgkqmT1McnU
         JfdA==
X-Forwarded-Encrypted: i=1; AHgh+RqpOfkMyxFfoJAgPlic4l9UVA9ryrAx8nsXMtThVjvBw7DV9XrP/+OOaWAGlHIWpN03fcJI4HwSmw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhrzL0b+G7HUOWuWWVqk1hEDXafvani+tGwSzuL+lvXpsPoQ3
	xwcN86ALpOLhFJwo//j8b3Q5grwyhwu1QXK2EblOtl0MhrUHwmdkDNNto3SF8+m25MJJyPzbLgw
	8kqb+eRpgD8XtTRnSe8AElGxzppjbrqY=
X-Gm-Gg: AfdE7cnmBh3aCUOLV73MFsaw5gFgS0n3uCofDJSrUETXpoRNqySUrHG1aSDlV6ybcp0
	ayRLU4jmKbr0LbogXw+RZHaRuXvs+pc27o+bU/z4YDOv/GcgA1wkN6Ttq6B3IqfjM4QHQ+/g6yB
	Ftn6vWJ04zSqwzbUxKqWh2GW2H7Z82f1tht/2mD1TRf8wpoMzyMnGdkcLT6u+kgsUrleyenDYcI
	tfqioeB+ET8YHGMwDKTWuVPMd+1C1Vf1UIJEC6tAXrC4NHe6C/m7fSS2k0Puw==
X-Received: by 2002:a05:690e:480e:b0:668:430b:ab1d with SMTP id
 956f58d0204a3-668430bbbfemr989322d50.0.1784377236000; Sat, 18 Jul 2026
 05:20:36 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 05:20:35 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 05:20:35 -0700
In-Reply-To: <2026071710-flanked-espresso-5b06@gregkh>
References: <20260625085800.4505-1-alhouseenyousef@gmail.com> <2026071710-flanked-espresso-5b06@gregkh>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 05:20:35 -0700
X-Gm-Features: AUfX_my_CLZcQTnxCSNQPQdrKE0Mg9vD8lv3MDR5D6uAfcrOntLLLnpOP4XfKEU
Message-ID: <CAMuQ4bWX3MR6JGt8CNcnWE95z=ZyFk7A7G+99z5Z0Qu=XHMj7w@mail.gmail.com>
Subject: Re: [PATCH] char: mem: keep arch range checks overflow-safe
To: gregkh@linuxfoundation.org
Cc: arnd@arndb.de, linux@armlinux.org.uk, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yes, agreed. The ARM and SH fixes should be folded into the original
generic char/mem change rather than sent separately. I'll resend them
together as a single v2.

Thanks,
Yousef

On Fri, 17 Jul 2026 16:17:25 +0200, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Jun 25, 2026 at 10:58:00AM +0200, Yousef Alhouseen wrote:
> > The generic /dev/mem physical range check now avoids validating
> > addr + size directly, but ARM and SH provide their own
> > valid_phys_addr_range() implementations with the same wrapped-addition
> > pattern.
> >
> > Use subtraction-based upper-bound checks in those overrides as well. Also
> > make the ARM mmap pfn check avoid overflowing the pfn plus page-count
> > expression.
> >
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> > ---
> > arch/arm/mm/mmap.c | 9 +++++++--
> > arch/sh/mm/mmap.c | 4 +++-
> > 2 files changed, 10 insertions(+), 3 deletions(-)
>
> This should be part of the char/mem patch, right?
>
> thanks,
>
> greg k-h

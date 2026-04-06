Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3491738644B
	for <linux-sh@vger.kernel.org>; Mon,  6 Apr 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775488347; cv=none; b=hsURtJJjh2z8BppqGpLwr9tZMMTu3bnDEnnuctJ7SFv0HWxy+bREOettfx3wFXaNJ8g1dDqf8/Jf0Gceyc3oxYS8N5l/6HvhELOwUBUcbk3dm2Gd1R4Uq8O0GxkqWPPxFJMMGk7zNbr5dXy+IpLk2Gh/RH0H1Qwz5Da+DkNL+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775488347; c=relaxed/simple;
	bh=kL2UUJut3o2fJHUs42ZXQvrQBJ96z8HhGrH22QxSwMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyEF99vFiPiIDFS2DD4Ht9dTtHC0daaI+zvwSm/u7etNqzUROlt4Q6p5Tfh/nDyDzMuHTkINakskUUSY8XyzAYGAy/+XM0DSxTIXLfdIC0ZnqDusC4QjlQHmYHLpfLMmNdKlNd5KZUY8dtWS1QQK734uWgBpYmwa7utMjjJE7HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB6anKlO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB6anKlO"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43cf73bbfbdso2480880f8f.1
        for <linux-sh@vger.kernel.org>; Mon, 06 Apr 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775488344; x=1776093144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UWT2jl1YmBSLjzDccsR3uGh5qIBOeSHKTstBptqLJ2M=;
        b=WB6anKlOIxrJiVO7yWAgaV2/Woj5KsGtbZWCep+02RN1eFdG9YPdd1EztHWm9MVCf6
         4VxuqF1muMLmE330A1yWJ6mezdOpE03MYwrji1dRDMhr/bT7pqzAfToRm/7gHYl7IPfg
         Cgeqt1AkgV5jK4m1rxu5zzGpGh+iUZg6AYsWygysnEOeLUY3BLW9wZPj1vQmfg05Xxj2
         UmN0vqrCTlwSeFZ7AGdJsLq+RYewOCzkKp/C8LEDtlkZ8X8F3EDklhTjtAeGh33vipRO
         /8IeCP7nlwARpqYKAAXtob+gboRu8uPvwaOfAV0yE46IoAcvFhGooERAugpvBZ6+Vp1h
         YJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775488344; x=1776093144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWT2jl1YmBSLjzDccsR3uGh5qIBOeSHKTstBptqLJ2M=;
        b=n2PCUn3FLQYAgDrkZlIPpep2o18NVlG+XyAOgaywK/TRwbhvZ+ZW+0+71QvBceXknM
         qUG+r1ojbExGP6hIWyopN7g93y03dgDXutT+RPHymPBLHv/urKbg9xhXkZLkgqqcQ3IM
         YDRgKLKE6tzD0ZVy0S5WtoM3Jx37/A8Vao8TOSS+2wAc16HFthgwzZNYhVvNwEEWRlOd
         A4/T0xg4a8iXEpbb33DVl/Vu4+K0ClD7cFdzs0zLoUCanEf77IqZynpdB7aTF566bujI
         pJkj+6J3MIy+vgrSRQb6PP9/xKjgz+k9oZmO5iheNOB95QRbDDEl9L/z15kuqNqj9bIB
         0jXQ==
X-Gm-Message-State: AOJu0Yw7/XfksliBaErzP+a1Nvs4MEUcJJ4WvLYt0YbfiQbAaz/BV5Dt
	aFjzvYaFVq8PPPPscUovLV4ui8+rUN10mJSbtZI3Kpt7KXZ+C8vyJuS4BF4iY6M=
X-Gm-Gg: AeBDiettZlBhh7hZDP8IA2HxchNOuI78xrqv9Iy7n4Cm3PWCJGS5M/3xR9joOJjv+us
	gFyir4R2S2xr4bLf/meZtGOtAORaL0YDPEqU/aWSFSyd55Jfndb4xyARgE9MkNNxKnL1onjgM+F
	+V6y3cSRZlc6zvexgGwH7WUX+vnj4fjyAg7LnXN+FmnB2gSbglMPSchwqF4FrtiQCg8RMSIZLLt
	kYzHoSmehmmNw3tAsKnI07fXxePB69EiYu3xd60NauHWTKRxoVZHeTsTcAkriSpBUOaiQSSo1bg
	SXIGEF94+ssCRgd2f39XwZVF5kTQkOjf8HxpxO0wi53StB8BmPcGYq9s2rjgUV6tZU7+ZkGJyM3
	VygsOPUtnSZ4X4CgYH68grAOA5Y9LIYjA8RsNcMGMvevLCG243bY7uxtfr9Y0SE8SHz4LORqrKr
	ROLvQXfBJSbymUyVoNtoKHiFDZkF+5VbZX4U+5buEYfsuzjDO50nqGyfkf2DTXVzYFaROujP4Sj
	nQ8
X-Received: by 2002:a05:6000:25c6:b0:43c:f719:a7f0 with SMTP id ffacd0b85a97d-43d2929467bmr19694461f8f.12.1775488344368;
        Mon, 06 Apr 2026 08:12:24 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:aeeb:3bab:9e78:12a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm38945048f8f.35.2026.04.06.08.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:12:23 -0700 (PDT)
Date: Mon, 6 Apr 2026 17:12:18 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cdrom: gdrom: update gendisk capacity on open
Message-ID: <adPNUiKm-PmM2xn5@lithos>
References: <20260405082330.4104672-1-fuchsfl@gmail.com>
 <20260405082330.4104672-3-fuchsfl@gmail.com>
 <CACwZE5Rmy3A0k3tvc32gv0V3T1LL2PaP_+S7N87mwNppLTh=PA@mail.gmail.com>
 <adN68wCJd6QEZyNW@lithos>
 <CACwZE5RfGW24wnWnwmSR0xUm1EZCCAzuaqug1FbhqeXXqEDTQw@mail.gmail.com>
 <CACwZE5TPt2Y2Xn+YSVv+BY=PkGeAVAYgsfeLPtCLYKKqYbrPOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5TPt2Y2Xn+YSVv+BY=PkGeAVAYgsfeLPtCLYKKqYbrPOA@mail.gmail.com>

On 06 Apr 11:21, Adrian McMenamin wrote:
> On Mon, 6 Apr 2026 at 11:00, Adrian McMenamin <adrianmcmenamin@gmail.com> wrote:
> >
> > Florian,
> >
> > On Mon, 6 Apr 2026 at 10:20, Florian Fuchs <fuchsfl@gmail.com> wrote:
> >
> >
> > >
> > > You mean, because one of the functions in the call tree of
> > > gdrom_update_capacity() wants to get the mutex gdrom_mutex or s_umount?
> > > I checked the locally called functions, but don't see that one tries to
> > > aquire a lock.
> > >
> > > I don't understand the exact potential of the race condition, maybe you
> > > can elaborate, where I should look.
> > >
> >
> >
> > Actually, having looked at the code path in detail too I agree that
> > this won't recreate the problem the earlier patch addressed, so this
> > looks good to me.
> 
> 
> Sorry - a further thought. This rechecking for capacity is only truly
> necessary if there has been a change of medium - is that right? So we
> can take the result of the earlier disk_check_media_change and if that
> returns true update the capacity? Is that not correct?

The problem is, that disk_check_media_change(disk) is false on initial
gdrom_bdops_open() when the CD is already in it. It gets true there, if I
swap the disc while running the DC.

So right now, it would check capacity on every gdrom_bdops_open() -
which is mostly on every mount, instead of only if the disk was really
changed in between two mounts.

Regards
Florian

Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46542351C02
	for <linux-sh@vger.kernel.org>; Sat,  5 Sep 2026 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620799; cv=none; b=RKv7E84Ktn7XzqnHrt6sEy5d9JJH6Vn6SM2DJVLN+PzNaHbCBlJrqB3H9o4m/cVsRLpUfjYs9PDn5UndOE3FmqqdURyYYax72nmh+RVwguGe5PAWuZmH4Ex6or7MjAT1/51PlT+5LJ+qytBkstvD9+8VvSGCxTotoxvDWRXs7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620799; c=relaxed/simple;
	bh=5cgtCk3fDPQ5wRV20+2UBTVYQPk1sLEWpYNXND0UQR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th3fbHJg5BdnypGUMsQCgA839GdFkJmoVLIF73RCvBY5yh40EGtlZSk16bi6oQ6SBAc/4YgkW6M/xmx2g4bEG+f+cf5RnIPE4buih9/9GwtFWey9NmVey8QJCVZpE6KyWA39Nx0yJMNSyd9VkANomI9gc37C8XoAJYGo3tdF9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHcDYMpu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHcDYMpu"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482ea739de2so1322535f8f.0
        for <linux-sh@vger.kernel.org>; Sat, 05 Sep 2026 08:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788620796; x=1789225596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X28rRkrvFiEd/hiyjYgtN09huGrFkZsRRR3M7rkr+gQ=;
        b=OHcDYMpuPlBiOlgHulHVjLgjrJFiW1cRr7dGLWmcHEvGqOa4E7uZTD/RUsd2dyxsbB
         wp+8U5JluqAWdS8KUsiOdT6AiS79iHpZiIq2M8SlnCuFocaMtOzqt1hpSePyHGjKzEyT
         QqbkMC9xl4899Uw1FXs8RbD8mVMFheqkqHQZ35DbxMyMSOgNPI+of+gIPfj17wr9/P7n
         TaWQPgFjNhJr6MHgorN0fTnOgZ3W/eeZZ5N885oA8YMFFuE6ZEx3Rk2AUAGvr9cCgt6d
         JOvLqBlqoYg0y6hSZNmc90ApG+oiQtRPCgjM2DctC9XiBlVnpapQLTmcbDAGNZLVFTSE
         +Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788620796; x=1789225596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X28rRkrvFiEd/hiyjYgtN09huGrFkZsRRR3M7rkr+gQ=;
        b=CJ+404x4IbH+RvU6T2yVdp2oQ5WA9WeypWPJsNI5kRWq2gAlIyXzNsY1J40CwrF3Ei
         17U6PTNTvB4529sbstbkoyUdNNssKCtRtpy9Vn3VxpjycEiobuyuH0tgaOb3xdjHv8T5
         LpiYgx4uKglMrBUcBwc5LiAv2I4BfFiAzPvjno8nelhmbqautzRKK1QLB6yq9xF6Dpju
         Anj81qw2gfj3fcE2mR+j53ni6mrd3521kd1CHUMfW9ifsrnmsoEr+6cVAvEv1083MdYb
         wkhgoQmBDADPwT7FSqmxLlkosjtfnzAlFiHGHTkFwvBueuHcnEHltr89yah1T00UvQQE
         Eogg==
X-Forwarded-Encrypted: i=1; AKwUvByyXsz+/1hK02ZcD2B18PEHUXQYy5BygY8A6Ik2b+uJa0HvzRRwp308IOXiUf3FTz4hcTFzYwyZHQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kVj+8vtAt9ScLx0fFGRzqXneeDB9w4Zla2rCFVScakdwohaIVJ
	NkWWA2eoinvxT4TVtFn/mWL8sQeWGxSOvssnv7YLzzI5PN075oGTAt2ZB/EsGw6x
X-Gm-Gg: AYBFou2S+EqvDVXATuS9Y5GJrVfTODPWdKegwColiqNHtTens71KKqbPtxZXBEqG+py
	vnAZOd7vh4G1kmm3hb4B488kiQxPwUPbzdR1JlqLYnDrMTttiUD4tUuQZa8cVM04RFmPZTYZVhR
	AxCzUMwyOY7xkmKSNs+5EtmRaN5zKoBrZRg1y47kk6/fbykOeCeKYG2Q4ZVqIBVLRO9mNIpw8Nm
	A2+7sqYMQ7QUsnT52V8LVRuV2ExgqHyJJqSyEUz/N2VTKPucXNUhbvEG0p7atxGWd8HYM4Yc+13
	vwiU5wqJr4sj+5hvxxd1qxZ+7QyMJK3TvcDBGfS5FHnEkak88+sJhv4iqUfcj7qN6fxEkFgdjc9
	+lUGPwJ3tqsEZrSoSSiV5LERH4CiywttIC6Ui2wWb3OJ/8oHBiXqy0ioEDf0sxU2oPk++6ZcTzA
	hVjoXLUwBqzj3rdKAPWGOKMMxrWKDUGNjjPFwJCpJRq59ZO7EjNoun70knhuiHB2X9pYz3k8xpm
	2NxVsUSiwkhs+a+TgXpI6mzTS3wFvrP8TrSy+b2BxzffCxadOSYejLhYmooAqs+RLpXlpmTdwFU
	7YRlRMUgyPxyXQpRa0B3NTtm8y/4rRSOMXP5aYLg/9CKZxlIv1YrFms0cgom/jC3
X-Received: by 2002:a05:6000:610:b0:485:82bf:8728 with SMTP id ffacd0b85a97d-48586e32b7amr16312283f8f.0.1788620796182;
        Sat, 05 Sep 2026 08:06:36 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c6ba4sm16509701f8f.25.2026.09.05.08.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:06:35 -0700 (PDT)
Date: Sat, 5 Sep 2026 17:06:33 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] sh: Drop the selects of the removed
 CONFIG_USB_OHCI_SH symbol
Message-ID: <apwufhbG44hRsNWm@gmail.com>
References: <20260905065340.24932-1-kmehltretter@gmail.com>
 <20260905065340.24932-2-kmehltretter@gmail.com>
 <CAMuHMdWYBp0d7m0Q8rWva+EA=4nOezm1os_6ZVcrh43aPjCCPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWYBp0d7m0Q8rWva+EA=4nOezm1os_6ZVcrh43aPjCCPQ@mail.gmail.com>

On Sat, Sep 05, 2026 at 03:55:57PM +0100, Geert Uytterhoeven wrote:
> >         select CPU_HAS_DSP
> >         select SYS_SUPPORTS_SH_CMT
> > -       select USB_OHCI_SH if USB_OHCI_HCD
> 
> This is wrong, it should select USB_OHCI_HCD_PLATFORM instead.
> Someone has already sent a patch for that[1], so it would be great if
> that could be picked up instead.
> 
> [1] "[PATCH] sh: Use generic OHCI platform provider symbol"
>     https://lore.kernel.org/20260624081926.12426-1-pengpeng@iscas.ac.cn/
> 

Yes my patch is not "wrong" (doesn't make things worse) but clearly this 
is the proper solution.

So please consider both patches of this series withdrawn, the
defconfig change in 2/2 is covered by Pengpeng's patch as well.

I have resent Pengpeng's patch as v2 with his authorship kept:

https://lore.kernel.org/r/20260905145225.88518-1-kmehltretter@gmail.com/

Thanks,
Karl

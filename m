Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F802457E7A
	for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792350096; cv=none; b=aof1ztoqu1HEvlRaRelaoMJW+0x3IsiX2xgVuxZlLQD7hMrY+rZVlMvu+/1ifsAykjQjKFwMeHkgt/UIUODz7C4WeOYR1at7JcWGQ57jm2D99J04OQhNyB/XomEFFbWaCkvMexYC7phosn6C0D2SQiTC1ALC+zByOURTNMf+j4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792350096; c=relaxed/simple;
	bh=kzqeDAgce2Ard5nYDJ+4m9yakbptSbQvaAV8qYpI9IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q4GpjAyWtgcOyoNV7wK1rM1VOFXdHbbIWstnfa9OmEgH0WcgVoUi4b8vHsHD4IUW2qcR9kTjcMa+8Y7oSUCr+TqsVYqJP8MbQ6ge2VYAiQsZh31aaP5csC6XNXl0JSigc9ymTVjrA0D65qS4sxbwnHINFHypETEQb5wEtmgnfQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BnRntcau; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BnRntcau"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1698ea378so10143625e9.2
        for <linux-sh@vger.kernel.org>; Sun, 18 Oct 2026 12:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792350090; x=1792954890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NxERPHF1xEoT2ysKg9g7mOTwdVPNji0iYlNP3mxPrtY=;
        b=BnRntcaudlySkYNy5JFRt1t+2hrnXPp6baly76qnNtHZaC1ZpuUDmq7tJK3+MWCT7H
         PUBrjiWI+QrHzGfuix1ZOKhazGKP3nFqp5cZJIranjDk+PDbzqpm2xG+uKHtbgqTeQfB
         JiBbQoBY1gYWJtho2z65YBk8p9nFLuI9eZUUjikmZofTba8ot+O3X/j/v0RHEWUDpeWn
         hqdQ54j6n2TCgGBemMj845fQog+FU8CEMomguYaL7NyVyF3Ud4kPuxD764ipqhLClvHU
         cmDEqIsNAHCWN7E7qzcjfVTzE6cY2qmNgYgFQwVjCQMYi9fZ+Dps5jvGe7T0T6RvpecT
         4/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792350090; x=1792954890;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NxERPHF1xEoT2ysKg9g7mOTwdVPNji0iYlNP3mxPrtY=;
        b=RkX6GEPjsy99+E0wQDNHPVazvC04yZtYbMvkd/4pldVcPdLuLt66WjYWemfTYypKmF
         CvuKNFQ+MrKSVYKFRFxVA10kiRowALkAjZ02ANpQ0yzJPtOassMS4ZBTTBBl4cyAOq1F
         /MCpifckBD98PzOLtp+7c9vOgqmJGb4CDDTzryMxHjMEsBxLN5ScYkvyhBth1QRXP19R
         gSdTRqKgk0u+hQA8FkK03YR+4OyHaykYdb9DVexhgaQjuR6dplOyFuTrol7fFRVhJE5E
         I8YrUFlZQYiN7dpjDR8i4FCvbt6I+NrJRDmZedzdIqSwxkSKj6mqwg9Qnayiz81v0IKT
         KH6Q==
X-Forwarded-Encrypted: i=1; AKwUvBx9HdRmu2Al7a5L+3t6RAoTjXWIZtJS6jPa5iQ8XrRF88iIGHqn7fvoMl5l0mAfhaBGxLWtDGgtCg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJkY12JMvvXAemRLBfVoOuLZldlx+aomo5GLV+SvmFmYjT/vfB2
	snBzfA2OoZIeLy+RJVX/fYG/VZTFsml/KnOHs7cutVWw9MXZceRR9FE=
X-Gm-Gg: AYBFou0tY7YLeBqBd8LlaFACRNu55OCMFpT7miZsZ0dcriBskFBw0uJDzqdY2l1HIdA
	esMkUG+eSTbWXTmbeOWLSAvzVzGjtfjkcZHIk9aau3BOye30dyZQgZs5jO46oOd3pPcdvITV+ae
	J5Dpk+NHbCTzEiXW/sV1vJCj/bwS2Qnfoz5uco3EQjx/cs862s+oWP4YXqU8OQtAyVGyg7Ddl0C
	knfMkJEp4bIxEWmnevvGrOsIDXLpjymk9MItawgot/BrYgptFOSjSixtRNzdEsbLCmMw3VKIy0d
	gvZsTXa0/qexa1ZH4uccMigMubponForMDJnPDoPoY/spKHVa3xGikGMncCfegk8v8wifCRyOYS
	o5E6lmKIR30qpZjr3gWSOU41hyRRra++usWgqEyMmj/GDPBKOOkgTOXfcn6EPK9ItLHURiHYamY
	IaAUdWc+Sfx4j+kKM/Yfd0mRzaFEecRVLP5vfkoHu1iTnTa6ifoV4pVQZWzUDfpip7N8KH8LjYN
	9gRh2w0yXqvLEVDW2mRxy1fojifKZzwX6HND8nsm0+F+sfwbM8=
X-Received: by 2002:a05:600c:c170:b0:4a0:1efa:c74a with SMTP id 5b1f17b1804b1-4a1d76060a7mr106131935e9.20.1792350090132;
        Sun, 18 Oct 2026 12:01:30 -0700 (PDT)
Received: from lithos ([2a02:810d:4a94:b300:f673:adaa:3deb:83f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm271208015e9.0.2026.10.18.12.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 12:01:29 -0700 (PDT)
Date: Sun, 18 Oct 2026 21:01:23 +0200
From: Florian Fuchs <fuchsfl@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, dlemoal@kernel.org, cassel@kernel.org,
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org,
	geert@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sh: landisk_defconfig: enable PATA_ARTOP for the
 ATP865
Message-ID: <atUXgx3Bmc4wdXdR@lithos>
References: <20261017041419.311921-1-daniel@0x0f.com>
 <20261017041419.311921-3-daniel@0x0f.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017041419.311921-3-daniel@0x0f.com>

On 17 Oct 13:14, Daniel Palmer wrote:
> The landisk defconfig currently has a similar but incorrect IDE
> driver selected so IDE doesn't work out of the box.
> 
> Select the right one.
> 
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> ---
>  arch/sh/configs/landisk_defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
> index 2b7e10c9acee..6b5ec1f3ad71 100644
> --- a/arch/sh/configs/landisk_defconfig
> +++ b/arch/sh/configs/landisk_defconfig
> @@ -28,7 +28,7 @@ CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_ATA=y
>  CONFIG_ATA_GENERIC=y
> -CONFIG_PATA_ATP867X=y
> +CONFIG_PATA_ARTOP=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
> -- 
> 2.55.0
> 

I can confirm the PATA_ARTOP is the right option for the Plextor PX-EH40L
(which is like LANDISK HDL-U), the mismatch of options was btw introduced in 
Fixes: b7aaf16d10bd ("sh: remove CONFIG_IDE from most defconfig")

which changed CONFIG_BLK_DEV_AEC62XX (which supported ATP865) to
CONFIG_PATA_ATP867X. To my knowledge there is no sh landisk device with
an ATP867 chip.

Reviewed-by: Florian Fuchs <fuchsfl@gmail.com>

My PX-EH40L has btw this lspci:

00:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8100/8101L/8139 PCI Fast Ethernet Adapter (rev 20)
00:01.0 Mass storage controller: Artop Electronic Corp ATP865 (rev 10)
00:02.0 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.1 USB controller: NEC Corporation OHCI USB Controller (rev 43)
00:02.2 USB controller: NEC Corporation uPD72010x USB 2.0 Controller (rev 04)

Regards
Florian

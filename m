Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BE62E40D
	for <linux-sh@vger.kernel.org>; Fri,  9 Feb 2024 11:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478483; cv=none; b=g5CkD3HDqRqBfrbDq1fwg3Wxnaj7WOnKNmfioCC0G56bNW8qUiScBHoei7BsMUwOtUx2bkwVQaPXEpNTtFE9nDjacywMs35ef9CwV3GXAzLJY3MXzwQan0512uXky9lP77xX0dzs/UVx3GJeteHnU67zdUyiM68n8Q6oGYJqDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478483; c=relaxed/simple;
	bh=anM8H8ekDk70qUU/OU5ybbHEy2oQ0LfezROCfuiZVm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VM+jcGhyVc1UfDpjGDS3rK+rmhbrLaF03nk2FFHQVnKoljrrIrwZkVg3GasBtmlGwtwoe7toAqkhRX4Pwj2aZjwSH8TbORuDU/q+EKPtLEq6Ul2hPneUnSdrt7FB3hWmE97gLR4yiDSv5eKKt1tba/B4HpwswF1h1HIEIn+9EsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uxazuhoc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxazuhoc"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-604b2c3c643so9516727b3.0
        for <linux-sh@vger.kernel.org>; Fri, 09 Feb 2024 03:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707478480; x=1708083280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dBuwXRSy38eT9mIupMpf6DOe+SA9Yv7KcoKl+Fk1z1w=;
        b=uxazuhoc5uWFLOPXQstRh7i7TMILxb7KQLd79FeEnRQWnCAz7gUweFLK26wHUdopYK
         26ifxU8SgCKwGR2Hj+4FiVznEbjplgoq/7PgmURYXf+qZ62yfg2OaNaWoceeSDIrfOlE
         94qz85gozU+VEDju3L2I7Ckl8y6hvHLzaYE05QqDRPoH+Ld5SmhDETsPybThUjhqqMey
         QxFEA5mniywuq3fuvLiDCgvuLfg6+fEastre1fUkMGQoQ7yojaLoOvcj+bCQkhBJmgAR
         mGnZsfm5QIeY0FoUzwzEw7xXK5wsHL0sk50cIXrFOsdnIqkPDjXUjcLCD/mG9IMuzyep
         5Fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707478480; x=1708083280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBuwXRSy38eT9mIupMpf6DOe+SA9Yv7KcoKl+Fk1z1w=;
        b=A/ru844Fjz1MPFNuqz2knP/iVwMi5+qS8/ogluI8CjVcx28G37XUq1WrT/n7nCWh4I
         LEh7ZJtXZqGywVjnvSpa85NXfagnOix2RERSCEYCxqy+9PULr/hqon105GbtLNErlxpK
         /5HcPr0+g3ru9Av9kQ5mcjxr+tUSYnJvLqlZIKzkEiYFVWUBXYjZRC68BbB5BgI8RhUd
         a90f2N+PBpcFO5nNdqjyy4v7LlmteL5Rm5tVMKQu+JeArnCd9H+JDhlki6JoDMxh+D82
         6QS6mOfOt9eAXRCUeaEsRmAYvFOrFYEMJ4xzi7HfGVZuCavBQbzqOpBBvFyjJljccbgc
         SoZA==
X-Gm-Message-State: AOJu0YwbmHL/Znc2RDBRSA1iTjuK6UqxP+caAwtPrr/l9wmrJdlIqRrn
	WnidTi1eGAIRNxBv/dl1lK8Btn6fHVmNSVP8O85cRRHeEARPPzWEd+2cbom6WLufw61TZ0xtYHX
	KjD6s/ZZixGqnzPnNMluTaYoKFbBvRLdq2oOg3w==
X-Google-Smtp-Source: AGHT+IE9nt+KDrV3up84BrX2E/jgb9xngNDUdWzC55v9koHut4sFHX5k1nC+RJ4VY79vZNasOaRbYrMXtbObIbwTvA8=
X-Received: by 2002:a81:8457:0:b0:604:a477:6024 with SMTP id
 u84-20020a818457000000b00604a4776024mr1179768ywf.2.1707478480688; Fri, 09 Feb
 2024 03:34:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 9 Feb 2024 12:34:05 +0100
Message-ID: <CAPDyKFpmfgwJ5dJFmORhg1tBewzhB_jrWikpX=b23r-joN91SA@mail.gmail.com>
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 02:59, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The MFD parts of the TMIO have been removed by Arnd, so that only the
> SD/MMC related functionality is left. Remove the outdated remains in the
> public header file and then move it to platform_data as the data is now
> specific for the SD/MMC part.
>
> Based on 6.8-rc3, build bot is happy. Branch is here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification
>
> I'd suggest this goes via the MFD tree, so the series would need acks
> from the MMC and SH maintainers. Is that okay with everyone?

Wouldn't it be better to funnel this via the mmc tree? In that way, we
can easily avoid conflicts with additional renesas-mmc driver changes
that we have in pipe.

Or perhaps there are other changes that make the mfd tree preferred?

Kind regards
Uffe

>
> All the best!
>
>    Wolfram
>
>
> Wolfram Sang (6):
>   mfd: tmio: remove obsolete platform_data
>   mfd: tmio: remove obsolete io accessors
>   mmc: tmio/sdhi: fix includes
>   mfd: tmio: update include files
>   mfd: tmio: sanitize comments
>   mfd: tmio: move header to platform_data
>
>  MAINTAINERS                                   |   2 +-
>  arch/sh/boards/board-sh7757lcr.c              |   2 +-
>  arch/sh/boards/mach-ap325rxa/setup.c          |   2 +-
>  arch/sh/boards/mach-ecovec24/setup.c          |   2 +-
>  arch/sh/boards/mach-kfr2r09/setup.c           |   2 +-
>  arch/sh/boards/mach-migor/setup.c             |   2 +-
>  arch/sh/boards/mach-se/7724/setup.c           |   2 +-
>  drivers/mmc/host/renesas_sdhi_core.c          |   2 +-
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c |   5 +-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   5 +-
>  drivers/mmc/host/tmio_mmc_core.c              |   3 +-
>  drivers/mmc/host/uniphier-sd.c                |   2 +-
>  include/linux/mfd/tmio.h                      | 133 ------------------
>  include/linux/platform_data/tmio.h            |  64 +++++++++
>  14 files changed, 81 insertions(+), 147 deletions(-)
>  delete mode 100644 include/linux/mfd/tmio.h
>  create mode 100644 include/linux/platform_data/tmio.h
>
> --
> 2.43.0
>
>

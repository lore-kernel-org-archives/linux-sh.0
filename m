Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D640918EFF9
	for <linux-sh@vger.kernel.org>; Tue, 10 Sep 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978941; cv=none; b=p6b1DtNMgNojmNv5oQ3SwSTFSgY8cYmr9NyVZIHCb/Z1lpo8rdnUshLqTWzvghR/Lkh9YFbXtnzSJ3ipeGwEEqG9X9yCoryBXfASll2cpMYpktkBPWHwz+fLnSRoV4oD9Cloj1dShJ2PDLBml/RzINFfLykRpZKE5mtlRaXwihs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978941; c=relaxed/simple;
	bh=7RCDHK+BTLtJJc3M9GwORWj8tI6RSH+IGiIxcm0cxME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SK0dk5pVGj1zgSJG7EBpgmTPw84DAEw+jDcDzxqhBSDKx+bDvzPSSLp96blVpCMLsPpW4D4XQtRutwmdkbYj9JO81a+ffqbRIW2kkGlILjSlXkFMDA/hFA1VqVf467aBxNRm36y+ylBOTOtgFame0vxxQck90U8w9016oJqh5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DFBcdUGt; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFBcdUGt"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5019d48b1aaso210855e0c.1
        for <linux-sh@vger.kernel.org>; Tue, 10 Sep 2024 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725978939; x=1726583739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WifKBD4WaotF8X+UtX2lfxD1eqAgMkavmDZNd0guNfs=;
        b=DFBcdUGtlcNfs8DXsRQ2bmFiOpc3pCRTp4d7NQhUL1OOBMvUZix8AsEOi1TqZtzcUq
         fMjNbb6plPaX0ixcYDcT4eupqn+lfDdctfhMYj+J5gBvp/7x7ny8FcDpoytfcF/1/tXu
         r58YdKfp8drHXShS0Pg2ak/1WSpNc/S0nJZUgVN3wH4YxTY8342DEqZvxFScNcd4GR6P
         XrVL7uYEPnUmsvIyIo7PreecZtymLvU92mzRmlVXFd8TtEwwnA/kaMYRlTzmXQ3IxlJf
         2YCdAO97/7ymI7n6gIceVjxcLyuxfhzNCbK3Y04cUcopCY7ygvfYp6Ua/PnaSR0GoykS
         gmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725978939; x=1726583739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WifKBD4WaotF8X+UtX2lfxD1eqAgMkavmDZNd0guNfs=;
        b=lOXckwtXxqOkW0c0OvLTDdWW2Y/jHX+Kzqiz4sj0OfVfrQLpD4hTGidnIV2LCfGXIk
         7IcOg2whNMJtMaoJIKvM7GVT3gxHpd5TlVOQT4Y+IlaWQFbCCW3A1DI/ys8K94B6GR+P
         +VrZtsehNktaIUqZzxw0+B38Ucz9OZL3KIQdbNb+4HTIhl8FS2gUNhlxUaz82Zf5xCpL
         nxdYFhMmFB4pekadRB1jDCzbT8jbkTbXvU0StNUo4ua5+WPqRXITZtOn9b/y58TuSrB1
         nlo34oP6+hBK8NfvJd82gLLYEpH8x4JHNy/HmNlxNVXybsSkIWfMuu710VPqsiELEmup
         85CA==
X-Forwarded-Encrypted: i=1; AJvYcCXnM1lu9giEIY0qpdJ2P5KlNfSXgv8Yv+JctQ5g01FRavq21ja8Pe041gT9Q//AyLZRP+qaSBjisg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdU4pEkd8Vnykbhv+BsWKyz3imlq2hTApY6aJEAz0gYhdv6yJ+
	2OkisUkpuM4NQLxQdoX7YDwAuptA0ujgf6ubaR3JQQ5LjfdInoyJVkzTepJPffIsSGEldgXBjVN
	JjmugPWkJmtthYDq9lEeQneqbVY2AvY497vKkZg==
X-Google-Smtp-Source: AGHT+IG56IxeJxMzo//8/ECLyeSetMnxmdoCauE97u7O2Z/LJKU+8CVElNiOE3Mdlcu/xMKPnyg4APMxgLv49j/w4BI=
X-Received: by 2002:a05:6122:791:b0:4f5:3048:ee20 with SMTP id
 71dfb90a1353d-502be8cecb7mr8674939e0c.5.1725978938569; Tue, 10 Sep 2024
 07:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910092557.876094467@linuxfoundation.org> <CA+G9fYufdd0MGMO1NbXgJwN1+wPHB24_Nrok9TMX=fYKXaxXLA@mail.gmail.com>
In-Reply-To: <CA+G9fYufdd0MGMO1NbXgJwN1+wPHB24_Nrok9TMX=fYKXaxXLA@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Sep 2024 20:05:27 +0530
Message-ID: <CA+G9fYv1yHoL9r7PkunHPNyPznLxfB9spSFbWvoFBBSwOYrT3g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/192] 6.1.110-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Peter Zijlstra <peterz@infradead.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Sept 2024 at 18:24, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Tue, 10 Sept 2024 at 15:36, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.110 release.
> > There are 192 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.110-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
>
> The SuperH defconfig builds failed due to following build warnings / errors
> on the stable-rc linux-6.1.y.
>
> * SuperH, build
>   - gcc-8-defconfig
>   - gcc-11-shx3_defconfig
>   - gcc-11-defconfig
>   - gcc-8-shx3_defconfig
>
> Build log:
> --------
> In file included from  include/linux/mm.h:29,
>                  from  arch/sh/kernel/asm-offsets.c:14:
>  include/linux/pgtable.h: In function 'pmdp_get_lockless':
>  include/linux/pgtable.h:379:20: error: 'pmd_t' has no member named 'pmd_low'
>   379 |                 pmd.pmd_low = pmdp->pmd_low;
>       |                    ^
>  include/linux/pgtable.h:379:35: error: 'pmd_t' has no member named 'pmd_low'
>   379 |                 pmd.pmd_low = pmdp->pmd_low;
>       |                                   ^~
>

Anders bisected this down to,
# first bad commit:
  [4f5373c50a1177e2a195f0ef6a6e5b7f64bf8b6c]
  mm: Fix pmd_read_atomic()
    [ Upstream commit 024d232ae4fcd7a7ce8ea239607d6c1246d7adc8 ]

  AFAICT there's no reason to do anything different than what we do for
  PTEs. Make it so (also affects SH)

--
Linaro LKFT
https://lkft.linaro.org

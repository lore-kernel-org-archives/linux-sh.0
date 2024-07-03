Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870A1822FF
	for <linux-sh@vger.kernel.org>; Wed,  3 Jul 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720028731; cv=none; b=IhOrgic0x6XzPknwHMP59Rp/HPquyVE0CSw+juSxv7PyhFJI8rL1GOpn/oKZ96n8JbQ037DKA9UtS89lijjZSH2Rcn5zmprQiBgbm9L4p1mfUHc46iH7FRZz8ykHVEIIzL/kIkgdz32sEG8CmfQRcb95A+99EyVFaOjuPnShTxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720028731; c=relaxed/simple;
	bh=sewsy2PNlhAHTIAwKUo9Yw0nLuZyn06JcxUxF2qHRro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLxGM3Z6iuNo7FXhvUrfX3Cp59DZX3y7Z5ME+iu8dBUyIKg/ZOPPEZm6c6T3OlqMc6AN3IXChxjlOCVJ5Tq/j6SumWpjD6yF7iV/0arBEDV4wnQbVXsQUP1VQtntueM/fRmyHE9khq/N/PtZ5Z7rICVY+VzYG+EVN6n2SbzMnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H9gK+6gN; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9gK+6gN"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-48f8f50e3b2so543686137.0
        for <linux-sh@vger.kernel.org>; Wed, 03 Jul 2024 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720028728; x=1720633528; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5cDuIQ1SVOlntwrCaUKDE4lSKPTpSufh+g8wiE4Zb5w=;
        b=H9gK+6gNFkNif9f5Om3r1qahSVWzvUjj7YOCaB2G5TSAmczwjcSRC3c0eYVgwKkB5k
         9SqxqzxtxeXcsXUcklE8R05cGum005axMuCX49I/0AORAnRf32NM/GnqA2EkaWaZnKXF
         qHuLp1CzmfR28usCALTRLhFGxfINJLozIQZQrUrIAL/BCGNB6qfbaR6oR4IomlXkej6x
         Ns2dkG0YwqIhyJRrAa3EB6qGpw7kQOfpdLkf7aO/TmpY6uMpMM4Z3QhF9E9kNNTeuhuK
         qfYyW8K/SQSBtpoEA3215+L3QlPCjKGmmPp+rTKw4alNHCh1VVNNLt2GJa9BRHdxjOMS
         lBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720028728; x=1720633528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cDuIQ1SVOlntwrCaUKDE4lSKPTpSufh+g8wiE4Zb5w=;
        b=wB349s41WawTFgpNYGaGCld9NWpHVvL56C7lioYYfG7pGDdufLzUn3AGqJJxpGbWc1
         4RxNfbU3laZKAUQh02jh2hVVGdXDINziozjtLuBjO4k7OIBLWDoykQgE6jHCqDxmYQuc
         tiGdkEHZgK0uDmHf7Zxv7yxyusZp4V072O6YSVzmWbZc3OWAPmOcrd2IEc7Hl+QZyQHY
         MJRNbPlohzrJIrXtj/4Jhs6TzCHR64FmntYbatFP9jmuMKQ3CIbnU4EsJ9GXZR//5fVn
         XTq92Z7r5rs/fFQLBNugpBh6puSTdI6vaoSJdBmal525C7DTP1YiZ0Ph1RxbF+UlVVHx
         q0ig==
X-Forwarded-Encrypted: i=1; AJvYcCXeV6SArQvbKN7BF3l1ZTZmC1itqOU35/LfXhsOS5KMrCju6Arq8hb9AgUi4stds5pFplbkH25m4MUazLbnlYStkx3cN12nLY8=
X-Gm-Message-State: AOJu0YxeGnz+sW9S/J5/xLfpBITZcA8GwHTw5wtqt+obxfCreXCMnESS
	SYiwFqY15+viUeghZybH2N5B04wOcumSC7kTXiAwJLBqa/7fIbF6c8o15ndu62BBdOll3HkoYxh
	y3cOx5HqM6yHGnQyR4Yy+d53g1N/O+m9E6W8s5w==
X-Google-Smtp-Source: AGHT+IF+f1WlbG8vYxx3JDKGgZzmMKhXtY8j4lhiNmTEhtO8JGWtHRi31ETtlSqGO8zmmaqnZauCj6D8pDnZbW6J8iA=
X-Received: by 2002:a67:f447:0:b0:48d:a4aa:35f9 with SMTP id
 ada2fe7eead31-48fdec17e8amr1799967137.4.1720028728227; Wed, 03 Jul 2024
 10:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703102841.492044697@linuxfoundation.org>
In-Reply-To: <20240703102841.492044697@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 3 Jul 2024 23:15:16 +0530
Message-ID: <CA+G9fYvAkELSdWF1EYyjS=d_jvCJD0O=aPnZFHUGnhYy6c1VCg@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/189] 5.4.279-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jul 2024 at 16:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.279 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 05 Jul 2024 10:28:06 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.279-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The sh builds failed on stable-rc 5.4.279-rc1 due to following
build warnings / errors.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on sh:

  - gcc-11-defconfig
  - gcc-11-dreamcast_defconfig
  - gcc-8-dreamcast_defconfig
  - gcc-11-tinyconfig
  - gcc-8-defconfig
  - gcc-8-allnoconfig
  - gcc-11-shx3_defconfig
  - gcc-11-allnoconfig
  - gcc-8-tinyconfig
  - gcc-8-shx3_defconfig

Build log:
------
arch/sh/kernel/sys_sh32.c:68:1: error: macro "__MAP3" requires 4
arguments, but only 2 given
   68 |                 SC_ARG64(nbytes), unsigned int, flags)
      | ^
In file included from arch/sh/kernel/sys_sh32.c:11:
include/linux/syscalls.h:110: note: macro "__MAP3" defined here
  110 | #define __MAP3(m,t,a,...) m(t,a), __MAP2(m,__VA_ARGS__)
      |

Build log link,
 [1] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.278-190-gccd91126c63d/testrun/24510005/suite/build/test/gcc-11-shx3_defconfig/log
 [2] https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.4.y/build/v5.4.278-190-gccd91126c63d/testrun/24510005/suite/build/test/gcc-11-shx3_defconfig/details/

Build config url:
  config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXtbqe6slPmKG8dbt7I6JJ7eg/config
  download_url:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2ijXtbqe6slPmKG8dbt7I6JJ7eg/

metadata:
  git_describe: v5.4.278-190-gccd91126c63d
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
  git_short_log: ccd91126c63d ("Linux 5.4.279-rc1")
  build_name: gcc-11-shx3_defconfig
  toolchain: gcc-11
  arch: sh

--
Linaro LKFT
https://lkft.linaro.org

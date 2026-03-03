Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C684A33C1B9
	for <linux-sh@vger.kernel.org>; Tue,  3 Mar 2026 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772543022; cv=pass; b=g14fwyINtkow2BbW7YZEO3eFWE/qTYa1/cdYJQ63qq4UwVESIs2nOj1WAO26RTufk26xS0UMIu5Q3UW6y4UIfcNUC5fkX86eZIBl8nPK9BevTqH+RWYRgO+VxYv0zdM8etsLOLVmHlICfxzCrfSM+NR2b00npdDwR/v++6Yttb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772543022; c=relaxed/simple;
	bh=bdXuAHR+W7DcDsgTssbNNylZwjKna61a4d2JwD1CRZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FySihXVLRy7et5AV0+lHG6R1BRjzdfgfmW/hmsuv2aZ6CF8scGOjqVs3Py6cD3J0ZGPs7sPTVKUudrvfgOnClmj19s1lXG19hwpSqdH7oOP2R4o9iKgrJV8T+OaemogacYVsLZOgJSxbTnV6bq2f76Vh/PSzrDhuAkh503E7f0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDMK0bJ4; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDMK0bJ4"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4042fe53946so299867fac.3
        for <linux-sh@vger.kernel.org>; Tue, 03 Mar 2026 05:03:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772543020; cv=none;
        d=google.com; s=arc-20240605;
        b=SQb/Wnc+Yns4FajPxs4VHhBrWdntB/SSGIZDSU4pbqZm6pISnksGGtaDI8rJpdQrEd
         8ql0GoffNZSyyGVxQYTNSou8xw4w/2v3KBv/oYx3/omc7oLTiwR2H50qJjK2C36arbOp
         q7fXpS/MTnkj/vuycckErTF2MdcfqXHCnTDVdvIQ7qmd61YaPhmvVOZRJqvc5WaNxTmA
         kZOU0TBkknT7+uqsKZlEez/FU2mHnlHSSC2vbi/3/iULicRzIISw0/lg8Cv1hF7keReE
         nI3p+pYbpwRX5vEdGrPwa6DEM1svvFThVmxt9rJZ8cEOaoI80nCfH8p+60Zn/YrJ5Xtq
         nWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fXJCi76LsoMAmD6ooe8NZCj0HaxUTDKfSurt+CM2Xuw=;
        fh=Jl3tNVgKs+Ix4xLa2o0GHQiY9oCoOqFu1+0tMGY4MXw=;
        b=SeJHAA7AQ38WeYyx8eHv/bUxwvOEqkl+ka6SDWZEFnWftnmtkjpF8dFdzqCxEcHKLZ
         5RY5FOxXLM0zGbx6cXnn/oMX+DRjInZzCDk42gnGvhW/b0YGomm2qt7aWndEZ1qwbOSQ
         ve24sDovwifkMbk198vzbZ+ToGoBoetRIo/t7LJd0NtQhePKcWOVAVUM5j1x1GOYDePt
         AAT3X1gvQGKhtLmX6teo71kaoXSx2xs54VkgoWa2upcDZv4wLWluzvrWUrPnGX9ufgr/
         5dzGgyclrmObQwSnXLtxgq2COoPjnAj92Q43EygLLw47QfaFUpCS7h4imY/kpd9tf9Rr
         cofw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772543020; x=1773147820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXJCi76LsoMAmD6ooe8NZCj0HaxUTDKfSurt+CM2Xuw=;
        b=DDMK0bJ4IhW4O3tUQ4nA/+xOWBNE1ioav5S5FzY/jWWS5ycjtIgAgkIi4kPzz11Ok+
         DtzkXfRNkhHvWk17RCat+vgv2bB5mJcYVCpFjRBI/PZ26+Tux4DDBil+6Zf5d3lpANFi
         imdIaCvG2cyPDsA66GhBqSFV2N7j1WUiofwtKgHRgQ0ixk4UNrXTXNKDHAVFzL69YXNF
         nVDDuukaz/P9yXu5fDmLv4WqpbwUIYuu372t+XDv/mLcNfXyDNeLOf+FhBSkZcNek7OM
         xptcjevbZjCZULwZoxhX6vVUgssJ66px6HcK6LgdBwiZfG8r8hzg00gwrvSJMGKgRzdb
         vKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772543020; x=1773147820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fXJCi76LsoMAmD6ooe8NZCj0HaxUTDKfSurt+CM2Xuw=;
        b=CImuPmQLItn4OQ/JF++75pd+xLRm7LW6ixqc/uswb9/ws2PlqLptMpM4TRoasNMuw5
         iI4N/uoAWzOjqdJ6bl0Tv340Y9JKxS5nguAM4ytDyYpbIWnaVb2hwQc0gghVitTJ3lFU
         3uHeXbo9+NcYirZdf+R5Aks8WDfrMOvi+q80pVvjApyYqslR1EOWWB5wRjMxpFfzhVmD
         MeuphCzZ/jD7HhY2e5G8RCr2ajwrXQDtgO5/Y+6Ipl/8dvDsY1Uw/P7HrPmu7cjWAc3Q
         PjZyQArAuoFeb59PAJAZisenIIsIobSpcR/tkpf/eq8AyxyWcST3ALwsnxREyRACu9Pp
         UMlg==
X-Forwarded-Encrypted: i=1; AJvYcCV00O9rpPkdoIkHdRmlcI7e0cfQ3XZcAoO3SuZfMff0xjTYS3vaZyNWkNnTfAZLKDm31NHfnvussg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyX6vs7raxlnsQckR5vq3BYDN6n2XsksTugv/jjQbT60XKfYvvY
	5VkRWuT7cKHUaKSqwZMk6nRYr+f4dngXj0VwYBGnlJrcCkX+LiXka0fFRd+5w+UAknQowzvzoXU
	YvXslx7jCdzI5Z8eqm0KhiiMXdE06sJE=
X-Gm-Gg: ATEYQzx7oPdIVv/PvmhdJrn6kHh0SlXFXMniyuFnLV8DnaxmIDjpvFt8a55rYTXuMKn
	nioITY+bXQOgJsng71nsKH3F2EfnZVocZ7YT8Ji0X/jfjTfdG/iGKbiJTjSMEYb5Xu4Yw+haVSd
	o0CnVOjbtgS8w9CyubQe3JeurP7q1mXTJfkfffHSLfUzRHpo0ZGOMUJ4oVAsnDHGtIMXhhH92XY
	MmxRl9QrnzuYAqNpvbVJ+eWoetJeJstWwT4FUgECGVeVWxamFkfMIv02vi5f7HZNXzB1SjP1fcw
	vqg5scc+l/4ucoITNdQXB0UncLvkqyaQ5OEMH/p2XbAtVrE4B977NyU9lJfWt0NMTfGnI8S/JQ=
	=
X-Received: by 2002:a05:6871:7383:b0:3e8:9e7b:4ea4 with SMTP id
 586e51a60fabf-41626e21440mr7566575fac.6.1772543019367; Tue, 03 Mar 2026
 05:03:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303115720.48783-1-dakr@kernel.org>
In-Reply-To: <20260303115720.48783-1-dakr@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Tue, 3 Mar 2026 21:03:28 +0800
X-Gm-Features: AaiRm51hHETXLy5xgoyPjMD6CQcJQj3Ex8YjBm7PX7a5CmSkvNYD_5jZKUYKtjs
Message-ID: <CALbr=LaQoV0L2dxiHKvoP2weZNWEXXG434ir8k-Ej=ouBiEWHg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] driver core: generalize driver_override infrastructure
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, abelvesa@kernel.org, 
	srini@kernel.org, s.nawrocki@samsung.com, nuno.sa@analog.com, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-hwmon@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-sh@vger.kernel.org, Wang Jiayue <akaieurus@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 3, 2026 at 7:57=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Currently, there are 12 busses (including platform and PCI) that duplicat=
e the
> driver_override logic for their individual devices.
>
> All of them seem to be prone to the bug described in [1].
>
> While this could be solved for every bus individually using a separate lo=
ck,
> solving this in the driver-core generically results in less (and cleaner)
> changes overall.
>
> Thus, move driver_override to struct device, provide corresponding access=
ors for
> busses and handle locking with a separate lock internally.
>
> In particular, add device_set_driver_override(), device_has_driver_overri=
de(),
> device_match_driver_override() and a helper, DEVICE_ATTR_DRIVER_OVERRIDE(=
), to
> declare the corresponding sysfs store() and show() callbacks.

Hi Danilo,

Thanks for the v2. The code looks good and the bus_type approach is
much cleaner.

Just a minor note on the commit messages for the cover letter and
patch 1: they still mention adding the DEVICE_ATTR_DRIVER_OVERRIDE()
helper, even though it was correctly dropped in this version.

Thanks.

>
> Until all busses have migrated, keep driver_set_override() in place.
>
> Note that we can't use the device lock for the reasons described in [2].
>
> This patch series includes the migration of the platform bus; patches for=
 all
> other affected busses still need to be extracted as a follow-up of the WI=
P
> treewide patch in [3].
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220789
> [2] https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel=
.org/
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=
=3Ddriver_override
>
> Changes in v2:
>   - Drop DEVICE_ATTR_DRIVER_OVERRIDE() and make driver_override a
>     struct bus_type feature instead.
>   - Add driver_override documentation in .../driver-model/binding.rst.
>   - Move kfree(dev->driver_override.name) before release().
>   - hwmon: axi-fan: Use NULL instead of dev_name() in
>     devm_request_threaded_irq().
>
> Danilo Krummrich (4):
>   driver core: generalize driver_override in struct device
>   docs: driver-model: document driver_override
>   hwmon: axi-fan: don't use driver_override as IRQ name
>   driver core: platform: use generic driver_override infrastructure
>
>  .../driver-api/driver-model/binding.rst       | 48 +++++++++++++++
>  arch/sh/drivers/platform_early.c              |  6 +-
>  drivers/base/bus.c                            | 43 ++++++++++++-
>  drivers/base/core.c                           |  2 +
>  drivers/base/dd.c                             | 60 +++++++++++++++++++
>  drivers/base/platform.c                       | 37 ++----------
>  drivers/bus/simple-pm-bus.c                   |  4 +-
>  drivers/clk/imx/clk-scu.c                     |  3 +-
>  drivers/hwmon/axi-fan-control.c               |  2 +-
>  drivers/slimbus/qcom-ngd-ctrl.c               |  6 +-
>  include/linux/device.h                        | 54 +++++++++++++++++
>  include/linux/device/bus.h                    |  4 ++
>  include/linux/platform_device.h               |  5 --
>  sound/soc/samsung/i2s.c                       |  6 +-
>  14 files changed, 228 insertions(+), 52 deletions(-)
>
>
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> --
> 2.53.0
>

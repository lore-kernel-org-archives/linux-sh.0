Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AEB28000B
	for <linux-sh@vger.kernel.org>; Mon,  2 Mar 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772444475; cv=pass; b=Ug/vV12UadpiOcJ10uvIxjfVFsnYlH39k1FA4V8y1XRdIRiaiyOaSnRkxCjSejNxwGKO8Ah6PPvfuY2fSZlL/qhS8vx6qrQgnLCWOw8BzBsVOFO2DNNWntvMpVheHSlKd0+E6uJuyHiJIg2tJiOAC57CBPX0eR/v2uTctWlqtcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772444475; c=relaxed/simple;
	bh=TBJ1yrzYQ1NnCqjl7xWYSvAiw/tj2uso2ls5/23iYEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkZGw/B0IGH50EWIdljTNUCW4wStUabTl6NnzYcxxw1tlBYEpJdvHqBw7jNL+sRTnQ1HxQDCdH1lS2EBHAXJTmKm0RuvZ6DbXfiP8yO5zkPkr1rs1UMA722lFobXIRKqPQzJx4FVJnlKrBqA94MuWrnDBsxFvUc5OauEtJMBJ50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTw8UYEC; arc=pass smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTw8UYEC"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d4d8712b40so1952259a34.2
        for <linux-sh@vger.kernel.org>; Mon, 02 Mar 2026 01:41:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772444473; cv=none;
        d=google.com; s=arc-20240605;
        b=N+iumEtq8yL92SEI5VxO9AZ9lDdbi4Vx6c0aBZMke/ShNj2wXwT6RaacYKPtrBz90g
         p7Vmrewos/NVNQY9docFH8fCer4FF90buiEgvnjI3v2gpeiiJgks3hFrBwEns+HrdLuH
         Eh5q1yufWMj1FtNQWjfG8659APP16dfvFcgc1VZYJ8LXXo31RD4/LhYVDvdZdAynH1xl
         9KJsYutxMcVtqezviNwbfhrSFAwPKk3WxzAeJIoNCA9mGlWHqaMaru2l8r6QHGdUz5yU
         I4boGkOCQqLutiNXZhUF+0JhP8vTqdaL9cPqxk48OabcPaJoNoKqfBCakMzN4GBnqWLO
         fHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WMS7e/VtXgxxHiT5+aAGAuDmBujfavKZuiOoKfzvjp4=;
        fh=xotW10P0utepKXfRSVlAkGbjReJb0As2SdYbCQ5LZfg=;
        b=BWErjTiuR8QwYpqOcJapKEDOcgnZ3kRO24BvAMnk2xuF2Js+hFwoApLjJ+TJ2SXKGp
         4FWP3ujzLV6a4qvGGLeXh4wNFGaMbZ5CdPzs+jpodEYElPbLXLgtBKwUccOFzyNKJho6
         Xq23AMDcin7iI61tXUH+30j1drn/PqvwrKsfXOMVaH9ElSaOdmAkapt5CLX8hWX8KpMe
         7lI0O3ZGS35S0ZONJdgRSZMGvBm7i4CSjmmsP+aM+Lax2j0Dgz1udaDgIKYpuLR0f09L
         +pRqDpMunhN7BNG9Od8zd8fsmi7RMWNgRNWgaVDy5ZopRua/ODUKeQgM47amSNEwaMjN
         ps0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772444473; x=1773049273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMS7e/VtXgxxHiT5+aAGAuDmBujfavKZuiOoKfzvjp4=;
        b=KTw8UYECl8rTlbQ/egk9PMarg7ENZ5K7KbRpMAy3WgiMlkYYc9nAU4b6k+ireh7Mue
         SxU6TJaYsZcbzBdG1QayZIGULW5fcX2IA5N7OJ6vhgkC+BAQtULkuKh7w9Svy8sKv6Nz
         HHD1f9oNAj2HkdYFiUrrfdQFIQt3dGvvcBloBUuzEKQfmKj+s0W7SH/JmbhPTc1aK9rP
         OLOK961XHVbPj6kfBMHI45XN4fCdJOAxBZb3/yhzjd9h0miRaiXIl9wRUUHTSS/91SXC
         deO0ClCYeVWWMT8/8BgBENdGPmD1nhtrktVrGql6RItE9Bqj3qURXyV0VVKRM8Ft2XOI
         qffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772444473; x=1773049273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMS7e/VtXgxxHiT5+aAGAuDmBujfavKZuiOoKfzvjp4=;
        b=ra505dBLNuSi7rNCjCVSe9ewBOIcdKnQahaZ0cbnDLMteWF2/nReIhL2OzuUm48FW3
         bJ1S2exx+IIn/dUJp3Y78o+qf/YBdEL0f9U9/4mJq5J9rB9yDCHBJn8kru1RHMm7953w
         YfHiHb2s/wSNOrZYUKTBMUThhjVIddN+7+n0eAHXA8qIL8lZOC7j451pLVlUMCBEPQoh
         G96KQuonprMx8E0PxlR8GNpLK+DTMRxq5OtDsq9EX86sO1RmB+dIvNUUvATQzKZ9Xw96
         vzUWOmOj/8D/fTPhTslvoUCyoYNIkgRkqWOaP0GSvQTxD+BiKmbi+VYXRDBicTcedgHh
         tJJA==
X-Forwarded-Encrypted: i=1; AJvYcCWWbvUe+f9m764M7Vpq/yYxBgZuFVxOTdfB0TQNqIXjjGrzMjS/zjMk/gGFeCC3HvcUMmjqzc0fLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWOADmfa/9pYM0TvNNcbUQxB0N7oCSeEn+kO81tfNYHMbCse/
	3JZKJc6n9aMhlKlWmYhYIoy3odcROucCfF2ucBSW3UXuYfejxel+HiWugnYXrMvuMIIuzhBuluE
	UaGWy1Yc7ltOT3goFDrjF7tRdUUS5W5c=
X-Gm-Gg: ATEYQzwY1VAZu6uS0uthQwN9QrwyDerIUMQ2xFe8pdXBff7PXrJzy27XiisPEbu5ZDY
	OcSz/VbL+46BM327scTbFgg7jg0CUE4BueHo5+K7QpSmxKZuWGfWifZSVpyh98t0eIhsHnp2ejV
	P1SnxsIzh6QdHHWvqqq8DlTogTx9A48ZKWpJUzyeckOhBwJnW1zHwg6zLa9+fs2XtDgre9VxmRT
	Ecg6RJxbQEGn789gR0ozHuZw91Zk4guSdi4BUvP75EzrAaMuaLVPqJKJm0Go6i1e8DPMpR1JAs+
	p0RaNx4TEjQhjaMlQaRPp8XEFhKfUl2CvI/FLAd3Hv8roFeLbBTDK/beSyqeFXP27nYtFn1weOM
	=
X-Received: by 2002:a05:6870:5ba3:b0:40e:e5c4:a4b2 with SMTP id
 586e51a60fabf-41626e7efd7mr6527665fac.14.1772444473484; Mon, 02 Mar 2026
 01:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302002729.19438-1-dakr@kernel.org>
In-Reply-To: <20260302002729.19438-1-dakr@kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Mon, 2 Mar 2026 17:41:03 +0800
X-Gm-Features: AaiRm52ksdTFNUhtDCiLRoaU2IvMaCTzMMj20OxNJCH2RxR4-dFP_MGc6WdRh8I
Message-ID: <CALbr=LYYUH_yQL1PO7mXzK6Oubt0LvKb0714iZCx_eEXScVdyQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] driver core: generalize driver_override infrastructure
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

On Mon, Mar 2, 2026 at 8:27=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
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
> Danilo Krummrich (3):
>   driver core: generalize driver_override in struct device
>   hwmon: axi-fan: don't use driver_override as IRQ name
>   driver core: platform: use generic driver_override infrastructure

Hi Danilo,

It looks like some usages of platform_device->driver_override were
missed. I found them here:
- drivers/bus/simple-pm-bus.c
- drivers/clk/imx/clk-scu.c
- drivers/slimbus/qcom-ngd-ctrl.c
- sound/soc/samsung/i2s.c

The good news is these can be easily updated to use the new APIs. This
is required to avoid breaking the build, since the field is removed
from struct platform_device. The previous build likely passed because
these weren't enabled. I will use allyesconfig for testing going
forward.

I scanned for similar cases and most fit the new APIs perfectly. One
exception is drivers/xen/xen-pciback/pci_stub.c. It does
strcmp(dev->driver_override, PCISTUB_DRIVER_NAME) instead of using
drv->name. We might want to change device_match_driver_override() to
take a const char * instead to handle this.

Besides axi-fan, I didn't find any other drivers that need to read
driver_override. This is great, as it means we hopefully won't need to
expose a read API at all.

Thanks.

>
>  arch/sh/drivers/platform_early.c |  6 ++-
>  drivers/base/core.c              |  2 +
>  drivers/base/dd.c                | 60 +++++++++++++++++++++++
>  drivers/base/platform.c          | 35 ++------------
>  drivers/bus/simple-pm-bus.c      |  4 +-
>  drivers/clk/imx/clk-scu.c        |  3 +-
>  drivers/hwmon/axi-fan-control.c  |  2 +-
>  drivers/slimbus/qcom-ngd-ctrl.c  |  6 +--
>  include/linux/device.h           | 81 ++++++++++++++++++++++++++++++++
>  include/linux/platform_device.h  |  5 --
>  sound/soc/samsung/i2s.c          |  6 +--
>  11 files changed, 161 insertions(+), 49 deletions(-)
>
>
> base-commit: 78437ab3b769f80526416570f60173c89858dd84
> --
> 2.53.0
>

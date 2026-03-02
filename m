Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956F038F22B;
	Mon,  2 Mar 2026 10:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772445944; cv=none; b=sqmNPW4/OUSyynI8NA0VNnFlRb/4BcuRb6CIOwjSCcAsimTCeTbQEUsq4toxYwVNGgXW3irIST7Rzo679irLC1fAM0gC0zzKoEQ/PWsILd+IMo2hVquHOFdAqhVgh2ucWO8ML7G0Q+DgR5i426glp4BjcxmcmKKIeDQTfx800Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772445944; c=relaxed/simple;
	bh=AExjFJB+beaJdH5ifnqVz1hAtu3ohEGrYIxKmLjlols=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=e0g8c0Lp1YtnWnut3BtW4J8UaBby2N9F1wnFBXnx0lNZO44pldYVhZkTDKDdIr6ybAAzJxJv9swrePhraWt/vsImUBpU73Jfzy2cyV8KNQ8KhkT+8fkCZt6m0jwPOy9MblGaVTlsRM/SyiYok8KQqTiDmAIUpRtJBroHeRTo/9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ipLqMS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ipLqMS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA70AC19423;
	Mon,  2 Mar 2026 10:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772445944;
	bh=AExjFJB+beaJdH5ifnqVz1hAtu3ohEGrYIxKmLjlols=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=N/ipLqMSUK+TNM3M79c2Bu/mT10HYrcuIH6HHVm9TmCLBzTOanVy4iqKH9qBsvS0v
	 M+4XUy76NBCuucr+sjuFay/CEJizKz0jNGqJOJ17GN57L7Jc1kkiCR99SO183rcBLz
	 kY9/3m+KEZjm7xhjbtzrwvDhng5/b+qOV3Cp7wPAXPzEHIwswUroySG3G/10sooyH/
	 1M7/2jlCF1+MhIeED4VyB7v4+fH6rhB9pkZTRvwSxB2LSPSJmKbRyDnrGtL5rv0RxI
	 GECIyFgbmQfqxcwqQH1bupgZZiZqjYXcy6cLtg4osRotpAM6X4xUsRjv5JEu2hXqH4
	 xDe6Tt+wPr+qw==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 11:05:39 +0100
Message-Id: <DGS7NBNUSBI6.16D6UP28IAXYS@kernel.org>
Subject: Re: [PATCH 1/3] driver core: generalize driver_override in struct
 device
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <ysato@users.sourceforge.jp>, <dalias@libc.org>,
 <glaubitz@physik.fu-berlin.de>, <abelvesa@kernel.org>, <srini@kernel.org>,
 <s.nawrocki@samsung.com>, <nuno.sa@analog.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-hwmon@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, "Wang Jiayue" <akaieurus@gmail.com>
To: "Gui-Dong Han" <hanguidong02@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260302002729.19438-1-dakr@kernel.org>
 <20260302002729.19438-2-dakr@kernel.org>
 <CALbr=LYqfhMi4eGp18r20XFzOWqRYCB8tO0mc_TAydb5cgbX-A@mail.gmail.com>
In-Reply-To: <CALbr=LYqfhMi4eGp18r20XFzOWqRYCB8tO0mc_TAydb5cgbX-A@mail.gmail.com>

On Mon Mar 2, 2026 at 9:36 AM CET, Gui-Dong Han wrote:
> Applying the following diff fixes the KASAN issue. It was just a minor bu=
g.
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index a8cb90577d10..09b98f02f559 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2556,6 +2556,7 @@ static void device_release(struct kobject *kobj)
>         devres_release_all(dev);
>
>         kfree(dev->dma_range_map);
> +       kfree(dev->driver_override.name);
>
>         if (dev->release)
>                 dev->release(dev);
> @@ -2566,7 +2567,6 @@ static void device_release(struct kobject *kobj)
>         else
>                 WARN(1, KERN_ERR "Device '%s' does not have a
> release() function, it is broken and must be fixed. See
> Documentation/core-api/kobject.rst.\n",
>                         dev_name(dev));
> -       kfree(dev->driver_override.name);
>         kfree(p);
>  }

Yes, we must not access dev after the release callbacks has been called; no=
 idea
how this kfree() ended up below. Thanks for catching!

> With this applied, along with the PCI driver diff from the WIP patch,
> the issue is resolved. I tested this on PCI and both PoCs no longer
> trigger KASAN. I also ran with other debug options enabled (lockdep,
> sleep inside atomic, etc.) and hit no warnings.
>
> I was working on a similar patch recently, but your version is better.
> Not returning the string directly provides better encapsulation and
> makes the API much harder to misuse.

Ah, right, I remember you mentioned that! If you want I can add your
Co-developed-by: to this patch to account for your work.

> Tested-by: Gui-Dong Han <hanguidong02@gmail.com>
> Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>

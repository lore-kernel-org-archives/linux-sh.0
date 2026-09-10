Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD53CEB9D
	for <linux-sh@vger.kernel.org>; Thu, 10 Sep 2026 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025069; cv=none; b=DXZVLu2CzR1eTTxLXmJVzQULHaRN7oVZAZjx+5aKafrQfDBI5bnWFIH31k7SZ5K55Zsc1vJZBzZqxWaeZUO3jrkBtkGfnhPCjhVA9iviI/rUWYtmcNZGyYgLuOiF3ESxo915iJlwn7JiB72ibawi7XzjgGyNYDPxCptWdMHTZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025069; c=relaxed/simple;
	bh=+U3CsgVsX98Bv1eArnHlNvqaVE6TND6nINIu7hrzK+U=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BScvfCcBVwPEu+OMyvAONV/+60B2ENRta6WWnQ+R5pAYsDWF/+cH0Vo01QzaD+OKKnTYfg6wasLKwwfPTCP4sPJymgZCoPbO+Ltv1kFXAekEMztemrfx5l2o+KnNHDV+FFJPydckPefqlGzSq4yg6MF+MaQna1tYRyBpJkLQqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lx475Gaz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lx475Gaz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5BA1F0089C
	for <linux-sh@vger.kernel.org>; Thu, 10 Sep 2026 07:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025060;
	bh=+U3CsgVsX98Bv1eArnHlNvqaVE6TND6nINIu7hrzK+U=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Lx475Gazuys68iHJTZl+TWFJfxPzg25YPfTf/ER633EImwQXGSeBqjSlTGiplBfsV
	 OJadQw319gQC2RFH7nBUXLQnsKnBifshyHeUzK/Mec8oz7mBNM9BcIcSyyF+qO7Qso
	 pyHiBL3AZ6cOzmXZwKUo+7e6gXlyOF7EM+HWPaAzc7gPD0Fm3FA8zH7jyoSfOTthEG
	 FOeYF14nMn9Be7eRZjJn1CgKolofuy0WEEKelLDnqe8OUHVHPtSBvcpDWFHec06yHQ
	 7huu/H2ys0ZwN0woMeHAAkW1XcuV6LeQcJXopl+6TE9YY2TVzuZi5108bcGIIRFNfQ
	 Kew04k0H75ewQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a33307ecd9so72708501fa.2
        for <linux-sh@vger.kernel.org>; Thu, 10 Sep 2026 00:24:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByhDSy5LeY3wRQZFqQFH5IUMuXPj+dfRxPvJzNEzB0aD+MFRKZYm/dVDrACaxFD+vTp9G/jDv2/Dg==@vger.kernel.org
X-Gm-Message-State: AFuF++nRqY/mA08cXXREHde3lOD7QyoiNiCc3x6CJMRZucdNjK7k+HE5
	rkBRD8wPHrLxNzJvGIW1rMvnWr68oSsOLJ0jzmf6TzCBzjs/ety+9GGRcD7iCvKN0U2FWBcGJxl
	reXZkjzyv8lFnSd2jLjH4QfMWf+abaG2rcfBRZfc0Tg==
X-Received: by 2002:a05:651c:19a9:b0:3a3:462f:329a with SMTP id
 38308e7fff4ca-3a371be7d52mr49246631fa.13.1789025059432; Thu, 10 Sep 2026
 00:24:19 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 00:24:18 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 00:24:18 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <alUyZ2zVWCPhyHHX@google.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alUyZ2zVWCPhyHHX@google.com>
Date: Thu, 10 Sep 2026 00:24:18 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me5FPXqLzpMvr6MMGJcSqfah4yaRU0EDrV+jOn=X7iTbg@mail.gmail.com>
X-Gm-Features: AcwNN1VcRf3mEWCD3x1wh-CxVmrq8hB-EFgGIfSDmr_ZS3mGsHSgozFtnP9n4xk
Message-ID: <CAMRc=Me5FPXqLzpMvr6MMGJcSqfah4yaRU0EDrV+jOn=X7iTbg@mail.gmail.com>
Subject: Re: [RESEND PATCH] sh: ecovec24: use static device properties to
 describe the touchscreen
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, 
	jacopo mondi <jacopo@jmondi.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jul 2026 23:41:31 +0200, Dmitry Torokhov
<dmitry.torokhov@gmail.com> said:
> Convert the board to use static device properties instead of platform
> data to describe the touchscreen, so that support for platform data can
> be removed from tsc2007 driver (ecovec24 is the last board using this
> mechanism of describing tsc2007).
>
> Device properties do not allow custom board methods, so the method for
> getting "pen down" state was removed (the driver is capable of working
> without it). If this functionality is needed proper pin control/gpio
> support needs to be implemented so that the same pin can serve as an
> input GPIO and an interrupt.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

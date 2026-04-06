Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89C4313E01
	for <linux-sh@vger.kernel.org>; Mon,  6 Apr 2026 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775470902; cv=pass; b=Z14vj36uQ3cyWPDqICTrQmE2fJN3jgDseabmQCggDY7esghJRdsPXtU0fVhshc3IDAZ6sK5tCtQlOXQtL34zNro39FVfSOzv4IyseJLa4ssOJPWd3xIfixqahDXP2dcenu3HE17syPMGJlbg1Cr1BzGidsKtXd+8i6jLebTiyrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775470902; c=relaxed/simple;
	bh=k5IEUChKX5+PLhQ7Vd8PqYTQTG6rj8yOG0TgYzdDPQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ojp7gWcI2+iU+HCyj8evxSMGP9vKqe7oGOOAQ0oRzsgZNOTp2NTmFt1WXoHjesQ4Cu2B+P2c5yU1Rm5C7z20h+09eu+cVf/4Ynpd3O3D+IGjpBNbEdTUKUVRjiGkht4OnSJ/KQ3cn+T8JlvsYEvdrsuxufkvyscWyzj05sv1ryk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA3nktxK; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA3nktxK"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso5465732a12.2
        for <linux-sh@vger.kernel.org>; Mon, 06 Apr 2026 03:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775470899; cv=none;
        d=google.com; s=arc-20240605;
        b=LfaouDqdgh548XoHTFxJDQrWzbae5RIsgwvAgFEzj6N2i2mWpKmb3s7KB7lKVOdFTZ
         8A6f+OOFKPnbN7SXMDlBUlGZ67HpiLhdCI0phl470VQ/XIpvO/NjSFT/hgYcQJdbe8H3
         zzaGwM6JdHYdCu/J8cW643ci3owfgtNs95gNcBgNki5oaiKvLFP1dPlRuaHq0/AVltXh
         41vG2sv7xEwTdKJgcDQbQZiq8fc/1PyQhSsE6MXdFj5L37xSE1yfWGc7lGeA/4dwaep1
         O7tlnQ4SH0bDh2sHv4Ks6vRWmhLIE0ErY4pgnHQi5ZV6zzZ/tZdIrKJI1698zvyHv3zo
         jqhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=k5IEUChKX5+PLhQ7Vd8PqYTQTG6rj8yOG0TgYzdDPQw=;
        fh=T7yRQISD0yERY0gXvmjYvSbtZGnWtgsippBK2HCeEXc=;
        b=CNS9PcX2S2IQupogVkDk7oyAQgCY6TQ0KkrAgMWgSm0/R+eIDv83S9ulEZvGnYSBNf
         lGHd9aBG0u8p1XWgOwPTgKPeRmnkiL1vF3xU6+JARCvEXEhuHrQCzNvNvYCu5ph2KdDo
         QG5yVQ63FIjUEAMw3EhQJRC8Atzl/YPGW1l+xUOQ1jAtHTVvC6oJYbz9CLT/fLjs7w5M
         8OlTfGdfjrehgLujdJh1wcdXfWOEDXw+6LYv8QgB9HEnee1jc4bm1xXXYGZtk/k4lDIJ
         h/BWVeGIH/iP55p58xmSaBxL+kErl/2iNzjlBmsTuoqT8M2Z3eZFE71Hya8A/0Q6jVOB
         c6sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775470899; x=1776075699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k5IEUChKX5+PLhQ7Vd8PqYTQTG6rj8yOG0TgYzdDPQw=;
        b=LA3nktxK0VEA+6S/yaU5UeNhkoguB56mkjqtCN/rp5NY9PvOKwkl2FlL6DiG7JI3ZX
         hrWAEp0sWjIh3SWLtQt/RfxEV03zUQ1jF8nsntwOk0HltAvBLlQiE48kUK6LWo6Yd94F
         F6sOX8bR9bMuh3IBd83g3kXeGKKKKIf/WfFgnAq6P/eHDzL+0k6PF0noQyKvLXMWTdsn
         XlQyGt04wZsaaAIN1txfnFX8KG7mVmPD7dZbd3H/QFWkDnNIJMFwC3A4vovK4G45TSyK
         DwRm9RWX8oTcl7mMARak6XWcxDDrH0AgfMvhi3CcjJpIIAWzUpr63WDBo4ncFoBCMddn
         soRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775470899; x=1776075699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5IEUChKX5+PLhQ7Vd8PqYTQTG6rj8yOG0TgYzdDPQw=;
        b=oHUcW+FPmVkiaraUGN6wCQ3zcSiZMgXMIjjNRnVs+ZF3uL4pGK5Pma0a0cW+eNjVsd
         YlAoWRrRqVZBRALWjTxSjMfgVeiitvirPp4LiigAem/aO8mLnciSrzZuKCcEiNKs8AGR
         cQXts6Y96d8kMvi9QH+O3rvgf9QpOuqNbX8cXdB7jjTys8toiT2f/MWWPdYs35ISoRq/
         kf+rKHKF3y6JyI9hjP57CpQxkBO+M0s+T3xOQnOgfBhpUxWKYP23WRVcKP9vDRb/IHRr
         fOVISSzN8BDuZDM8Mw77No1+IkiGDHpvAP2vAcg/QywiC+T6dsasruVJEKqE/Vv/VVf6
         EjXA==
X-Gm-Message-State: AOJu0YwcJ50cR1DUCeLjT2k4hUjf5fmKo3gPgapegbSiaNNhESuFTodo
	YOZLjDlGEdSRT8oysrhkfg5YSllgRwZRqGVFlft0eW/uMNFVlQyPkGfv6K8k66u5Kq2nRx4DNZN
	6BseLelpvI8+CAZbMCZIhC1+Qfro93LM=
X-Gm-Gg: AeBDiesacMO4zFuobqwQBcqA+wibsrfYFd5NeCpC9qC5yA748V8LHXQZD8KcbBfmRdF
	XKRp9SkPw3l8YO+WxoQzvlF5zEEpW3aoXD0DKsqovwYkKIWLBt7pDmUJhNY/sxPRtblRciS82Hn
	VumcuXusr37Hse5SEU99MM+BG6aBm6oaxrw4w+7ccLWFztI5d2i5GVNUnb2R1YxM6HsY+oEpn53
	8ps3jX3LbnAhZYkPsavrQZ9CQolVbXRv6E3f1gDOT2wLpUO5A6Krso/OAiFlzdzN80TgiD030Hw
	mZjDVlpoco5D0vN+3HO7BSiaumDtB9pSXo+/ootFQSHdAP7mTPz+QVzNcqG/hI//GiF4lhJSDIx
	egDBFhezFf8E=
X-Received: by 2002:a05:6402:280d:b0:66e:bad4:3f52 with SMTP id
 4fb4d7f45d1cf-66ebad4406bmr2178219a12.2.1775470898838; Mon, 06 Apr 2026
 03:21:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405082330.4104672-1-fuchsfl@gmail.com> <20260405082330.4104672-3-fuchsfl@gmail.com>
 <CACwZE5Rmy3A0k3tvc32gv0V3T1LL2PaP_+S7N87mwNppLTh=PA@mail.gmail.com>
 <adN68wCJd6QEZyNW@lithos> <CACwZE5RfGW24wnWnwmSR0xUm1EZCCAzuaqug1FbhqeXXqEDTQw@mail.gmail.com>
In-Reply-To: <CACwZE5RfGW24wnWnwmSR0xUm1EZCCAzuaqug1FbhqeXXqEDTQw@mail.gmail.com>
From: Adrian McMenamin <adrianmcmenamin@gmail.com>
Date: Mon, 6 Apr 2026 11:21:27 +0100
X-Gm-Features: AQROBzALwbvnLpk_Z0GmzkwLFdYaj3STnHqAY12_dNQdO81GLLzC66M1PLCHdwU
Message-ID: <CACwZE5TPt2Y2Xn+YSVv+BY=PkGeAVAYgsfeLPtCLYKKqYbrPOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cdrom: gdrom: update gendisk capacity on open
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Artur Rojek <contact@artur-rojek.eu>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Apr 2026 at 11:00, Adrian McMenamin <adrianmcmenamin@gmail.com> wrote:
>
> Florian,
>
> On Mon, 6 Apr 2026 at 10:20, Florian Fuchs <fuchsfl@gmail.com> wrote:
>
>
> >
> > You mean, because one of the functions in the call tree of
> > gdrom_update_capacity() wants to get the mutex gdrom_mutex or s_umount?
> > I checked the locally called functions, but don't see that one tries to
> > aquire a lock.
> >
> > I don't understand the exact potential of the race condition, maybe you
> > can elaborate, where I should look.
> >
>
>
> Actually, having looked at the code path in detail too I agree that
> this won't recreate the problem the earlier patch addressed, so this
> looks good to me.


Sorry - a further thought. This rechecking for capacity is only truly
necessary if there has been a change of medium - is that right? So we
can take the result of the earlier disk_check_media_change and if that
returns true update the capacity? Is that not correct?

Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7104338597
	for <linux-sh@vger.kernel.org>; Wed,  5 Nov 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361527; cv=none; b=YybBQ4tTVK/hZ58zmjW4PfX8ptBNPD2AaibBYSMoUMdFL9aVXgyYnjqN0SyVoEKaKuUz9QRbfI4peL4xk+in0jzDnKiGm6LQjhfh2pMftR/jpH9ABfE4Dp4zS3T7Q9DclKQQgV0GD0S4wHhxOc5Y970k8EhwmiyM9eBjKaMeURI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361527; c=relaxed/simple;
	bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxgf9f0zPxVxTOXWrNdexrOasw5SrknBSBxc+49hp8tIGcEj1tZH34K2Fq4QaEugsqosda02aJMsB1WMMfzMheb/l+thJonIBjKUpd9PunMs+2DVkwDHkud3EqgEu0RImf4fV8tICOVANUU2zRW3XkMEM9+jc4VEn1oNJmEPosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVpbhQKs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVpbhQKs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477563bcaacso75245e9.1
        for <linux-sh@vger.kernel.org>; Wed, 05 Nov 2025 08:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762361524; x=1762966324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=AVpbhQKsWHsJPurkBtpFjS569EuYKUxy0Ewl5KvxLz11TynIudTMz6x27b6A6doKWz
         ip2xD5KKY1oMJCK0Dweum3CzpsfSfe5Azmrly9qy+6lx5DTGxHpK2A+42y5Z3pqNqWXK
         5oMVmrIxCr+TXfau1fOpH55Ds8Gfkw+SKMup3+25IM0tOOtYD8mCPcmX3YHevXG3I9fS
         voKjd3O+6JkWCl7xwg0Uy4qskOwo95lmPAQUzNV1zgopuIouOGjmjNsUQ0iiplG4NNw3
         pJwe6bLtD5Fb+hz4cFTbQ+dE2Dx8twHim57o5xVAlYBYEkIZ+8VVi9pnTa3HqwZj4o61
         JDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762361524; x=1762966324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esO8jRq9uTUw55PJsW3htw0zar+bIhexF73TArzHxxk=;
        b=uVMx/wHefNsmyZJnEMWvIAwQuxH/P2xgNapTt1853i0DLhACE6CAZf57/eGBHeRTlG
         IwBmLnD2QFFtUOBwVgOTP4b3qnlnRf3H4JoiCopKKB8KW8VKsIg1z4Fj/V/vKAOcB8qy
         U9xVrP4cC5UiS3QhZ8cSp2iOhENLbx46XCekQpZyIUAWS+CdXV9WSbTOqAhqp0hgPfTe
         x5AaKQEb1/e26qEylw1GCZJw/LXx8xvIDtdiT3bidgM/Vdy8wPyU84kCfpg9azaAKG32
         SrD8TLIHWn4WPeNMjnk0YkBPWe7cJU40WhBIbQt25FYmFDCoqSupeHwgdwK6O/FBXyED
         u5Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUsy7OI+o4MQfNQDxQb/tIiQX655MYrHClYesjCzkZfrANDFUd+LwAY+l4xIa9mvMxgVg4t5i+l1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YweTL5d/MnCeJrgZcouPBnli5u6+lkGmJ09LTQwY7UOjt/fP8R9
	6mzyaQxnvRBDPzjGdIYS7NeZpK6evoUl4YePS8RNcz1rkQS19+Su7vutnt1JQQ==
X-Gm-Gg: ASbGncupH7REQatcqyxx8BVJtUCO5zUexF4cbbLWau/yiaPffbE3I7Ir+w1steZjign
	rTcqqNL1gNj1RFoxcjndpGUE2XqSa6W0lwvLNrLGDL3oF7Hmu+uheIcwiz8cVfhMhUvyxFMAI5z
	hQ0Oci1l3yFQ6/Oa8kBTcVLn9HVSVzZmUVFROLIU7nvNb906J5/SFm+7cYqHWmZuwyX8hr1f8Rx
	9NOh3s6ExKnuaRt1VWnOYqXXGBYtvyYZj5xrdVQYc37csZ4RTYp9aWdG6Nj6Q7oPGjaa6MvAdUb
	MA24V9HqxJHVEK0m5mMyB01Pqs7PDqWUPZWFsj1Xh5svLg6B2bQi4qAHJy/1/vhPcOmNhSIkJUV
	hH0UMpI+Mw3nSn8W9viwsanmJytVo1KgDKwndvHwQt3w0zXMALKWO8HZLwNRkWBDpmIrNLww9t+
	yhBAtKopblJGqZlt9Wrp1AYYxGRdu1y73dEb5lonB8AqW2BdmspyhhgaM34lnl8gQ=
X-Google-Smtp-Source: AGHT+IF1eT04urNHEfsD9kdCj32CNL1YcHJ6oGuMVK3cU2BLT/aQRFRmm7ox5OYZe77ML31HK9v5ow==
X-Received: by 2002:a05:600c:1c94:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4775ce23efemr42468465e9.17.1762361524090;
        Wed, 05 Nov 2025 08:52:04 -0800 (PST)
Received: from orome (p200300e41f274600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f27:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce210a7sm59725725e9.12.2025.11.05.08.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:52:02 -0800 (PST)
Date: Wed, 5 Nov 2025 17:52:01 +0100
From: Thierry Reding <thierry.reding@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
Message-ID: <3dzha4qyqdrbutxby3n5nkvihnxrhniqr6w726eumhzgln2w5l@fbu72mzmjz4m>
References: <20251029163336.2785270-1-thierry.reding@gmail.com>
 <20251029163336.2785270-2-thierry.reding@gmail.com>
 <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ykyajizgfjgayrmb"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0igMJ12KoYCmrWauvOfdxaNP5-XVKoSxUroaKFN7S-rTQ@mail.gmail.com>


--ykyajizgfjgayrmb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/7] syscore: Pass context data to callbacks
MIME-Version: 1.0

On Mon, Nov 03, 2025 at 05:18:08PM +0100, Rafael J. Wysocki wrote:
> On Wed, Oct 29, 2025 at 5:33=E2=80=AFPM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > Several drivers can benefit from registering per-instance data along
> > with the syscore operations. To achieve this, move the modifiable fields
> > out of the syscore_ops structure and into a separate struct syscore that
> > can be registered with the framework. Add a void * driver data field for
> > drivers to store contextual data that will be passed to the syscore ops.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
>=20
> This change is fine with me, so I can apply it unless somebody has any
> specific heartburn related to it (Greg?), but in case you want to
> route it differently
>=20
> Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

I have a few follow-up patches for the Tegra PMC driver that depend on
this. 6.19 is what I was targetting, so if we could put this into a
stable branch that'd be the best solution. I can set that up via the
Tegra tree if you and Greg are okay with it.

If that's all too complicated, I can probably wait until the next cycle
to merge the PMC changes.

Thierry

--ykyajizgfjgayrmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmkLgLAACgkQ3SOs138+
s6F0Lg//dTn1/PUCYHRhF8cm1xB6JKggiLC40TRct49fcf9eF5gAdCqXm44qKoaF
67aqiXAiwzovTctJIu3rz8p71/FeXp/qGWDdPm/+wI7yD+BoCcVO0nmvXuPwCzhd
ZMwqeaRVm57JX4M9S5BdkOGtDLgAjyZ/6Qq/2isiQSPiWWl/IT3YiLyzw8vq8mcY
VoepQGK5hm7CHFf8FOBs+sMt6q5JJDm0VjNi+seVcCNg9U25GaXCRc2D9ztAqRib
3768/KMhlftnoJKsizCwWq2Gyw0Se7ifz66djjf51sHd064LLDv7OZpfeGyiFK01
MvVGXoPFuIJB0yqIoMRBbeRULm4kq+dkUkt1JWwYAMw9ZJnhXPJJI8bal2IASj8/
E6NADiYd9HS8kAXWYvLkm0xHv4FN5WXWG2a+Gf6K2vpBm07zG2xnI+eVjYQSnb9W
O9TcZf3jDWvgEQ31plH5JFY32sI4vjLAdcKS2oRfkbxFDJvTS+RRjj3EPqFshNXf
B5E6pXTCltOkUepuhbGDzIifVWzYgg/GyXNfwzdnJUXcAz7QPPJySfMraf/dn+8S
hggVgAivRFDEtaNEqKU6iqoePR3HIUJe/Ebjrb199RV9t4FcnVYOpviJRf5EWpsF
2YEUJPiA7neiac9fPLwCoRh33bJTIzanmWVxmFF1nQ2vozIt68U=
=3Mmd
-----END PGP SIGNATURE-----

--ykyajizgfjgayrmb--

Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB88018A94E
	for <linux-sh@vger.kernel.org>; Tue,  3 Sep 2024 16:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725381114; cv=none; b=au1nLAhKRTEIufvy/Lq1QTyi2LiPUdKP8HxOW8ocuUmM6dNpGjguWiP/BMv6trs17YYuDOR4XwTfPLigagxFAbmI7C9z181kCC1Kn19Vgz7+VopwGpEvPiLaB/3Yf3Vbx3ACTOiHub96csbLO39fc6II/rNr8FDAyYkYXev2pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725381114; c=relaxed/simple;
	bh=+tNNtHhNx6ArmzbBGY7E+qH27+MluekkW/2efa04Y1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DOzEk8yOjAQo13XZM9pqt5E1VPenkxdH0BxuFOlXjPuisndyruuNKLSf5O4WuIwo87qVLedPlUOytZnJVc9AWoaZ/O8u70gd1x66FGCbiWrAc8sWIrM8zN7xySxgm1dJZQDug+mvKIYP8gUHiAX80rlDbTN/cgFqzhMsYspMshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PaylS3z9; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PaylS3z9"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b747f2e2b7so49239537b3.3
        for <linux-sh@vger.kernel.org>; Tue, 03 Sep 2024 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725381112; x=1725985912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cA4f6/Q14LkYipHi4xW5E3QoTzXbTWUwWtLbC9c1AmY=;
        b=PaylS3z9BxeToyzg3LOdf1bKGdTfNepyKZS1f0kifDeBnHWWISTnn8s0NlbOxXIoib
         pQMSHxjV9CZOB97vROZQavyIBo/j0NaQ0Xu1sXV2/KuJwLB5zox9OyVGLDVZO3XKqFR5
         Ks6fuqZws2omNYw6fdIYRuU9LpF5/OWo9+KzxtdGnJr0+djv/yAbAjhEW5g8+DLXfwHL
         XaN2G5DueYEYsmz9CUqo6+pwqYeJieGE7f0xz+oCkeRCwjYWrcs2sAD1R0y9y7x0YO02
         fvgeiFoLKI3+8BluF3+7AO+YgHYtRsLuDpMG6Huw8IpAccyMUp/cp9xa/SftWFUbocfj
         mYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725381112; x=1725985912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cA4f6/Q14LkYipHi4xW5E3QoTzXbTWUwWtLbC9c1AmY=;
        b=NDY5GeTjCdHbEAdJlCzRaVzDlC8UZK8GX/6CqKrVn9zKbtgZhYPZnKmqA9chVdJpWS
         7E8cNDy+bb35KDQroqPQqPDYV0UUrp+aNFbkZg+tWv5qLAWNLQGGW+LoE85YCf4w9B1R
         dw7NuP9tUkUOK3HU8Xv6/M5+sqIkV4y2063d/rDbjkGuKW4xLhkNMwgYtg4MpAw3Qoou
         KmjIVkVN9tnsYJKELQskRhS3kA41O6JvgzkFcNZPq0iT2Mjq+t6WeyU/LMLQeGtdmSVO
         Su3SYnya8weDceon8vCElsK38tkR9VMgw7XcH4LBo0RHklUR4fifpw7yUSdb8hO4y7wc
         vNvA==
X-Forwarded-Encrypted: i=1; AJvYcCW77xxIP0lPqtp860KR/DYNYYzIBQ+4D8DtqGShR//PBBSE/8a4gYeq8LfSss/z8j6ZQj9O84GbTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtRigeJkD8opKjC5wf2BkgOgy9PT3lL8SkF2ZMpL9dQdzSCfal
	35S+JEOWcZW1a5dphyMw9sVjq/b/oUpP1vVoBEqttMaRGdOexWSFQ4YyyLBaezwhz/xzS6Xl4x+
	z1FM/f1RdvOfIaXX6KvGV2Lfhh6mHHd/5qOUU
X-Google-Smtp-Source: AGHT+IHa/01qoE/GHcK9QfmQSjlJsmOjJNv/+Qv5fA4SkJmS+bKSV6Q2r3LgScHAw7u0DobQXFY/bSjBLHtbXnRken8=
X-Received: by 2002:a05:690c:650f:b0:6c8:1e30:5136 with SMTP id
 00721157ae682-6d40f14e2a3mr154433887b3.16.1725381111978; Tue, 03 Sep 2024
 09:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903033011.2870608-1-yukaixiong@huawei.com> <20240903033011.2870608-8-yukaixiong@huawei.com>
In-Reply-To: <20240903033011.2870608-8-yukaixiong@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Sep 2024 12:31:41 -0400
Message-ID: <CAHC9VhTJXCSduz2R-LOxTQOb40BmE-=wR3HJafzstERX6MpNUg@mail.gmail.com>
Subject: Re: [PATCH v2 -next 07/15] security: min_addr: move sysctl into its
 own file
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, kees@kernel.org, 
	j.granados@samsung.com, willy@infradead.org, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jmorris@namei.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:31=E2=80=AFPM Kaixiong Yu <yukaixiong@huawei.com>=
 wrote:
>
> The dac_mmap_min_addr belongs to min_addr.c, move it into
> its own file from /kernel/sysctl.c. In the previous Linux kernel
> boot process, sysctl_init_bases needs to be executed before
> init_mmap_min_addr, So, register_sysctl_init should be executed
> before update_mmap_min_addr in init_mmap_min_addr. And according
> to the compilation condition in security/Makefile:
>
>       obj-$(CONFIG_MMU)            +=3D min_addr.o
>
> if CONFIG_MMU is not defined, min_addr.c would not be included in the
> compilation process. So, drop the CONFIG_MMU check.
>
> Signed-off-by: Kaixiong Yu <yukaixiong@huawei.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---
> v2:
>  - update the changelog to explain why drop CONFIG_MMU check.
> ---
>  kernel/sysctl.c     |  9 ---------
>  security/min_addr.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 9 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

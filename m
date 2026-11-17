Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794947299;
	b=N0hgghb0zEaUEWhtPhkVnVSdH4a3TEh2fQgguWMbiRhUQqLnLWdL8ooYvC8v720bSxMb
	 wXXOLFBfT7jcCwOS0lLyX7jdk4qqYxqrtFcLlHqpHw69sIKoUVQw50Rum3q2fMX6k3pxJ
	 lvWmqoQZiik1BC/Ei5BEqStwFmyhlw49+LAGD31qH+k2au+WNDMTxTgEs0xenpyldsZ7y
	 WVlE1X56icJebsONGYY8Eyl5PCrnvRW+SQDzQf9uueHOFRQ8FUFWPReMRpZ1pq++RAfFC
	 xVzJBP5dxNJcVw+ZVJxEtHavAZZwzrKkFy5dlQxUpv/sQ8SqoeTpt3ZVZ8V2H2rryZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794947299;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jVQoF4RBBvw/4PYTHk8rllYWT3NYnQtky5aIjcCOwqM=;
	b=sngsQ4wYBBfDD8rf1QgMWnTIMINJTVrFuETPtyU5Qhs7NQh+zSFS4YoxewREGjJDvw6E
	 qwJu0E9iUxcFZo3qo5BxqamZV5hiEym5459OjJX9wOTP/hNzEIHPMYwRXp9V8ylf1fgWp
	 rD+Ya3r+bYVbxGSgAPvdTcltrtzeEV/IqpppBcNJIoB/PXPR01iTLtv8mZm5ritfAhu/A
	 1l4D3yFQnPpf5dthwiQtywvqMNSzkUFgeojt226fj8atisZgxeLBoUuuuuJT248dyejJC
	 Cdf5ROk8N87ObSAYlz+xz7d3MnX/O70Zw9KRyotyS2RJsIbwH6XO42dMIzko3jROBBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LyBhKerR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91051606A31C
	for <linux-sh@vger.kernel.org>; Tue, 17 Nov 2026 20:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91051606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LyBhKerR
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-54492d8a988so52961cf.0
        for <linux-sh@vger.kernel.org>; Tue, 17 Nov 2026 12:28:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794947297; cv=none;
        d=google.com; s=arc-20260327;
        b=S/r9yODHtbbI8q3QbT2se1/MlhkwzIBOKCgqP6eIUQzZcoU8caQaafgxaxgSjNyncr
         Q2Nr4/AO9w/Ntk99vY5/jOgT2apM5omvwxF2WLDogkgZN8IM7fGPib/7wxRzujwN9IBh
         hHnBj5pdlKh6krsjz2IUILMUMPRyo/VTpgxxoFHsEaS7IvVOLaRXLZQ0zT1RoNzkSpRs
         gEon0PdG63UCMd75ix+SXjWkK+qxzuPLMkw5PLXCaCvtu5Mafun/A15Vk0DonPwk+Ag7
         bkQfI+1rHH6Oj71NKrHp8wEjuVvfCQh6AS2vyxCQYsTbXocVEzsHzGIl82gxy0hgXKjl
         d2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jVQoF4RBBvw/4PYTHk8rllYWT3NYnQtky5aIjcCOwqM=;
        fh=/LGekOrBZZSF5vilrZK1l/s+7Qfl2RoXk9Qi2OihchQ=;
        b=bFgxShvxnbRXFBROyepeI5QnWaLjdwR8QbAK6jv7uPYgtYdSS5JNHrWDO4PwjvnUFS
         EqQU1O7Jy211CpxJVUfir0PMFVbaxdwGAKOcCuqoFHGvtz4C9DtKyd3+/2WPCIUvXHyX
         0KXo7vwOzh+/Kz5iXZv69BfdazrH4c137cqYY5X3f94bO4cnl04Hmzks9iPTbg5ZSl+I
         tQ47B2PSfJKocLjaw2qA+Ufth5Rmj2YXMSGioNjNZTFD62ranaw+TAJxi6UsyjibWxVp
         yrqGc5TrSotqI3b9yi+oADig/tNPOqWaxCXAwEq4E0fCXiPzoyR9c+qjiqNSOgv+gE6w
         oouw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794947297; x=1795552097; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jVQoF4RBBvw/4PYTHk8rllYWT3NYnQtky5aIjcCOwqM=;
        b=LyBhKerRYtuPj3BcqDX6+hcymxHUISw6M9iRDIFKDhl0hzuI7VDwIoryzaWbVmStwk
         55VkApnp+qQsX4X0JKiLJzofoqFfE2OaBypLNlghoHCv9jyGHreheBvOCmCcLILqPhOE
         MLLw9ictrMiqFroCF3sqwCzV5X/IJFXCc48Dpkuu3nkRkPdHltOHWhfKpaE48loayk0w
         au46gMa60MncIuY09Ngnfuv5e6FASlWZmx39RFRO991zQXVnsGbckNz7P1iOTKxzhWQq
         tL+H5JUGu1suqwqhTnIcEeKq3noF3pi32PjdCwJIy9WoJ+D/6vggHiLhJYvZYCmSLEK7
         pn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794947297; x=1795552097;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jVQoF4RBBvw/4PYTHk8rllYWT3NYnQtky5aIjcCOwqM=;
        b=B+SUpMAISvX45k8oK7M4rXXuQGsEipJ4X7osdpUjxNJ4Wop96fx+7Y36l2OwSUXEX4
         Xkh2tgmbZ/yYanbTRYlW/7yEs/wVMl/YYXXmY9aVRDLoY2zVLoBos5XnQczFeS0g0dVd
         OBR5rGXB5fNkFk07bPlyfFqCIPjdNPOY8pdSQv2KuapePAF/yXsjJgAiku6gHKQi7c6E
         rnRmh6ziUCLCP9eLmHIZzFtqS6cNyI/srApQzLQ+caaiK7BIGyNqulCE8nvVXGNP/Pud
         s2zU+Hc8ef2mOLrI2aDP0cueqi/xa8uRBb+rZVuyVz0vZ9M2e4ETGLwGEYpjJACQucQG
         uVVg==
X-Forwarded-Encrypted: i=1; AL+hErHEZ1PvBHhcdu/eiKaKXgFLC9J3prHeQZrP6w9QW4MF+KbsHDppegKmJ4DAKxFYjzHeoTh3rBi+KQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HlSwqQuoEUtqYYiTeHyW9Xm6Hmzns9aHXydVTDnOc+gJX99v2
	pr/F7bQ3EpROWrSFJ7WJjaLDyrli8dvhMXrNuVLuMwabiHq5WeIvZ92RzOELpvGujuRFXhwXCbS
	EWkf/d0H8R+N8eWL7th0nfY50oQ2k/t7syN02fMYm
X-Gm-Gg: AYBFou3RSCd2Wxca+xfK5DvSewHmFqnn8KAmuMidZOyN3NcEPXJVif8U9E+PjuYFVh3
	lVXZkhYCI5IAzYJN8XNNBzGqQSG/luAEhYl89rc+pNuUALXml2FRdfR6X1AVx1JOp8NKLWhr9u9
	PtslNvuE8ud1iEum/k1pzbIt+Vzogf3wNRIfINdi/rwwRuZhsNUmDX8wCA5nCN6SfD3Am6OD1AX
	RihXE5ZUSrKu3T8FLTU6iCIrRQHa/jxj4p6+WGsCC596Tlt/bd5w7jE1icB/JbhTzFQ1dNH37xc
	m8vNQlHYnvhOWbdl2AppRZ9jvT0R/wPhtuaWxeXQ/JkrCi0FZvDuG84QKdJowZeEuJkc6zh+/Px
	llLyJppHiaFysS7Lrsr1yrQiDsG/gp9aaWSS/XJ68f/6sDF7slKmu+buIoN1BRTY7cA==
X-Received: by 2002:a05:622a:4c14:b0:535:ce3:ee07 with SMTP id
 d75a77b69052e-55d5c2cee39mr65141cf.13.1794947296716; Tue, 17 Nov 2026
 12:28:16 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-4-irogers@google.com>
In-Reply-To: <20261108223913.3624571-4-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Nov 2026 12:28:05 -0800
X-Gm-Features: Aa3M54pKTQsa-oflH9hUV5D2o7s2OGZET_t0xpfakeOUoS7f9VMMcgCU6TwJrv8
Message-ID: <CAP-5=fUUatDonEFfc4bFAPKgOokjn8vEOPUNEKV185-g16U-8g@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] sh: sq: Add missing kobject release callback to ktype_percpu_entry
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Rich Felker <dalias@libc.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-sh@vger.kernel.org, driver-core@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 8, 2026 at 2:39=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> In sq_dev_add(), sq_kobject[cpu] is dynamically allocated with
> kzalloc_obj() and initialized with ktype_percpu_entry. When
> sq_dev_remove() calls kobject_put(kobj), the kobject is never freed
> because ktype_percpu_entry lacks a .release callback.
>
> Provide a sq_kobj_release() callback that calls kfree(kobj).
>
> Fixes: d7c30c682a27 ("sh: Store Queue API rework.")
> Signed-off-by: Ian Rogers <irogers@google.com>

Gentle ping on this patch (moving SuperH maintainers to To: in case
this got buried in Cc:).

Danilo offered to take the full 9-patch kobj_type::release __must_init
series through the driver-core tree with subsystem ACKs, and this is
one of the last two patches awaiting an Acked-by. Does this look okay
to go via driver-core?

Thanks,
Ian

> ---
>  arch/sh/kernel/cpu/sh4/sq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
> index 908a8e09113b..f33864958487 100644
> --- a/arch/sh/kernel/cpu/sh4/sq.c
> +++ b/arch/sh/kernel/cpu/sh4/sq.c
> @@ -331,7 +331,13 @@ static const struct sysfs_ops sq_sysfs_ops =3D {
>         .store  =3D sq_sysfs_store,
>  };
>
> +static void sq_kobj_release(struct kobject *kobj)
> +{
> +       kfree(kobj);
> +}
> +
>  static struct kobj_type ktype_percpu_entry =3D {
> +       .release        =3D sq_kobj_release,
>         .sysfs_ops      =3D &sq_sysfs_ops,
>         .default_groups =3D sq_sysfs_groups,
>  };
> --
> 2.56.0.455.g6c5a503b38-goog
>

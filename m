Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0881116C6BD
	for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006160; cv=none; b=uEmrmZbEw1efcnpZ+EBRx0lHZH62xCvAEgfEc1T9rcwYsMJdy9r20C1fJftYZ6QomQD5J6rBRdfCyD495hnDbZ3YG6MIZ9ltDNlqNuUdL/ZYSK9dGoJ7T+CA6TPv3OVXzmrVByxc3rD1ZmWct1eRuRenqSwuP39DYDC97M/9cio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006160; c=relaxed/simple;
	bh=wjxWg0jvvjh3C7l+9YJps0KCDF8s+XTkjueZkuXxdRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7ontrTaHO22bIyGg8Avhw15SSAp/Duykt73vcErefaY8hiYf8z7vHRj0nTr4CtoLdvoZsB/fpTFCfKUleB4hwsGQnWxUDT4iWus2+M5ICVV0UyebKU8D0pRNVeRtR+57ec4rWaiCLX/k607fMtAKcA+VgZS/05iD72/3ZOnWL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6c0ad8dca82so12714027b3.2
        for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 01:22:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725006157; x=1725610957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6nvWvI6HYo6VP8slzPQ8kDqT++xJQMjPIfMwQnzeYU=;
        b=DHxAfQ6dEQq92NGi74h3ZCRbyjFS79OWjMt/AKHVro0bXVPJD6ymN5FBDjpR1ooDyz
         CDA7Lbgg38IhQlmVCnL6hUjwNb2GpaxiGr4YgOtzEFLu+4Fqt1F6h2IPpS5RXPqqloCZ
         bmuQvJMWlGyBVi9X63hMHvA4nq7T4X0mrP8Eeo57vYi0AyntUznlth8hnYeuMu6rLKNl
         ZEPdLw1A7ghls/vAZJfpG1Ci6w9Gcr6CV38MTAGLIAH47mi3Sd6pg7hbNAa7uiUsuSFM
         tJZyfqbTljpITbKp3ngRgDsNRjLFigbUzoA3c46Orl7H3ay3AIuFz7vUWG2TDi7RrFyG
         7jIg==
X-Forwarded-Encrypted: i=1; AJvYcCWuTTt5X58mUdHRkGN+HzcB2wQJGmqTEo8j6PEDEQtYRqmIHABCKnRnpDvXIDKo8FvhuesyOoqh1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzes9A6qi1vUGyYtjUri/pnQtoaHGYdZjWeoukY3UqY4aQS6l/L
	Lt66VqJGLG/5CzjVc3kxBx95Zt8rEHX7u8+naK6TWnaDndCra8K2oDPvlyIT
X-Google-Smtp-Source: AGHT+IGsBvFLQRFlBRHLa2MMd8tmEHjzB4OmGXRhTbTqFhvAvZDg9dPf5IX6lH3xXivJIYJ9BeFm5w==
X-Received: by 2002:a05:690c:10d:b0:665:3394:c068 with SMTP id 00721157ae682-6d40fd1983emr11586397b3.37.1725006157042;
        Fri, 30 Aug 2024 01:22:37 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d41a217e86sm1333267b3.53.2024.08.30.01.22.36
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 01:22:36 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6c49c9018ebso14928907b3.3
        for <linux-sh@vger.kernel.org>; Fri, 30 Aug 2024 01:22:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOj4n8P6s8Vl8DcPZyZQ4tLPtdw72omWU55rN8RnA+6IA27ArX/csoFgRthiNEuVAlrOmIK3vErQ==@vger.kernel.org
X-Received: by 2002:a05:690c:6809:b0:6d3:c634:f5eb with SMTP id
 00721157ae682-6d40de67f93mr12481127b3.14.1725006156255; Fri, 30 Aug 2024
 01:22:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830080401.3545399-1-lihongbo22@huawei.com>
In-Reply-To: <20240830080401.3545399-1-lihongbo22@huawei.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Aug 2024 10:22:23 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-rRP3BCcm2mxJKjvSoYKnsLudMuFqArQzzVOQ8fv8aQ@mail.gmail.com>
Message-ID: <CAMuHMdX-rRP3BCcm2mxJKjvSoYKnsLudMuFqArQzzVOQ8fv8aQ@mail.gmail.com>
Subject: Re: [PATCH -next] sh: intc: replace simple_strtoul to kstrtoul
To: Hongbo Li <lihongbo22@huawei.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hongbo,

On Fri, Aug 30, 2024 at 9:56=E2=80=AFAM Hongbo Li <lihongbo22@huawei.com> w=
rote:
> The function simple_strtoul performs no error checking
> in scenarios where the input value overflows the intended
> output variable.
>
> We can replace the use of the simple_strtoul with the safer
> alternatives kstrtoul. For fail case, we also print the extra
> message.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Thanks for your patch!

> --- a/drivers/sh/intc/userimask.c
> +++ b/drivers/sh/intc/userimask.c
> @@ -33,7 +33,8 @@ store_intc_userimask(struct device *dev,
>  {
>         unsigned long level;
>
> -       level =3D simple_strtoul(buf, NULL, 10);
> +       if (kstrtoul(buf, 10, &level))
> +               return -EINVAL;

Please pass the error code returned by kstrtoul() instead of hardcoding
-EINVAL.

>
>         /*
>          * Minimal acceptable IRQ levels are in the 2 - 16 range, but

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

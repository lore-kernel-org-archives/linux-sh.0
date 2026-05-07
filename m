Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9303EFD2E
	for <linux-sh@vger.kernel.org>; Thu,  7 May 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169372; cv=pass; b=X8QFmRt71bZIsf6cfVl5+UMBmJjJCJ3De6+uZEZt8cEiy+r/sFxoMFIxgPqZKpU9BPqoJzJ6fbwYJ0KVHH9TvCjBgzxGUlh/J8DKooYR/VsQ6VqJgkPgTZMrSpzDjgNK32UBzbhmYbWON3eF2Asji90pZVmo0wrzjv3R3/NB2RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169372; c=relaxed/simple;
	bh=pzVUaiZiI462LSeAjzmpXCABHbm2I68wOvx3INAMRKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YweTWxBG9pWO0qayggaS6nh26MvdverqNZwFjUAOPEOyKVR2kxrEhXeMkrZCtfr8K484ajiHqvkAUjxbyrrIKtsAbeCLkOScdV6MoX48msx4IzArf9Fjo+6Li3YAp8d9mWKf6iEoI+5i/Pt21GBMVhVxOLys5D2Q28b4A1mFW2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpPOEKhk; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpPOEKhk"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b9358dd7f79so174581966b.1
        for <linux-sh@vger.kernel.org>; Thu, 07 May 2026 08:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778169369; cv=none;
        d=google.com; s=arc-20240605;
        b=CL+rx4dBicYXXkj67r3t+Ymb/ROJhmHqviShlBy661dGV1IlCKUjZEBloiikabhIHl
         893A9BMoNXG6KYNzNKQM3LUS4jRg1zwEn/kNKgMPSan/sJGRI9DN69NUjQNnU9ehTo5A
         U/3EMDw7nsPsG6VOOpg/+D/pyCt6y3a47ht89oMA/nM2UGRjKHgg6PlOtMn8PiHri/wi
         UgCGwnfcyXmfBzXxMV0Mn5NVHHFeJr5Tq+BQQs3op6WgtjrBqIFWGQQuTAHtCkIP9pIb
         nrrrt8C7pbLuqtL/9w+YDKqxcVVk3aqvsVcR0WDSimKDazSr9jyb5mlkirvIPMO5hjnx
         VlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tZnLb1HQGSLjbJmS8evDaKXMNv8pyjgwaBOs2Nqrmp0=;
        fh=mA4OQIMEyAGHbueVFP8c7BKCuzWLwYyIFuQU49W1Ml0=;
        b=jbxtQkhN+kSE9HU29P4DFe1Qktu7mySustja0CUNM4mqDakp8yPTUH8U8Vgfa8JGY+
         XWJ+p9JDx9cF1P8tS5m4Fn+pmpRSg9kl6/vNJdQM8mZ12anG3M15xXII/ZuXO+rutUox
         RS1OoHPDkZlPiWkLWmOg5MZ+9uQ6Ki8972WhEC86fmBDckLr0xRVIVekc9OPDy4PlyNn
         jfXYrYUtQgmd5SM8omJLbxLroMzujxNWX0aHPfGe8FHlP1Qe6d9RcJKu1KYyIIZ3XEtU
         0VVj2MquKqJgmETExSOAP2nR+Iurs7tiwVRHQctp0gANyvUbAOT3JY4OHNqQ/nCmkO0d
         gayg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169369; x=1778774169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZnLb1HQGSLjbJmS8evDaKXMNv8pyjgwaBOs2Nqrmp0=;
        b=JpPOEKhkJThWK+T/4GtR3HqRYy+3d8Yn49pi79Afi3Nmi6CJ2cRklk4YCbCoFbAH9k
         QSTWKEihHHx7pqR9vCmf+tB8fEJ8ILPBLIzLjdlEFxFVomqyQH8p5l/EQLh56gZh3NSH
         kwB/NTjRbCuDCKAh9npf9SN5g4+pobJB0j+AK4cXGHAWkA8T2IyRg6JUbi8ny1CYiCrC
         qKhcJTwKim067Z8FcLuojlmVrCTramYvA/MgLawg9XKkUwralCwzeNIdtUwmhKv9IH9e
         Pz/g3YJVB4TYdUnjHM2lKtX1ve8lEAH6wtG0bKWxN3vh8tWDQikI00O/XXIHdmXrHhov
         3Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169369; x=1778774169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZnLb1HQGSLjbJmS8evDaKXMNv8pyjgwaBOs2Nqrmp0=;
        b=XibCp9i1izOQZLhTN+9N3SKesnbAvEggeIJaP6PqN6+bzsNE5kLZbyJ+dOC+isJ07P
         mqKzldF/zIKCR9F0KHNV1ld3OFkbslzOm01lteDXDbJmfo9OyfNeU6ekfzCncZ4KJKmd
         YOf45cPfPUr9xSfQyI2rIZIzjX9fMBO3zc4Lu8VHJhChChVKmRP+0sjOwKnm8EXsCHJp
         0SMCCNA688px1jARqfJsL8WdCHVDJ1Kb+99m1vMHOyWk0rFaarU+/KVAg2aDIRZ8XRem
         GtGtBVy0cKevtDpZD7n3zt4JCFRnuVom9tnGr5tC7AzOfhSF6EQa7fwyCm6mypP4VX65
         gPvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9l1AdljVo/N7cyaaAL0SxTSe+ae3Q+UMoiblF83KczVofqJkQDfgo09CbKrZ1ZlXKl0RYBRtmjJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6o7NZEfLeRE6qNgkv9mJt1PPNrWVmsKdWMwqlY4HmldQGpFi1
	ILNFcX9rnh8pCifGgvnKseR2lVPowxUDEq/4FreJTTTqu2BHlN24MdK9Ja/903604bFzT906Jwd
	YmEXf0nCovuQkIJdMdoOxxQJ6DCRxgo8=
X-Gm-Gg: AeBDietuRe5/ixq3LPQWfXea+HFOekhpmlL2WtQtwbB8H1wBoNe3F6foOEFfJYUukrY
	OXOhh6cigNwNV5soMb42QfWDxSkUy7Z+J5JauXSIFBEJLtoafhApxwwDzFvxPgsOlBVRglESwQa
	SbLo1rrakL5W16x2u73PyHH4zq9h1ZKefB0Lmjc5udH0NGda1Mn0ECNzzt6qHx2pJFjk0KCw6ay
	0l33zgsS+PnlYErkxr7GCWEAglbfUJ3LJu3r7qQC7W/fovJSMyMyjp4nXmli4AcME7WYMw1tRWU
	O06PiXA8skdRe29tEU+jT//7z/G/76jr8EZfF5oiCF+Zd52EZCrvvGmKQ9WbtpcOXKadJw==
X-Received: by 2002:a17:907:26c1:b0:bc9:ef67:3ea9 with SMTP id
 a640c23a62f3a-bc9ef673eeemr134499366b.37.1778169368665; Thu, 07 May 2026
 08:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506124643.128021-1-geert+renesas@glider.be>
In-Reply-To: <20260506124643.128021-1-geert+renesas@glider.be>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 7 May 2026 16:55:41 +0100
X-Gm-Features: AVHnY4J3gSuHJu_9IGGrqCXhoyZ3XPxDCslG6bnaa_Q7FaNolHXC1lQvxolbGqU
Message-ID: <CA+V-a8uO2L-Ha49+PxRV49Y5RWzvaVA1PGwigtcwPQS51u=+hA@mail.gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Remove plat_sci_port.flags
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:52=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The last setter of p->flags was removed in commit 37744feebc086908
> ("sh: remove sh5 support") in v5.8.
>
> Link: https://lore.kernel.org/CAMuHMdXs94k3-7YD-yO7p2=3D+u8waYGAz8mpP5LDb=
Mf3szt4V-w@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/tty/serial/sh-sci.c | 2 +-
>  include/linux/serial_sci.h  | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 6c819b6b24258d36..a35230d57540384c 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3369,7 +3369,7 @@ static int sci_init_single(struct platform_device *=
dev,
>         }
>
>         port->type              =3D SCI_PUBLIC_PORT_ID(p->type);
> -       port->flags             =3D UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | =
p->flags;
> +       port->flags             =3D UPF_FIXED_PORT | UPF_BOOT_AUTOCONF;
>         port->fifosize          =3D sci_port->params->fifosize;
>
>         if (p->type =3D=3D PORT_SCI && !dev->dev.of_node) {
> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index 0f2f50b8d28e2743..36c795d61f7e8457 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -51,7 +51,6 @@ struct plat_sci_port_ops {
>   */
>  struct plat_sci_port {
>         unsigned int    type;                   /* SCI / SCIF / IRDA / HS=
CIF */
> -       upf_t           flags;                  /* UPF_* flags */
>
>         unsigned int    sampling_rate;
>         unsigned int    scscr;                  /* SCSCR initialization *=
/
> --
> 2.43.0
>
>

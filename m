Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794560306;
	b=sWgU70sIgx7REpY5Bo/+45eKELOFTmTKVhMUryqgf0qrdoAg/HGn/eTod0RNYORZHu3J
	 IAvUprIrt/e4YXdut4kvVJY6tlFhjVfQ7bHzq6LMsgo6cjWuYZm5F/BwZpGVKLmxcGiRB
	 tfd9Q0JvU93QuRI1JA+AbBS5gca7fol2kAzgFXZ1ua0AYprJNVClVmi12BkUV8jXBc7jU
	 VXqErhKkNmjIGTvFmT68xPwOagP2uVCL/4qQmntLOTJsaM3LPhRHUrpabrU5nfMo7UcxB
	 jGH1EMOM50XwG349X6FiTG5J+zd/KYkjtSp3XQaYrY1ow6dyutKJD91/BUf7o6C/YRw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794560306;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
	b=RjaHSvIJoELIH9ZfhiWGnr12QQnzSQijvROOeJ56pAvkvFKTvDGE9nMyVUqgYVGxMVBZ
	 LJ0fWDGnvF5MMiSmwNYshz3guFgv4NnOsjeZ7qoUaTOZC/CzonQPFlCkw7hq/BVZgE5HI
	 AKabp10wIpUCmwzGLBJi1xOFn5rootmwREZ0M1LDxfvK4B4eCf6vsP0/4R+ZUvWEZWilL
	 Cyunyi+UFcw6aZhu/6e1MR/puYkfEpDj57pFKpeUQ2klvTmDyBnVjfoKkdB0GiYKFeETS
	 BCCwpEnI6rWpLXwUymrOYPP63vB3ca66sHsfEtJx+4QZW25ZUHkFkw6ESSZeAEt8Cpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riuEvSnN;
	arc=fail smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55784606A323
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 08:58:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55784606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riuEvSnN
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b305d38bafso5136837b3.3
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 00:58:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794560305; cv=none;
        d=google.com; s=arc-20260327;
        b=cloup1nE+hZP30Aai5POVmF6tqVLIerlPBeiNE8EDIIgHPe8E3qT+S8+NGHm8nYXOF
         yuauNDQvxb24yYf8kkMiVQEuT4bhAJqm4pgg3GBfos5TgPz6Xe1izWcFDljOAecVsdik
         3C/wTmeIxsCvPB1h5brIO9hzf7/32//rwVNePTjv2sU6P6lO+jqSml056og7g2TfG4lH
         yLnQP5XjQMG0MZPPlfKnO/zW8N2mkxzaKKxLM5kqYGT8Wekx2xXbcPH/wFEvX8jbSXVh
         v5PTFtsJi0vJs/ZifIhBLLzm7rXCW9EH2vvsOu+MAfN3S/KMRH5y0LR1cgvwJtkVK30O
         Dx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
        fh=CxJhdl3F7MYFgRV4BKq9IO66LgSWaDqsBMOVdX9U5Dw=;
        b=SZ0GW0MWU/XkJo5Wn/pO96bjG+KVFUbQEV/OJTvzMXKfC4r7JgJD3F3Z1uZo0dlHg8
         dER14dhmhhYYb1Vj2uJMYYGhIGuK8uErsOel+LTWFB/nYoGxdpF7OBJKeYSKcjaRlsUK
         RHpq/OVzZcFoGHxBBfwm/h4GnRqJJzXKyzrpUuOHc7fmqT7KlyIhbs94Uy8qd5swVpCj
         2YsPX3IDgGr8qB0kVtKy0d+RSZmjgsA1pIx51MQ7CET04jP5vNxNWPdA4+4Bc8zNrcMf
         fuSeZ/5UPFyVe3MTMkfBIibXb2bl8GkbvJ4qmBuyyvy1ML3PHjmyQhU8RR3Yj960yf79
         sd6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794560305; x=1795165105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
        b=riuEvSnN7JmdLlXxo1i14j8AdCq4QwCe+cbdOjeCp7EGB7A19vq5maOIEqo8K85Ji4
         yW2a2Bu0TQAzsaVZGGVeCNrHSMAHXQJv78EtKkBmqq0VcYwmuXjOOAYl84PWZGKWvbNN
         ZhLJF9aGs07sLs8Ha6u+1VQR+l6SlJPbL3oiyZQnL4vCnGYgQjYwU8a578Tl1ec06TYR
         OGLQyjS1avlivz7inCsRuFUdcVlj6MHB4XY8P9SZqPFun7vOibhXPifH+Jgk4fH86wDP
         uv3mYbZ4av7L4+NtVtvvDqpkp0aG4GJbByEU+fgMG5zzRG2XmZkG1j+gwLfwnoWBaJWX
         o7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794560305; x=1795165105;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdODR8oMvC9u/tbpB8xQBzqRf2Zx8GIT7V8LD+QVHbk=;
        b=O0at/qioamKUAuXq72QiLn+g6Sqn+YHKnYhMSkjsjPDVvsFohYcW3QZYunB0uNk5jS
         vegkFJUz8Hpk0+RGuACpH3Qc815izSMBBsoqbwMezMw2Sk7jTAJNQ2y1eXVgtcsvOvD3
         M8G7cE+aECl8sbT50NUzYNQRTlAYqUa/tmaAvzzAI1JoHokZhamnWKNqXPuldlJxyHrW
         rDUNmujVGQZ+n8k67nsoIBFaT+S+7SDYm2srTLKX9WXCM5a8j19WY4LN8hWrBuaeLGg+
         pUhf3oGaSgc7NgqXQ6m6MABsqIUF/xmM3V26U8hO9Q75Hd66J30/tMmJYA4aE6PAbm/u
         GGeg==
X-Forwarded-Encrypted: i=1; AL+hErHTc0kQ/bBvHbILXYty08Ish2gKS4esdCdBLlJCXIMqrJ6GGXy42ZSBPovoa2HTASOR9Re8RFHyCg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/fY4hxPkUjkIPuhP7P+Br7ZJYg9lakskOrMVc9Wg6bETnyOskp
	K2V9SJ+hAL7JRNlwoj/HSvBZagUSF9e+FH3kCYMpguYgXW+cBSvoB3QDwIz3RRyVsSL3jTGfAq2
	4eEgb0VvVOuYk3cgA696r0izyqCiTB3o=
X-Gm-Gg: AYBFou0CiTPdMyjJL5YMpKM4oLCc/O/vsDYDkTNTbxDwlnh8uA9qvvtmFXtTKhhW52F
	fXqqz5qcEpQOQqkFfp0Ax7Hd9I/ra7xk4mdH4gkT/tZ0lpInhNdXn1PiZCKvd/oJ+FwALU/d7dW
	enqoBVKkOgADpzArETbgm948Ie7cJKHphtfRueRQR6VY/HfQUptn06HoTPUKKQ0iysILXtbZ+pc
	9PDAxcuzTdNVS8ooI3/lk1Dn27yoSttBazVNnRnKbKhb0zRPEimN78FXzoscpwRabgQtzk5Z1Nb
	OxdLZakwQ9ZxCqZObhBegUsrT4vcgylnBCTPCHVeZjpuXjuy/gfc09a9oVHcGUdMsrKWzxUiSwo
	h9AyYmSOpVEI5d1JmEmzkJFjjyqR1vdI62EBojEQkWtiNUVSR60/TJwxeRo3s/7ApWtd/7d70G4
	0WBUt1EeRZIp7+fJ+b+EISu5T7tHXfFMk6cuSvZC8AxjEJxLlvQPqaOKL9jr4QenGV2iL1Y+c18
	0TD+7s2rZ7uctp2w3V5Vv9tr1LUWrQV1tLjbduACTIHxa6E9tjQgPNc+r3xMw==
X-Received: by 2002:a05:690c:7:b0:8b3:22c:b40c with SMTP id
 00721157ae682-8b4aa0d0fb2mr13819027b3.7.1794560305368; Fri, 13 Nov 2026
 00:58:25 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-2-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 10:57:48 +0200
X-Gm-Features: AclHuK8xbnlVzSxLbVaTLM1vgALdMGppH-yIDCfls_fqrQt5T114mrDDfzRO1l8
Message-ID: <CAHp75VfKx3DRa0hU+TeFmvi_24_MLVwhmwFRsHO+ggMZXYvWbw@mail.gmail.com>
Subject: Re: [PATCH 1/5] Input: tsc2007 - drop platform data support
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andreas Kemnade <andreas@kemnade.info>, 
	Johannes Kirchmair <johannes.kirchmair@skidata.com>, Yuki Horii <yuuki198708@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 8:50=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Now that all in-tree board files (including SuperH ecovec24) have been
> converted to generic device properties, legacy platform data support
> is no longer needed.
>
> Remove the platform data structure and associated hardware callbacks
> from the driver, check the pen-down GPIO directly, and remove the
> unused platform data header file.

Very good!
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--
With Best Regards,
Andy Shevchenko

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562575;
	b=HRNF2n253lBBJJ0cModthoye9A1zSeneh4M0aK2zKK/RzUk77VNCAdDegpbD4ITACYy8
	 HBKnWs8vlDYAp5SY83zVmljKLgnV/MNeSHAQKvjziFWmsd40EjMOP/4tmSpSUgWT9J0/t
	 I4/2l14vt+h0iboEZGRYZh5s2RlqwtRfNmZm2BOzCF5VBrdXHBTkdCg+ZFti3nVYJ90gW
	 aFAJisPLDQypKmsrYUYnvAu0Ze5HbZagutCzQAohX+Plqt4TGeOPDXJpzYG1eThZ2zPyV
	 FkQZ1f7+BUdD6hwByZyJ9d8KIOzzjHesVf/2LVeOaHbImopSSs+YAf2QkEsKs24E7Eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
	b=1ojvWTykYDsNEhQbr/touvBHmJX9jzXDrWkqiSwAYDqIk4eP4Qy2jG10Ia94Ue5sB0o6
	 KMUN857+JfkC87HemJ9Ttd5pEAofL59rAHySbM4GV3aRJ3ym8y0z2IBzD7ufh/FqZ33EZ
	 0/Y8Ndel3uUp1cb8JMe8ZeTDOqoliaCjYR9dyWq2S8LXNd6i70LNDSm8PUv/q5fZqpwHt
	 PcWs+pJn72wJc9XVWrJgJZ9KwnmKix/6AgROb68CubQ+N1NvENoae+0cv31G9G4+T1tU7
	 mp1p5SUrB57E6qOUBfa/ZG+nj2DNg7YArLMYCOr8mHOjABD+n54yj8S3mExv0HRRhPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpnUGyLj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3E606A31C
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 09:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DE3E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YpnUGyLj
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b4b2e52baaso553667b3.2
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 01:36:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562574; cv=none;
        d=google.com; s=arc-20260327;
        b=K9CSrmt+4GD1Evy0ZAiGDzv1zb0aNCsM/dg8tFFZaPMTgSQWkgLo9ugWs/0AFfIN2X
         zub15HyqJ++6ct0YzLwGXoDPO77AoV/M5QDZSpvSIg1dPkKlQsCd4FGyZ9NCQX9Pt1xZ
         +V3HdqQ1wIhQICGnPY0KRHvjtQ2czzGHsI11x+r55DFXjAk8cpisq6fNo2/NXy9Woxrh
         li/M66HXQBDsy8c2pI4JkjQ5r+jmRSTgaHD3LlJjBpPdhWJenfbFBdL4k+bFUA8djlm+
         6RSOF9UL80A4yZWzch1VX7GJcawOhbo90rSvCRqkaPsrJWu55jidf8wOk8cgdNm2+SFZ
         KMaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
        fh=+M2bZU6vaSYfumaCN3CmwmpXq+yzWI6FGROfnt8YW+k=;
        b=sRUnPDgV/5VUtNkJHfa6PRIBJeQe3OaL659IKPcrm7oj7lyTGWRKkOJySPgMRPW4Iy
         DCgnAwT0okGSVFExiK9f3GMeCLq6MmsShBQZCfEgzVZrVia+wjF5HCWUcmawhuao+/0x
         skwJ9Cneysd75m2RIZ55OzqMFVNcDPX2rnJypA1Aji46c3BRsPFj8/1hZI39YZW0IQnd
         LSDHdI0Fu3DlQBQ83+OUmT0KMe6Rthu/KASWhqGPp7SiMLgCM/n7R5OV7F5LmJCJWvQV
         qUUCOR5v12GZbm2c3Hujw2n6irmND6eFa/3yKiP8Z4hNLWjOamhO0fVGp3E1CH4Mkbiz
         VODw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562574; x=1795167374; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
        b=YpnUGyLjwTTMPc519eNPTuVbLmsWYvdED+cQpDTOEnZxKB07dA5nbVbtkstlarUB73
         RZnRl/1o+zNgmL+pkoBsibRXQJ71EGX9qusasyTyKNUeIBw78b4sX4evsWbZpwT4+UzM
         4hEm8ZGZ3mRoPT0rbBalEcvgZvIx5b50uTU/oaP+kaV7CRLz7ifv9diaRVNC1qHzKDfZ
         RyYj1B8nTbpTnVwkAQEj4TK/BSokn227r1X44UaZivMmuxPDhLPnt2hddwnfpgcIX3TW
         K03eFfJvb11MekZAL783ZRSu2xueeP/fuxr2G4FlS/BM0dyCO/sY6ANNlp46dhFmvvrY
         a6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562574; x=1795167374;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GC3vN3Ju+9r5kwgx1dcLNYVMHeXAZ3yMb/dI0fBLirg=;
        b=dEFNm1rRx7bsdW7yz9fdIBirD3CogCoTPm36lYXGivTb8wJqnWJbtezrQ2e6CHK5Hb
         NAow+Jplvbk5a/fBhtnXWR9wzwa+bfrv5dJIV1dRgbZOnTFui24hTYqse+hNDlvzYA0u
         FYVFxLOsfDMzvZSFf/A64JZth1FueTL3+rYAF534DME2WV0O8rbEUeIdZeyTb4PEUBaI
         w5tb+FgNpJIlkUaOZO7G2CAKuQpzOhaijgEgvaS+cONXiE0iSOyX1zcnB0I7HGqquEpI
         HJEk3k11ad/4jvPRscVsaM9zkV3isuvb1Y+UCYY/t9Qr7x9ggsJxYOtSfz/n4S0xLptu
         YSqA==
X-Forwarded-Encrypted: i=1; AL+hErFhowU7KdeaFaXgN0D9uf5LnMyug930cbLGoTx8ij2vdksKVCfUwYYeiEWf0ZN3Lh9CBtf+92aWvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8BOtOtdoq0cfphRT+AIu3xlMlYv1MjJc+uI/+gXS+dL5xJKRlr
	p2u08E6ylBtp4W3rNk0eNuIBjihlNPMFCs9SDdfrS9J9bnktgfGxcHIY3E5IxY09rJ9NoyRmnCA
	9HTZNnB5p4JJQqNM3nVMTxZtDlozsBvM=
X-Gm-Gg: AYBFou0PXIB94rs2uQlopqTtJgnAUd/U21dCaKg422JMeI9g3bO13ewks+89QkPu3Tn
	vxAGaapRbAap9NczlaD0yzQQUm3pm9wTQn9TtwQYbLQX6++JeAClDLYLJcBGUrcj+75zlDvB6SV
	ObSCJSAtRL6TVyGklpvILR2JXME7p/G6X/KgI9lxH0NmkLq4OTGsilliHMKRZFMi/PqMHgfLVlL
	F33Ia6QCTC8AmDUVPOcl0jqRN8bxudcldCc66yCPrIdsQjtIToXpxtmhgAV+1bYO73iIde5ytMw
	zwGnvhPfBhiyPcxpg+6SMrpPkzhHuXR/lx9reiN1BeEL+F8UQUh1W9swF/NNZGZTDOQkmXNK/Ra
	BGeDCeXD2KWch2uQomChlgL+JvB10V7Wjl6lUVasOQ7gNd8hmQ/MkfvX+UfaEtUzcuk0WwINDVU
	IYVaq4z3ijXKUhe8OnnB4qHdzMWIxh+Ph0AAowu8LBezvOjbei65yKD6wpNVraZM3FmnQw/ePND
	HICG3OykUVZuwzYiwN4GyGnIqqWU76au1BfFfJO6tWNTGMNRfx4cuZsEP+OY1aWt1zDnHNExmb4
	GiZCz3g=
X-Received: by 2002:a05:690c:82:b0:8ab:6374:5629 with SMTP id
 00721157ae682-8b4aa2efb9dmr11468797b3.30.1794562574285; Fri, 13 Nov 2026
 01:36:14 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-4-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-4-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 11:35:38 +0200
X-Gm-Features: AclHuK8mf3feDLq50Bt1BSFwCDhuFJWegSiz9V4F_TUQJsU5rvtBoffQnUrSgRI
Message-ID: <CAHp75VcY4O-kgYv9jN0vSiU3Y8FeFDWAojeYWhOuKJuzKUXFCw@mail.gmail.com>
Subject: Re: [PATCH 3/5] Input: tsc2007 - fix minor coding style issues
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
> Fix minor checkpatch warnings and checks across the tsc2007 driver:
> document the mutex used to serialize I2C transfers between interrupt
> handling and IIO reads, remove an unnecessary blank line following a
> loop opening brace, and drop extraneous spacing after a cast.

...

>  u32 tsc2007_calculate_resistance(struct tsc2007 *tsc, struct ts_event *t=
c)

>         if (rt > U32_MAX)
>                 return U32_MAX;
> -       return (u32) rt;
> +       return (u32)rt;

Do we need explicit casting?

--=20
With Best Regards,
Andy Shevchenko

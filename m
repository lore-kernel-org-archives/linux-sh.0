Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562346;
	b=IUxWzr7Qj20khXMixSSivl7qKtx1A5oDKm9+dH9O1mqy1dr5da/ZYwnIQ7IBEUYqGzBV
	 lNRaBAZeUHPJ2sxy2Dm4RMo+sWyIWqxSgPFNg+Xx4AC4V/qfJEWlbmB8JCJNU8GH1+8O0
	 G1alJHZvCm21F3bvLWBu5f0UPKWAnoJuy+fOBkOjprg8GzmyKFDEECo/WhYrLRLikd/Vp
	 RTrmhfUq5+pki3zMnC/oTbV7JJ3+jcCbR4WTxuw+GpYIs5PhtF/+koWzOlXv2A4K7jjfB
	 ScaGB6zreTbvLZ2r8yFWPYj2ChILdSpzJgLfMA0bPj3VnasyeJeBO9FUcdBH7q3wqlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562346;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
	b=LqnJAz0xL6YXVss48yczQvgogr1aG8eHB0b6LJDd6QTlx/kt2s/dvIQYU1Br4GBO5kpS
	 cEGdvcOJ1lkCctS6ombDHwe6rRtmUIlDvgtu7NBke0Oul72urcQNtCOo5ilg9s4jSbFyC
	 xi+60/Tbo/Yv5Qv33WQFGzyJZ58xKWj0A+ZfHNk7JPSKD4v0Myv0t8m/F9MbvVSOL0QMx
	 qI6lvGfcsK1iEeVZm3w429Y5hZkNl1tGvjFBSNEL/MIfbbjGIPSNOST64KERrlNnqdko+
	 1a2TkZJrHvu/QtSn950Go1RoDic+x6/wPHSZRHpdX+qh5omA3NEOF/WhmrAuMlFU17w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb9wG4sY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA0606A323
	for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 09:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07FA0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Mb9wG4sY
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b30ff12f84so5149377b3.2
        for <linux-sh@vger.kernel.org>; Fri, 13 Nov 2026 01:32:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562345; cv=none;
        d=google.com; s=arc-20260327;
        b=XyiOG1ap0Giq2vjqr1kOYZ0XN1cC3NaumVDOHV2XHMwBGqqzIrrXifX2GEeD2/cXI+
         MDBZnZ3y19NR/Vqlz/xB/FIqy56IlinPuchjKCkxGeUiznhl1K0QsgoxKt1/BLxLRON+
         5HgSFgz1cCxlb9APwsQeuGbqD/2q5ZgG0dLjrMWisSWojj8rIeBu9fC6b+RZ9lQeG3iL
         MNZwBoXPszV6Pgg9VpI1dBy9GvTmxYFxWqcJIfAOU+tjhGLtw85l+jHvotwBiyI6qIGh
         bSGTBjtxzIQKPMwVX8O2NngPxgWlMnfMrSWiVoWmafpeRAsjnAA2ZdSn9wqPfpD5Ujb0
         Rveg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
        fh=GWUy17s/wWTW42709c/+pKKznI61nzUMI3mJez9rzAA=;
        b=fc2TYbr3NtgP2SV3UCZdtsIFEvkzog9DG+e4uBqCOeRyI9zxfm+Fjj6/ksYkBGAt7b
         tv+0PGBfrMpY/tGEz39v7jEWX1WdPiXAzMB1wKYhqUIfyDbpTAZNjkbLERu1Q0OSomvj
         YWKhKZl9X/FphiCFl/DOUJ+9GUr0Q5eHBBbrW2IubRWwivOp4tWp5phmn3bbtT/+JTl5
         iJSCcB1WPckB3FcYbaT9n37gZhjopidayWerHO0jEHbRS+LGKn4cpr8Nb7Vs6clSuokn
         prckUG+QN8oWUenGdsVXlhD1oKgIRG6DlK9oMd+6RlxLaX5KQ9w3rYHoVTIiJ834CcLE
         5JIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562345; x=1795167145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
        b=Mb9wG4sY0QqIjN4QD3o1anwYH6pdqp7Z5e0CCPPaPvOG+MNlZC3ozsr5hSXk182w5Z
         t1WhyFQLHf8KZJ71Fm7nxK26YTIeqnacdYw3dwcbyb4yi2zPScTfKiQ1qimXy4ukdmXU
         bkIbZypS6EPEokf71e4Mk8rIT5lU59HXM9QQK5yqGTPPkMzBOy2zN2FDFKS+YvSZgO4J
         eLnsu66OsbiThbcFyLsyXfDpLmMqDFmxHB7J0rNsAX1hpYnJD64WQ6JNzB9iBpo4yBO5
         hL01Y/GnP94/1JRyJs+nPltqXoTIMbvHio5nLVh57cKLyqfMkaMVd+ol3cpL6F7cLqo6
         GIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562345; x=1795167145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUNZMXe1GM6kWxO3EpXBhVnmSI9S4lEPAqUOYnawbcA=;
        b=PWBbOhnq4HhRpOH3dFw2MaBEDAN3HkEaqm/s9tN9CTsptOIdYKp9lbVLS9uk20TyLX
         cwNptrXnrxPpP62mIH2C5b2TxK8FA1X2FkVl68lDsdIgWJKE8v9/aRaNJkbeIddFG93O
         QFrnpVuG0R07ejyJ2M+xexJQxpvpTrzD35mIxL48BFpNJzSRVZIMUZHsf9Ooeceyq0OK
         smUwL2AkJjZaDZlB/mD6h7cKXApURtJAWPs8KIkIblCRhopIf/fIw7elQ5x/QIcCVvjf
         bvDFCNuOle4Al9q2IzUQZqcme88l+WsI46ZdHnVTCma1j22qUqxJGcIADGOeGTGJm1wd
         2fqg==
X-Forwarded-Encrypted: i=1; AL+hErF47+vCul9BBOBJuT7w1i3roHkeuqWp0gb2CBOSNMAgNPs6Lq1dmaoc8pL2fN0I3Vml1oRvQT2JDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9wgJ0mBarj/hPmG9oWygH1aELi18qVlcyOxcSlSXTIDDJ/tesM
	0muHdl/MPUsrXrwUXLYxWY6gyEy8+SUhQf90SnGO8o+ztMqnfx7OUcND/8BMGAMKwIAWR/ySGBp
	4mvcndAbGzi0PvWdr/Nrg3HglFW1531k=
X-Gm-Gg: AYBFou1QyWKGd4WZgnIuiNRGPU+UbHtM5xQuJM8qUZHiZ3yqcvt0A77tqzlgE2oPjFe
	8y9VJC7/8CnhUDGmiR6CxApK3fLfrpGC2iS4Gv7n5wGgWVIl41h4G+BSeS/SVifhNdDSyjfZ/R4
	LfWSQjO5KRsyMzXZDN7zZ6DEgcgrPfm6Oq6ZGD79rnYF4usLeQe7uz/C2F/lvUodApVlBEiEvIZ
	nYHE83epdW+a95ucOBOplW7V2u5lP1bWnOsAJgsb6tDkRXMaCXIGqQATl1Nam6/kzP57+xcXyHe
	haAao1H5PGgK9OmbANAhvFW8vyqP2ANXvNsPdouQ4mWX0FDNoxHyIgefEx27dL4TxLQHgK3J7h5
	P+uG1VuMMgGPZGssnfRUQ8mIQTw0qPiAslaTiJ53+mzDEJisLP8tIr0k1ww7zLbCp3XigdSVrhM
	svais5rNLj7aMRo5GMPFsCbVoTLhDCjWaAT7jqWYXJrnCpp6448SwICcGvtt0pAMMYdhLmQtgpc
	oTFjE9qAQrDfvbowzc70hFl6Xw3dj2kQ8Tf4MLhAZ8dhLN615TSIo4jT//BAn4=
X-Received: by 2002:a05:690c:1b:b0:8b3:7782:6759 with SMTP id
 00721157ae682-8b4aa323715mr19625897b3.38.1794562345098; Fri, 13 Nov 2026
 01:32:25 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com> <20261112065037.1800467-3-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-3-dmitry.torokhov@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 11:31:49 +0200
X-Gm-Features: AclHuK-aYVuDT1vvMCtJLPucjNeheRM7g7YQo6HW2E7XrTdn0Ql1diwa05ev5tk
Message-ID: <CAHp75Vfn68p5G6i8khQyo3COt9Aq06JeYJjHBqaOGXbmtmRNdw@mail.gmail.com>
Subject: Re: [PATCH 2/5] Input: tsc2007 - remove unneeded memory barriers
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
> The driver invokes mb() after setting the stopped flag in tsc2007_stop()
> and tsc2007_open(). These mandatory barriers lack pairing barriers on
> the reader side and are unnecessary.

...and they lack the comment why.

> The wait queue operations wake_up() and wait_event_timeout(), along
> with disable_irq() and enable_irq(), already provide the required
> synchronization and memory ordering when stopping and starting the
> touchscreen worker thread. Remove the redundant barriers.

Reviewed-by: Andy Shevhcneko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815930;
	b=K2oGoZebtk9SGSJEYUduO8hkWT0oLyNhRXNVyAFI3dtlX1PE2VMzcySOLVyhxkLC+WBL
	 5Mew/5ONDObmW8z6GRl5XUDYddmn0UGQLPBCatwRLPydqznzy2pXIYFX36yBMNIXevB3z
	 9YQlZEYw3eCAuS/C75FFwCesPr3P6UATNxA2tF8uZ+rQbVjJgKKj/iYHYcSQAoRr2QniM
	 t5zQ46X4bAo9jl+ecIhidB+ZRFAwaF3ba7+R3KeLfM7Ymz1fiu4dtxzjAlba/Xv87QzmS
	 75qrgeGU5BnII5o/BF0MfpzHdGVhvIyX70Z2wbrU2+gIUntgX/xokWbfvjnAuJ2cCAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
	b=f9hzkbvA11Jvao3M4+WC8wUtxoYSRDiziBqL7uC8Cew1xnVFgvq31BBcknEWoBxmvIV+
	 JILnWuHT32IrKV+liKcHx3y88DpZGhGAkJcCKmUUM2+fsefpZEVQOGebIYXFJG6n3j3dW
	 +131QyoEkZFmTBciUQqmNz/3ngl1lEc6/UY2TUAaDI3fgPY5a9FFJvBOiBEA1Onrr6KUa
	 iy7FAaWwBbQ22T+NEqx02yUcx4+OiA5uuWGLWDeQKdOyxaRJPtOF5yJJiiFtrKlWCnPyk
	 IjdXg16SVEHjNC89i3Xzb2SzwtJNsaRdIUmSwHSDHj+up2ta0R+L5TgsbpkHpOpNoVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="m/LM6ars";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF389606A32A
	for <linux-sh@vger.kernel.org>; Mon, 16 Nov 2026 07:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF389606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=m/LM6ars
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d05d51553so16457965e9.2
        for <linux-sh@vger.kernel.org>; Sun, 15 Nov 2026 23:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815928; x=1795420728; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=m/LM6ars18o8GDKRmm846P52W5VTEeLVl3zm4E6+Ukoew1PNUWaySYAFTHbhwbIHY6
         8zyWRJ3E+soSg5cVCg675JZQUuiKrI7PnShT86jC05Ju/0/IRheNzvGNmD+npQLbnkn0
         fy8Il1K6Vm+A5YZwCa+xzQ2+KQuOMrOvsBIKg/ExEvAa5Y/VxNmGrq1rCHU6BtXLMwTC
         Wsvn5VDRjOEmowS+ZSTEWPRIhLKHrJyNPuqywDI23KP2brkj28XF72ButTpsWAH9l4pR
         IypEgitHhE/vdzZkz5m5Ua6ccTEUz62Pa2MJahrsFOhrSRlAMMkSQY6/3R5U6hM1aN5V
         0hRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815928; x=1795420728;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RUWz3ZPMUxA6+r9kTNI2D7JNnedpd8n5diTIAYYVkok=;
        b=HIRHpcvoojUJDoBgGm0epI7T1Y1DFpMDvGv1/U/16clEal08abq5Hex2YlzXUtapn4
         PwkOeCIB1k412GPZHWvARmvjxOqGtTBYUktroC1nF+t6YmIe5hiJrNzc9KyQxKMdpU6n
         VIUa2YnyV7HTUG9w5w4420Ch9GGtw5FYTr6lHOQqVtznuTp0J/yWpV/JPeWWXWHpBTSX
         tB5kCVbtAy7RCzdUW+BZgVAGaTRJ5UdKSaiAHeW4L5OZhgvthCLO9ceC/3bxlUQPnmzc
         06TEgC7+/8wBDjqxtSDWNhLC86vgZmLSYkG+j3cAzLNOlHnzJEliCnNgb9Yvl2WcIf2F
         rSCQ==
X-Forwarded-Encrypted: i=1; AL+hErGOyL5XxoONfC+Molttqak4WZPm5EbiozZ+3pJ0kgedZPa6yQrgo1Ygl3vTtm/DtiNOH8i0MWUB5Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+OtnnPRQiTfj0eQ5wofBLrMO9ORvgBRDKn6ycCgMS6MlgywR//
	BxN5VOWVRfVfhMccmvChUhFOi6DfbMOIhztu3CcCg8TJE73gH2fpKTfUNazyvfCuTimX
X-Gm-Gg: AYBFou2zLymwaFGGoHF3ExCT4CBE5BNeauSNbiejnaM4ReRR+1YaRBgVcQ7cyxcdItd
	Ydvi/vSq9GVhwjUDyxTRifDHTBbeS1ME4lp2oOBrY/sacGs/kvochdvfpYzqWnAEjXr0TNABl3n
	q3Mx6pOa3Ra3uoosDtbGEaGGu27YzwhLFu6YsHnGntvxb1dcpb0VOC2Sw4Ujd4sJ1CWN/ZOMgQD
	evJXG3R12qno8DY4vsxmy8WVUqHduF2kOeprOlPdqinAu/M5+4cFXzaGuKfJyzjP6xBeM1ryU5O
	B2euDSJzkuzRWg1vMylqBMBfygggVPYM/+eg9N/+VHpjj9G5oPLP8O8zl3SxaMsCgk9WArPGyog
	5gJUwdPdJA8L1vLimGBSidGI1Euqop/fdphTH9SO1fdUHhgXvmK+AE9Bj6a7FMfcxmPWGnyF2sP
	PAnWEyTuL1QvbfuYPos7k/0w0h0zN0xtUlUex8XMic18UamtGFrc7HOJ4pyLrCZgDQhYA4EgTT3
	kSX79pavbIbnkHJ7xvqsotGWIQXNKRjiIqELxgkwKsdV7fLgi8U2+c8Hwf34rl38UzFx7v8oV67
	xFB0diVNClr5essyvgXh3WkjVqNNOp0jpJLqL/BopHHaH8g6h+1bal++DAbvT0k=
X-Received: by 2002:a05:600c:3b07:b0:4bb:5de1:e912 with SMTP id 5b1f17b1804b1-4bb5de1f216mr172834365e9.1.1794815928232;
        Sun, 15 Nov 2026 23:58:48 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e252f7fsm375768305e9.2.2026.11.15.23.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:47 -0800 (PST)
Message-ID: <aa32167cd3865049bfe0281b8b651c47f5e1c05d.camel@amutable.com>
Subject: Re: [PATCH RFC 2/4] sh/crash_dump: check ioremap() in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:58:46 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-2-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> copy_oldmem_page() maps a page of the old kernel with ioremap() and
> copies from it without checking whether the mapping worked. If it
> didn't, the copy reads from an offset into the NULL page.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns
> that into -EFAULT like any other short copy.
>=20
> Fixes: 4d5ade5b29c6 ("sh: kdump support.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/sh/kernel/crash_dump.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/arch/sh/kernel/crash_dump.c
> b/arch/sh/kernel/crash_dump.c
> index 19ce6a950aaca..85c0e58f1a59f 100644
> --- a/arch/sh/kernel/crash_dump.c
> +++ b/arch/sh/kernel/crash_dump.c
> @@ -20,6 +20,9 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	vaddr =3D ioremap(pfn << PAGE_SHIFT, PAGE_SIZE);
> +	if (!vaddr)
> +		return -ENOMEM;
> +
> =C2=A0	csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	iounmap(vaddr);
> =C2=A0

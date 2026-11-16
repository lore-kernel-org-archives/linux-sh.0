Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815911;
	b=5pcezJs8WxC0pMbxy+AFG7DWygvE2lvzckAQdXr95WN+UZoYP08UpNazw8xAi7CAJ3BH
	 F/us3U35INGt+8QnUwEV4s828x1VJLnjyQlMGQHS9Wql3gmWQekoteG5OB3bAqE3XExD8
	 n3Z/VaooZ8CPGGjbJCNOpZYreqWsmcjfJKFv0Zeckqa/SUtFaxk3Nhngqmq9Szk7yX8f6
	 Rd6Q9v9zzuh2dqzQcOCn+gw1dWRoGG9Y5ogrOnsCxqWumaSTN73YKP51JAsUC1X8d94Io
	 iQPb7vLwpXNyC2g097293nkSVMDhl7bUuV0so1Kgb+TEObBVY6hVyQQJ0AejAFLJ7XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
	b=M6qJTP7+sXoyw5Dqo8az5uu9q0RAhZhZInIaAuo6HmMt49eUHZYmHPUCu9IIchM2gBxs
	 1TYdzp5QEoS3em8A34liUtt2QMmtXOiHIF2Q0BKvzE8ROA9LI7Je/pEMn3yNES+l82KH+
	 TDprC5Z3b4YcGUPNXNP6k6/uqzNr84ovKL4hJYLak1Du+cEHJumCHf1biclsvYKxBAddK
	 gMkUU6ZidXNfjmHS4COFOr92XjjC+hMFsMPGRfsMhylHlNFe2GB/U77MuEqA37tCOhLvH
	 fMFcXOhQblLz84FwAuGK3s+ECdZaRsqH9AMn9SL1tsIfCwrEAUohLok+RK/pzmNPsaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RZwbcCo0;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99034606A32C
	for <linux-sh@vger.kernel.org>; Mon, 16 Nov 2026 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99034606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RZwbcCo0
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso1157162f8f.1
        for <linux-sh@vger.kernel.org>; Sun, 15 Nov 2026 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815909; x=1795420709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=RZwbcCo0a4gjuV18T+2Ucnw6jCdsWPKRC5LMIQkGS1u3K0j0E8r+eXQHgwhpFjV9Ns
         E4eQbhZlMF0oYosxibPqVnuTLzKDIZ56ygSzOKMLI0U3HdyWkdsGQRg4ffVVNprx0lNl
         3VoShnBY86Rw8ivEwPnvAve0hmIwWUhUt2ZoXiWAG5yImwJfbTo3xhtFN5I/MYPHtn4b
         enxL6PfWiyWc5q9d46A94egMlP3knZPlBbquGKVnCwHFNT5Fsl4ImTFxxiA9tP+r47o4
         8TQ7tud9tTBHlzYrfDmF4FaRvuovfFXjlIwl3BFIwbrGT1RvY+zLOzg32pd1vrPaiWJ/
         fCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815909; x=1795420709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=JGM1s68Xl8aTBLa8dbkKrpU0rDdWumR2rwBCZpNT0cHE+Wpjo+NNV0kaywpGxa+OW1
         kUF4/2l5VoaT8nDlFaH84oKMCYh/QEI4/KTvQG+KiVYBhfbrcX6b4tfRnEci8yqhzXom
         bhX8VffbL14zwhkWr1/+vUdUj8MfXJ81DPug9GFDVz+i+9/L8XLe7vxdRfhxR9IctpND
         3ljA3v/sES+K6y/E1wcL1jLFJWEaynBv56/YBijDdL9w1NXaDqAO2bx+8IP3+oOOdXtO
         mEa8d138aPrvGOFjiyhBwtoZk01F3zVeiOLknbiRwf2Btjx6CSRzG9w8FT87tnl2+36D
         4Npg==
X-Forwarded-Encrypted: i=1; AL+hErGtbDW9NqgSzZeKHtUk3Hx8i33rZRTREABn8KTwXa3CnbuHIYbNpZkxrXIIesf1EHhiWLXy0o4x2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/mBJN31NAX6k/39dHdaFNmT8nOZlzMALeB3+goo5gB8I4AaCCM
	tRTgqGUPGOSncoOKhojWLr7GW22MR/xacFvALKSfiMrQcDQhx86hLyXbaUYxCddyQk4E
X-Gm-Gg: AYBFou2mofcxl1i+PAhSD/nB62etejI5Gtpd+MrIuiW5yGXwYEbVqHz5JfO2ZMBO90U
	FKRU1T57SO8859R0ACMbQcOSJGPjlTBGP4Z3q+0L7a20PT7SKF76GT2v0xOhCG0OCdFPRkw4box
	kL8s6tPCPXLQVQMZqum4XlexS6uHtuZNO1YBekmYoQDuUPg0WB9gG18gEOaycCMLR243ca1DYBd
	AV2WYW5yQk80RWSSE7LkyE7VBsS+7R+5UhKjAvOrBrSGYEG9SETMR5Ha1+Cqu2XDObADHRodsND
	yRjXpLbSJSjhy0T1TPreB+bQnYI4yCx4YWF7e1G/ScjsmRr/rFf7qgDWNQFtW7cjIDSoq2Jz3sM
	5XS/bAo3WlsS3cMLw8LjTUmenjt5UIuECbLBnSD63UUwK2AUROnoEBProlYN8TeiQqc+chuf/2j
	HiEvigv597pZ7x4c+6PV/pbydw42mOTLbWbScVaoFsQldOODwtYpgu9SGNUmEjHx/wufnSZHzrk
	heCHKDgIbrQHKeKUO6eu7cHtQKcQO6MjLIJX46b5vezWpf6Pj1ksr/pjyu/ioGjgrCE/If7AGuk
	tCAIRzhgj2YjV16NTvdczwL4YYDeyDlvXvRB05Rb6TkBV/8t3QDS+BOJaPSJeYA=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20084703f8f.45.1794815908942;
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm21124748f8f.28.2026.11.15.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Message-ID: <19b4c35c016a91302bf6bc3380bfcd3d21dc50c0.camel@amutable.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
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
Date: Mon, 16 Nov 2026 08:58:26 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
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
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without
> checking
> whether the mapping worked. If it didn't, the copy reads from an
> offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 103b6605dd68f..1543917bd3e1d 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794206595;
	b=nmNU0pj+iUSF5edEJ2/7t0ULMocE0Xlj1ZR60KeaP9n31yDHhUDFKhtvFaz2xsR45z/e
	 wg5F66yuovUoXDX/4MafTF5GHq4/LSSLv0p+4/6syUnGjMRa46z0UeKwUUzT3DmBIiMnQ
	 FM5ct0Pq62fZzUqB1jCq16ITI1Jp6BlS8CnTAtyT26g/Uz4QNhLJElzgxh11jfuaEQScL
	 Bg24VJizFvKKtmsD4/T2jQ5g1V/JOHv0cs4pWVSDyMtDyVSWukT3R25yzpxvRm/nGKwY4
	 wnSgUfII2Fhg0iOrCQd4ITArJJYcPfCmw6La4u6H+i8g/QrW2PtZUr6lmE6PM8LUc4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794206595;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=tGiqJehz9vlDJjRqUxMtSemUKCzN8Z0XYb7DwbJHD5Y=;
	b=PH5/3jzL56sRJfxDPyh+RwY9QFfXPwqGJvQ+sEmbZ4rv9UyEqRIb5ekdH3P5JMcEoLoa
	 SiHj1Av8pvZiShL267VTIONr+JOz1wJ+6G/Iu7gWtgstryXXDI3fLXm5VPjzz1UpRL1DE
	 akyVRA/DlEQvCESI0KUErwWySZzAI8z3CFN5o2vGQHvp67sPgINyhmqQHFMLfDL9ZyEwq
	 w5OYmCrz+r/DYgqUUD5kTbm/yx37UJZpwpuFp5wqJvIeFjdHBe27jqxbfEgVU24l2ji+Y
	 8ansU00xhtDhDNiUltQPJrQhuWkBmz4UbovKxcog231oJCv/2EW86W4EfXE78hxnL9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vi4Fe1wL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8031606A321
	for <linux-sh@vger.kernel.org>; Mon,  9 Nov 2026 06:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8031606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vi4Fe1wL
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91e8a05ec5aso5793926d6.1
        for <linux-sh@vger.kernel.org>; Sun, 08 Nov 2026 22:43:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794206594; cv=none;
        d=google.com; s=arc-20260327;
        b=gg0sAsmgQF7xhoecOqnDAUDyB5CIlAuAGFNdYsu5roHGnI17HelSfkzNbAcoQ79TVP
         LgDo6k8O4ijiNRe34Yww+GSQ+x9CtR70eyuwscmkM1k54RrAw7kpmEFhDsCeFEm62Mrs
         LO4g7cV7vSGm8JmfNp8PRqImT/SYDyIUXKSnTzWSBPOTYV0269pezi3KfWuRn6K9oTVG
         7rPoRUmZwk8Q0O5bTgYkhZZEZZ6bV0ml/9u8EtQLneRwO8tb0DlYSoZqHQMctO7XZKHc
         C5aSVJp8dJAg3SSAZDBCRd/JIgKDgGrA6z0zVVXEoTWLu2DpUecc1IzuHwf398GQN/Bz
         fbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tGiqJehz9vlDJjRqUxMtSemUKCzN8Z0XYb7DwbJHD5Y=;
        fh=nI0Els2nYq3KAno0DivxJESryiLlH/ymIieODASnOz4=;
        b=CBKmrqjMCVAnjCIcLf1BjhENIgnizBqEM8zgVvWLuGr+SnYHy5FeAxYW13WXB733Z1
         cKAwfMmTeDuWkWIdx58+fznW5jXUhqy2YeE/i5kRvRKQ+y1O5pLsF6le9NVmAUl0ropN
         KVHlmNRWfvwX6nUQjfG4isAgqGQ1bJJURI4tYwCtqb/wKRjZcXUWTU5JJoeUUaaoyVmj
         Nn/x4MdBNFRFUaGF8yV0+spBvPAnEnecW9pj7PfmZvv5bwxcICzCEHdSxu+cWRLQVMb1
         jA/atFSEz/PDYd2/Mq9Hulb6tQAKbJDiS69KE0pYJSLxurRL7zzdBFSEcbWyf6yY52X1
         69XQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794206594; x=1794811394; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tGiqJehz9vlDJjRqUxMtSemUKCzN8Z0XYb7DwbJHD5Y=;
        b=vi4Fe1wLkstDU7Fx9icdebeqSJimeOKMFyLHwwHCqPaxFzkTulFJII/dBCyoR64nsZ
         8Bf2K60OOcJtd7ZB/9JVLlbHvyMPGse4j22JD6++wQYRtaAUaZTMLOuGV3LTDKZ/GuX3
         S1foJxRrgUEqJyurx0o2IKPkW74FB3QX24rsERMkqJPmb9ZtoMGbl3G/mvU4EysLs3wj
         vyQZwVkNViuakoXCwgOSPoDfNYfFIoT+vYWkpfJ8sBymWuR27p0S0xEZVR/MdI0E1HQk
         NyvPOS1otMiw14M2IgdxgOCJE7eDJ0bN5mubKfLi0GpMvRLFyDvghi6B/Smgh1n+c9Cc
         k+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794206594; x=1794811394;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tGiqJehz9vlDJjRqUxMtSemUKCzN8Z0XYb7DwbJHD5Y=;
        b=PSh07GQCZWfEAkz9Vzw8AwI0xUQwN3FyA50K62f/QJ5GNbJH/aot2yoiDrXIRmBOA3
         6+et45L0wd4U49Rd+Io7LwAnskgt6k17rFEHvUub3nkSgcd7Z4GQpObzjUrJtd3jwwec
         Bq+gpfrrXI3MuJv5lm/DmaEZBpOY0NnZYAJ8zNgJhZ7cA9SsYxtdBWepAanQ+qYMHd4z
         SzZMvWzmgV84+a/HuuEJdIZAYcbIMCqt2PCzqxTJB7NRivcA/yRkqfcSpqfstcNbkuT6
         8daDRE5EmGwVR0lYOb+NzxBmKheQKPq5Zp8F00t6MaT87qbsN4zv8U9wM/AasPy8ErPM
         5AIA==
X-Gm-Message-State: APuU4Z86SAHMv1RBuhFWKQLDUPHh2dQSY3sAUmDYnePky3y4stIwbqy0
	QvCzKv0otWW0Z2gAH6ng3+BBOl+6lqcGjc++OiJA3z3NpAFtLsl8ZPkvDO8XXTNDzGEZzR14kFK
	HL7pgfErrA/9OYdh62M38IVb0H8BZyfo=
X-Gm-Gg: AYBFou1pcKo76T/dSDvpSdlYPY9Lvn1EXx2DZIUdEn5XyTH/I8L7IKw0iX0uy5pidF3
	JVPTUqXrAmQGGhMtsL1WnX2T7HhhIiInYL/dgexG/thNF4RpeQHD+8ZnPDVVXKTfIMoO4NCRc8e
	x4tB6WxVYguWpgDeGCDAdyFuVQrHT2nJdMl8NRRQYLNYFdicKj35yhrAav8cG3kLxnev4cnHEXD
	cu9SAfSh7dlED7A5LAWQZIa8JGfU2DdjG5Az5INPv0JslnEDvSZxj/z8aQ4VGbs1wkD929Lfa4L
	CgBlZ4vYsm0pOyh0ySKI8+A0+tY79iHkj9H0d/QPIk/ZEv2+WVPM+MkfGCQYmg2/SgrTfvsFYr4
	KE1JrHj/8JUGE8EyPy0wdba3eyhhFdj0wQvDrrsmuxiTsm+MDBwWMO9tRcw==
X-Received: by 2002:a05:6214:2489:b0:91c:78cd:3496 with SMTP id
 6a1803df08f44-91ed245a9b2mr50051466d6.30.1794206593593; Sun, 08 Nov 2026
 22:43:13 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261002041220.133911-1-artem122novak@gmail.com>
In-Reply-To: <20261002041220.133911-1-artem122novak@gmail.com>
From: Artem Novak <artem122novak@gmail.com>
Date: Mon, 9 Nov 2026 00:43:01 -0600
X-Gm-Features: AclHuK9v-5gRSO8OGt-F7FiRMlEeUolL0hWii1BHBqbgdOMwe1YNlabS8mDmnQM
Message-ID: <CAPufuhaE=pg9yzqZYaDcfkxooZeQPzSNsKQw-kX7PHN99yZyQQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sh: add initial SH7305 CPU support
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I wanted to follow up on this patch series,
as it's been a little over five weeks since the v2 submission.

I'm happy to revise and resubmit if necessary.

Thanks.

Best regards,
Artem

On Thu, Oct 1, 2026 at 10:12=E2=80=AFPM Artem Novak <artem122novak@gmail.co=
m> wrote:
>
> Add initial SuperH support for the Renesas SH7305 processor.
>
> The first patch fixes SH4 compiler flag fallback handling for toolchains
> which support SH4A targets but do not provide the plain -m4-nofpu
> option.
>
> The second patch adds the SH7305 CPU subtype, processor name and CPU
> probe.
>
> This is the first small architecture level part of ongoing SH7305
> enablement. Platform specific clock, interrupt controller, timer and
> board support are intentionally left for separate patches.
>
> The SH7305 support has been compile tested with GCC 14.3.0 targeting
> big endian SH4A.
>
> Changes in v2:
> - Use my full name, Artem Novak, for authorship and Signed-off-by.
> - No code changes.
>
> Artem Novak (2):
>   sh: guard SH4 no-FPU compiler fallback
>   sh: add SH7305 CPU subtype support
>
>  arch/sh/Kconfig                 | 9 +++++++++
>  arch/sh/Makefile                | 2 +-
>  arch/sh/include/asm/processor.h | 2 +-
>  arch/sh/kernel/cpu/proc.c       | 3 ++-
>  arch/sh/kernel/cpu/sh4/probe.c  | 3 +++
>  5 files changed, 16 insertions(+), 3 deletions(-)
>
>
> base-commit: 551c722f40809618230001baccf219193e22fc5a
> --
> 2.55.0
>

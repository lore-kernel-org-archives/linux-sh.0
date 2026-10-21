Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573329;
	b=wQUTyZnWICjcs6cF11hdb3g22XGoruluTlNhhNTW5B6DZ7xi0AOOWb4edAJO9vqHVB4n
	 +xBCfsn4GO0klaxQfds8u6rBWgASPBVE4pmV5Og5Wql4Dm9+cwYHBNAASna6Sv2kotIHJ
	 UMJGHBgGBesPzBXUkrlcQ47Q75kdofxHs/6SYLmcdx2FLJ270mHWxp4P5REzkRuFIZGsi
	 xwTyuR7GPecGxpAh2ZF3n2v686TpTkyybwZrDru9u0IALCXEWQP5oaXmUTA0wbQjpg7oO
	 UbpffgaKqVtl60Fl+/1dbnYYYsE0F5vypMJr3ybxe0c2PYNxAJHMhNlS/Lt+4ttDw5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573329;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=T4cci4gJNuFTfolxn/J6fu+B818vlNle5g1andJTAjs=;
	b=J2xW8D+mbtfLwS6SACxQ/UrvEStWJLPlLZYoLIzLh2B+lwlf3AgzinAWgkkN69Jon64p
	 W9brZsVTH6qGcmqh2hLAxjnlWgphNSsF9cNrEnCDfSLNXEgfHl5eqgeRkfiZoZKE43dV+
	 +3RaC1pEf/AYcjobqEBUeYtBdYseNIivlkIPlThr9ZK1/ZUSVkXonXJtBY8jIzxYE/xAq
	 KUN6DnaOUcaWXZ4cl+mFuzSPXJ2k5sQjJb1SOeFiMAV9XCwoHYAbgTrxXVz6YaUhBpKZb
	 gDD8EMelMeBRZLLr5ygYRpvgzezsPTWW70ePPPiRf8P2OStZ4SvdxQtzyEt4X1rP3qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC871606A31A
	for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 09:02:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC871606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eac01ff101so154020e0c.2
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 02:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792573328; x=1793178128;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T4cci4gJNuFTfolxn/J6fu+B818vlNle5g1andJTAjs=;
        b=DB+16vGGPmANV1wlMdh2dHEmpN/pEC5Fw70WTx6oE/+JDYCp6OE9I8vYB3HtvW88q6
         2cQNIjN/NyaSXkS5nzQBuaNXsxywAAz5RUrzrKp3ky/K0Kjg8oI828bOTrhwKXvUpBxy
         6fBgwTJLTnoZFdeYpZ2na7KN3s9MS0NLq5qZ9C6Pl67OWiXqja0evaHtKW8gZyjc7S/t
         YO4z5yJasPGcWwa/yN+BPsnrXTUUscjkUJU49PgRu5atvCuTNqurNNAKg0yvJdxfLqUy
         SNWofkLvbRRC90gGxYO8wBvkCP++N7Mn8nnVjm2QZe96xt0rqG0vC4RtTWmKqzBThnUJ
         IYpw==
X-Forwarded-Encrypted: i=1; AKwUvByO5iRxW8abzvfZVXu1CD2D665SlErmU80l7j2gez4SM4dgS2xYNCPLPU4HX45T3YDHJuXi51viVQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI4+0HEbsi9k/XhOxyHNuOcwmjsM8D1PMkuKFoUnLqbyQNKk60b
	SnwW7GtNI18jxkgFrNLIPwYaHxaRN4L5RGApj+anXtsL/xr86+j8BPtaGfP6PsbUgwc=
X-Gm-Gg: AYBFou2pty6czBViQesks6vV1obXU/BBHX+PVB/oMJwbFHbsb8TWsaYECT18M/KLO11
	p8YGYM8DuuNWxmrmxTmBFlSJL2GM0sKl7FesH7lsx7mQx2bgRIV6ki/9ZPEhvokGee3KI4hAN4A
	oH7HtGrBJ8tMlisRmZLbwVnPohp4FoHUaGQ5c3IzgfVE4QistReVY5z0cUM0OGyTZKu5H4pTHoZ
	exuNkWFTIQ6B39H4UN9K7AG/dftcoJ0ccy+5FeI5Kf+LI1MB6P69KiqLEqVawTxSUBJ386SZ6K3
	R31lbqdjd/svbTbKLKyuZI1W3uxu0ujDopq2lkL02VIBvu6YEuqJCoXhoVCDfoBtnpunKYw8/r3
	SBLa32iyr8YZU/B5Yjfz8GYsNi0bMIS+UDY9xIpP1qAxxFFu1vnVBUA75vQjZGxSNopjyTcoa1/
	sfXaYD/Q5KKBJeczH48f1DR8/VIsyHFQhsJWFrKAOfjcBPngV5OoBDdDQ8/0FoQIVhYQNenHtLD
	SRMbI/9Dncw7m0h5VvMK3X3nfnNDFhvfAk/3F5JU5PZY8Fdtj5DKKna60IWdlE1zXJlSvy0QAz4
	ALVtEPoOoX4mpw/+J2555g==
X-Received: by 2002:a05:6102:4426:b0:7c3:c0b9:9031 with SMTP id ada2fe7eead31-7cc9280f397mr394029137.36.1792573327826;
        Wed, 21 Oct 2026 02:02:07 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990d108ff73sm2388449241.7.2026.10.21.02.02.07
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 02:02:07 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eab93a9862so120009e0c.0
        for <linux-sh@vger.kernel.org>; Wed, 21 Oct 2026 02:02:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxTHKszoPCZY1Lnbf6zttEGHhNE7BY1LsLyVhrdHcEqyltU40w5UvjlYXmJ8OvvOnUMCA2U3u2Qrg==@vger.kernel.org
X-Received: by 2002:a05:6102:3709:b0:7c8:268:ecd7 with SMTP id
 ada2fe7eead31-7cc92739b17mr365886137.23.1792573326757; Wed, 21 Oct 2026
 02:02:06 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017041419.311921-1-daniel@0x0f.com> <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
In-Reply-To: <CAJpaz4abKAkDznoi3gczYHNQMF-j5cSajtG07Jws8LkFY9DZFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 21 Oct 2026 11:01:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWZTwfbXqV=oiaSseGXZNKzWD-bptZVuhbCnXwkt7+WoA@mail.gmail.com>
X-Gm-Features: AclHuK8GyFWJnCZctU9cyAk5_YSIDGkWTC6HLWIJClGOfTDRGxXReM4AFtrnhJk
Message-ID: <CAMuHMdWZTwfbXqV=oiaSseGXZNKzWD-bptZVuhbCnXwkt7+WoA@mail.gmail.com>
Subject: Re: [PATCH 0/2] sh: Fix IDE on landisk
To: Colton Pawielski <colton.pawielski@gmail.com>
Cc: Daniel Palmer <daniel@0x0f.com>, ysato@users.sourceforge.jp, dalias@libc.org, 
	glaubitz@physik.fu-berlin.de, dlemoal@kernel.org, cassel@kernel.org, 
	linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, fuchsfl@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Colton,

On Wed, 21 Oct 2026 at 03:05, Colton Pawielski
<colton.pawielski@gmail.com> wrote:
> This is my first message to the mailing list so please correct me if I've
> done anything improper or non-standard.

Thanks, LGTM.

> In testing I could often lock up the board when transferring data over
> SSH. I don't believe it's related to this series and am fairly sure it's
> in the 8139cp driver. I have a candidate fix that I plan to send in
> a couple of days once I've tested it further and there's no more
> lockups on my hardware.

8139cp is udeed not very reliable, hence nfsroot didn't work well for me.

> Tested-by: Colton Pawielski <colton.pawielski@gmail.com> # 3x LANDISK
> HDL-U, ATP865 rev 06/07

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

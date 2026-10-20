Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481879;
	b=n7vwosJ3y3Q1+p15yYYsR0Txr9uG6uOoyTS+xTeIT2LP6hwQDZxtFCd3juIJ89vKx+Y3
	 fGszABfqFz2tyvqwjFyswKfC9B4ZK6PsopNMS1j4CEgoNSTkOc+a/NmbsmXSDnRoYAWsV
	 q6F5LuAHmVgo2t9Xbkg//vAr1r3ufQ3HF7aEaEROUXIn4Q0p6HfrZh7GFofnrKYZxMw/p
	 mvXYfNAHJu2G2MJDN8gRW/RfOnxD6CNi6zAo0wo5HK0ZHbrg/i1tpPJBj/hI6vAR2L6qA
	 xIb6FcdSzd94tHcGyPaJuEDrTIYBtErlDio7B9Hae54/yoVu/tsNUQuOCNP5nLqxbzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481879;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=Zq7cup/EEnmM0+xPfq1niB4PtS0YUNMITrofWx3Yyno=;
	b=H9WrzWJfL4U2bsTasaZ2OzuPz+cVbDe1kMiEPe3AyOQJz3FExQxyLtxE0itrjImZ1/Ay
	 J2K6wxT7UMNF4Z95+fTuhtZ+CkBRFZ2j5pY64P5yXVRZEbRTTLeJUd5y5poCcugCGTD/f
	 2IyfRzDv42vOb0kkdVH61ui0pjdDzvn2HRuany93glOYfl1McQbMftVcxtOAyoWfBVMIB
	 LUvw1KXPLqArDNj8lZNS3lb6Te4ix1+qpekX4xLCqB8rFZ/oe60YUFl3nP7cR/rEJjTn0
	 yUeid2tN7FGTh5PQIr75qSC1HObzTDRCYkYpGYv6cxFx4zq5+QmlR0VaME6yAhVbMSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.48
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056DD606A31D
	for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 07:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 056DD606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so2038350241.2
        for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 00:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481878; x=1793086678;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Zq7cup/EEnmM0+xPfq1niB4PtS0YUNMITrofWx3Yyno=;
        b=1b8W4TUFf7/E0IMrraHNY60rvDOND1IaO/cDbT2BqC2VWlvsNwO4FWVYQbM1nJoH47
         6EQYFukQRug9Kma9LuHuuMloKsbUoOSmtanfrb+mcUFaaQCsKxbQteosaFnRU4nNZkk4
         tFV7X7bha5wdhz4TfGaJxEpP42P8BMlK9dj9gzFMzcpkKPYBlY2oKkrU01AqHPXTS/52
         bpy2mwfZkcGLJCqPqRobs+yeKkHrc71VogHA8pH/ylu6bGH6DMFBBekfpF7u3J+rDhL4
         dGiad6HwopvEpDBYrl9LCfDTzrQOKJpUe1c5vCcElu1j+S0mZcLPURhPijUrVZONvBPd
         lgOA==
X-Gm-Message-State: AFq9FYJxMpI924c3vrZ/nqgUEcgUHGB88+4tNUqU/C6s3rYaRnZxDShu
	Qs8VmxhsFON44krdFzqRYIlu9Sm5M13YbcnlyBbvBNfFS+pjqalC0n8ZqB+3+K3gfZk=
X-Gm-Gg: AYBFou3d2MWrhAV7AuXx71OGO43f3Yl+uro1uEYKXHUNH9QOvjjfqgV0WS6edteyuUM
	NbP9h7Gl/p4hjpIVhq8r3IWHdgUnw34iOnNASQV+HzDYRdG2Dn8qsh9rOWXPzrTliiyfSHsEFiX
	D7WPe3pwFTt0+W21NTIwG+Y9S13OdHnKcZOAqHR3oov/8IMyczr/Rgez3URDrVrVVJL8W7XslGK
	N7ufYyetzTNkpO+Pf1UQM+3W2v8R4e4OsCHvEESQeLRfA9T9dNQZ8VylZ92qNRTiy0UYcNOburB
	2bdpTcgZAyQBdkSqA6wM30APFSu3OKY/FU3QnKHC4gZizRoa9KS1EHociGdl4BrmB22JSZB05OU
	5e1baRWyAAFuZs3laGmeUUIVs3Zh6Hl75tE93l+lRV4G9dbxabXPuoRGEjUydUCtpBz6PczEJvm
	Ys+MhRonMSgaHEQ8c+E6/ZUwUOi0RSGlCDJBHg5gKoJQdW2EhjQl1gU/EopVbttY9PzpLzsCjoU
	rPWWfHndfhyeR+5rBT55ozqvMYNb1uJjusnnVW2PlA9Z5JrGb4=
X-Received: by 2002:a05:6102:3c92:b0:7c3:2168:d603 with SMTP id ada2fe7eead31-7cc364a27edmr3176793137.0.1792481877812;
        Tue, 20 Oct 2026 00:37:57 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc7722e6fasm2098009137.7.2026.10.20.00.37.56
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 00:37:56 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so1709290e0c.0
        for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 00:37:56 -0700 (PDT)
X-Received: by 2002:a67:e711:0:b0:7bb:c382:2ff4 with SMTP id
 ada2fe7eead31-7cc369a4760mr2781283137.20.1792481876535; Tue, 20 Oct 2026
 00:37:56 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atbnbO68dvPSW5bI@waldemar-brodkorb.de> <CAMuHMdUCTOxqwHnh0nnQOntSLq+WEXdZ0KubV89sfz33wufgbg@mail.gmail.com>
 <atcWXCw-LNI1D-Ew@waldemar-brodkorb.de>
In-Reply-To: <atcWXCw-LNI1D-Ew@waldemar-brodkorb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 09:37:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWKe-7jn6YUjMtQFtxiDyD8SJTuh-g95_n5nihkOkcgEw@mail.gmail.com>
X-Gm-Features: AclHuK_VeTDGVIm9P9CWGbqX7_aQIP6T0Rb1qlJh6769B_VWPTAWTqKLQlpvY8I
Message-ID: <CAMuHMdWKe-7jn6YUjMtQFtxiDyD8SJTuh-g95_n5nihkOkcgEw@mail.gmail.com>
Subject: Re: [PATCH] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Waldemar,

On Tue, 20 Oct 2026 at 09:21, Waldemar Brodkorb <wbx@openadk.org> wrote:
> > On Tue, 20 Oct 2026 at 06:00, Waldemar Brodkorb <wbx@openadk.org> wrote:
> > > binfmt_flat offsets the in-memory start of the data segment by
> > > MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG_RAM
> > > binaries end up with a gap between text and data (commit 2217b9826246
> > > ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
> > >
> > > SH position-independent code finds the GOT with a PC-relative mova of
> > > _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2flt
> > > lays out the image. With the gap, the GOT register points below the real GOT,
> > > so every GOT load reads the neighbouring slot and gets a wrong pointer. On a
> > > J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
> > > In my case the data was moved up by 0x20 bytes.
> > >
> > > Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") added
> > > CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> > > tolerate such a gap; currently only riscv noMMU selects it. Select it on SH
> > > as well when building without an MMU.
> >
> > Thanks for your patch!
> >
> > > Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 6.18 and
> > > FLAT binaries built with elf2flt: with this change the data segment starts
> > > exactly at the end of text and init runs.
> >
> > V6.18 is getting a bit old. Can you please verify on v7.3?
>
> The problem with Linus 7.3 tree is, that Florian's patch which fixes the
> compile error with nstree.c is not in. Or do you mean linux-sh tree
> for-next branch with Florian's commit eb549e808390eeecf07618b8c3a82a6f2a887e70?

Sure, you can (and should ;-) include fixes for other issues when testing.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

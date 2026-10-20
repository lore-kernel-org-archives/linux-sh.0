Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792479465;
	b=lZtmoGjblxYCMQk1dt0w82bo66ElFthc+hBUvWFfCnOHsoYBsNhEBZSv2+MYOMQ3MhOp
	 eBuz7mNVqHcPb8RnGncZ74LEZYrVdb+y7aMMfK3NYBjg9vIg/ielE3TTQ7oA8Cfie7e9d
	 +zbmcJLXNqss9HANtxAuFVANO7/CzpyV0Sefms7zj3Mq8W3wWy/oZvbIn2MNd5PdCrM/m
	 TWpo8pGMapHuHkZJxOmRKGQqJm+5Ti3S6Fwzo6gND/PUeduI/bAO3DCVCMsUdGRf5DmAp
	 MeL7r5P7t2pZ1ICHdAtbPhyAtTHtj+XTyYoogHHov9enwtq6cUihmAWKbm04unWS4hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479465;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=BCe5L0YHe6xgNEuUR4Xy/XLhpid4xmQMAQWm4jmVg1M=;
	b=MoR0wzfMN1Mm9YhV03N0tPjY5s8JfgXngPLqWbhGGaXkVxogXd+58WBvGYjVzCqPwodu
	 4goFzoUnW/WJIJE8Sm9tRy/oxifRwzJvvtrrbYWSBDk+UdlJLrN3R8Wx1bL+GtMwW/FTP
	 9ZXyarfErFvBqwouNkU3ew3vspXM9a1CM8vr+XxtzPT92uSlu/QRkjTdvh+mtQk+N26Xo
	 XifcuPq4sSgP+caUerYHdgdEDxhvJ79KvyFD6fHRHDcTVnrVxR8fp2y0Xq0hBvSz2mRAF
	 uSzuQAxmYlffGhSNSad3pPNoA+U6kZWtAyg+WhHg6/z1cLIGnbIr6smwHubUOOsHK5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26B606A32D
	for <linux-sh@vger.kernel.org>; Tue, 20 Oct 2026 06:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF26B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so306762e0c.0
        for <linux-sh@vger.kernel.org>; Mon, 19 Oct 2026 23:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792479464; x=1793084264;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BCe5L0YHe6xgNEuUR4Xy/XLhpid4xmQMAQWm4jmVg1M=;
        b=dYToMyEMgreoK87G6X/Pm50MiZK/m6ZszaEaz8TiOgPDgm8aypfeIdgYC9hy4Cgd49
         RMSUZq5Utkq9WS4thGuT6ct2lQKBABPKoVOYvUBtono37yeOAvvtB0pkK+Rgs2uGsHOO
         S4VhQAZpMX1chtsgvyu1Iov8C7o84MQjCS09suyPZJuNPn+FgYJ23do2PW4v41IlRqQ9
         Svy5OGk/QwzYG0P9rOkYAtbspq3nd6511RnoRyXzRfGinLOiLVIpEh6Vj9rCY23PHzWt
         5JySnytJIWhh55V7K1xTK4h38vxQXBRLf+voUwj8790+f3GSGp5xp0/mbSoNV/WouCJv
         cHAA==
X-Gm-Message-State: AFq9FYLFQqC49qRB2FWhzRPPWKW/M6yxT46bLQb1byE6LhlYxGbQC2Qm
	zo2G2I0slvS+clcG+gQRETK9EN9i9EkS4Rq39uyowHBCfpmEFZ0pnTo8r222Id/VQzs=
X-Gm-Gg: AYBFou0Mli65fffsFh0dtD4E7jPzruAOKJZErVlkoqonUK9CkdnC9KhM//FsjePdtG+
	bzAN/C3j7fQHEoJXjJXKmSRHV1UzbUAD4Abo3B2K1qMRcKp6YusgSJs1fJ5kGk1/SML+DZNuRIX
	q1h7JsSZpLPPGNNS33PrLQpxkWqo+dtt+v1IlesdX8LlNxg9z6yJ6h7NS2nGItX8NKTF51S3eNB
	S5sMrH5dDzS45oMRQNc5lfibRNKBG+ybflyOMIBt8fT/b/LFmBIJnObxghqykREk2RqErCA7Mkq
	ftnnsUFS9zhFzfKrlokS2wHDXBC6aghJ5zwhqqGa+zVGxtHI/AbtZ6C90k+pysxYEyJnR+tPn4L
	jp0x4nOw/VdIzP4KEpXaJ8B6HCn/BgF5jMKRevDEL6pNJZyT1JyTJWuLMVpw+dW0LKRYCksZZKP
	Ocd4nKNXQ7N5zweIstlS/C+qKtSo1tnrUEKG7kGdDk6VR8xgclUD4cYNdkfeHsc/YtRxJ2o7KCV
	tpJmZ27wvp6q2H2pzsW5qHM19/Ipcu2sw9DsOCnTubDFFc=
X-Received: by 2002:a05:6122:25d5:b0:5ce:fc2e:d0e9 with SMTP id 71dfb90a1353d-5eadcc47e3dmr214971e0c.13.1792479463661;
        Mon, 19 Oct 2026 23:57:43 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eac20d6aa6sm6422443e0c.7.2026.10.19.23.57.40
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:57:40 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-9909e82513fso269856241.0
        for <linux-sh@vger.kernel.org>; Mon, 19 Oct 2026 23:57:40 -0700 (PDT)
X-Received: by 2002:a05:6102:6874:b0:7c2:526b:991e with SMTP id
 ada2fe7eead31-7cc7bb8929dmr223298137.14.1792479460568; Mon, 19 Oct 2026
 23:57:40 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atbnbO68dvPSW5bI@waldemar-brodkorb.de>
In-Reply-To: <atbnbO68dvPSW5bI@waldemar-brodkorb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2026 08:57:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUCTOxqwHnh0nnQOntSLq+WEXdZ0KubV89sfz33wufgbg@mail.gmail.com>
X-Gm-Features: AclHuK9xKroWKI68qeH4OHGJUFH-A5VTLHZmmhK2F9uOwp09yTvF9NWs411maSo
Message-ID: <CAMuHMdUCTOxqwHnh0nnQOntSLq+WEXdZ0KubV89sfz33wufgbg@mail.gmail.com>
Subject: Re: [PATCH] sh: select BINFMT_FLAT_NO_DATA_START_OFFSET for noMMU
To: Waldemar Brodkorb <wbx@openadk.org>
Cc: linux-sh@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, 
	Greg Ungerer <gerg@linux-m68k.org>, Damien Le Moal <damien.lemoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"

Hi Waldemar,

On Tue, 20 Oct 2026 at 06:00, Waldemar Brodkorb <wbx@openadk.org> wrote:
> binfmt_flat offsets the in-memory start of the data segment by
> MAX_SHARED_LIBS words and then aligns it to FLAT_DATA_ALIGN, so FLAT_FLAG_RAM
> binaries end up with a gap between text and data (commit 2217b9826246
> ("binfmt_flat: revert "binfmt_flat: don't offset the data start"")).
>
> SH position-independent code finds the GOT with a PC-relative mova of
> _GLOBAL_OFFSET_TABLE_, which assumes data follows text directly, as elf2flt
> lays out the image. With the gap, the GOT register points below the real GOT,
> so every GOT load reads the neighbouring slot and gets a wrong pointer. On a
> J2 (sh2eb, noMMU) this made userland crash or hang right after start-up.
> In my case the data was moved up by 0x20 bytes.
>
> Commit 04d82a6d0881 ("binfmt_flat: allow not offsetting data start") added
> CONFIG_BINFMT_FLAT_NO_DATA_START_OFFSET for architectures that cannot
> tolerate such a gap; currently only riscv noMMU selects it. Select it on SH
> as well when building without an MMU.

Thanks for your patch!

> Tested on a J2 board (Numato Mimas V2, sh2eb, noMMU) with Linux 6.18 and
> FLAT binaries built with elf2flt: with this change the data segment starts
> exactly at the end of text and init runs.

V6.18 is getting a bit old. Can you please verify on v7.3?

>
> Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>
> Assisted-by: LLM

This needs a Fixes tag.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

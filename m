Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273281;
	b=w3Olu9kfEbgR0WYpjA0SjOOGsm5RWXUZL72/H3ho0lwoRAUSfGHzuaY+M8GyJxVs1/lp
	 TJe71kWgpLnDT+obrl64KKy6JtoY+9w2zE7VYG7lSTgUYwzM+d6xzKJT25HCYhdT3onfs
	 8csOaKeE3ajmxzd1Jhiy1aX6u1ry7K4GFIA4j0surf+QkYomoo8TQSmLdaGv1DZ7lrqVG
	 EhAwLRKTKnwb6cf9trSrUl3UscpDUez1wbYAOCGboNKFa6RjUAPn4oSkfhqVE3ckftH88
	 61HtmILXX2p5UXQHqJXK75z/c755bjFQRzUn2DpM7O+te87FvXkg9ahgCZWOgkVbXHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
	b=u+0LlZu+Lt3l+AyMgGyy5xCLr3cc8UxVv7ISpzqTSDI+stacTht4rFsC+uV2SvCgeWac
	 M4Ucj8zvYT3jFiMuGl6vkkEY9jEl0yGzuPK7uWD8/bL2hrPTlrJ7IA2weNaShogcOI1I4
	 BgEd6hAaFTWmRbpA0XW20M4X4kGgLJ8DrjGWcHVxmO9+WbF0Be2PsFzt3ASBN0nGjZV0x
	 ljZf0abAhkfQLq1QaKhzHcqhoFF+1mjTerdCeELaOCjb6GuYPBSlCNjEDHK9g/xlpKilc
	 I+mzIImq1/FcejI1Xf2gyHBxha6qoDBfE7mbBD9crKYiuu/+dvh61SYHj0/AKrjoRuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=c3HPZ9w3;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73FE606A332
	for <linux-sh@vger.kernel.org>; Tue, 10 Nov 2026 01:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E73FE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=c3HPZ9w3
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso10192715e9.2
        for <linux-sh@vger.kernel.org>; Mon, 09 Nov 2026 17:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794273278; x=1794878078; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=c3HPZ9w3X3vdF/+J+vaP+PQYAUd2+9JOKWwj6JMce2A8a3XTTDedjlXPO55cC45zjl
         2hZf2gArAaC7b2VANcAz9siQ8hXOL0yOpee0+28IQ4U11h71kiwdUMjW00TOftz1OChD
         IA4Fb2sqqSoZR8rQ6NvDOj7SKOizFmF/BfqF0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794273278; x=1794878078;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m2qXctBTC0OPADf0V2KkMb6r2GA0JgabIuFAMe6ERzQ=;
        b=Q20kcSgp0v+8ZhEdk7wY9Tn8WyI4I4QONNAAHckFcTyXNBj812+6iVwguCoV0QYfbH
         vC1S1MpMtT9PSJreTDb6rh+6dXTNqYHo6UgHsCR/S9FUzHP3CeCG69MUNJbw615vV/8A
         TEPMbzkwZag0vzOheaoukodkdjsRKTgNm+ZzWphYs0DAS4eYbhfEBAARPdUA1fHft5jU
         nV+n8nepoS22le4cPeGEMSS3FIQBV+kCTiSdmPhaDt+fV/sD+OFuVz0qbmyUiRP8ir+F
         /bsWOM5ScfzxhY0EJNDC52QChGkXbxCbQEE3ShgyKU4xiwGf71/Li9NBEOTE950tCI4v
         C9Yw==
X-Forwarded-Encrypted: i=1; AL+hErEvNERy6iQ6nOONjRjXIbDVPtYhc4vAtUGWX2ef7pJQxu/+d+R0Oe9shDsJ2QGFiv3qpv1QogoqOg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9d8o3nkg7HuCB7WQIGYfaQzIeBg9G9wHMJGdYYQPiHvxFOxyvy
	BSD7793ITbtl9ahJgn525IzLUGXqpyfD3+DFIYx+BE7n6GFfmdMh0XxJBseVZlrVAEZ1LQIIwu4
	ulgKGBpX+Jw==
X-Gm-Gg: AYBFou1zH6qWRRW98gnrxJ9x70z6Ahq4ntdVw4FklGd5tz+ARZfsXkGHfGZXieD0ml6
	coTXLSwZ+3WKw6r2FzAWvtJmGX6Ld4zbjxMfciPJznwjN+lDbYvCPcGSqyNTPpG7OnBSRft5HCM
	DSZ+f99RN9a3SbN0/8vc2DsCJYUMS0qXmCj46t8icKbA0pWPI2VXuXMdwzGsATcTAoGCNWg5K52
	DTs5YXlvcjMD1S7h7M3Se56ypxGOxtkJ2LIOUg/Riri+Uw8cUsWNoKCivSUxG9FdwLOgQhRVYBM
	ykbNnVTjaZ03LouQxDJsNMJzgHzBxrlegDST1HOM/GiDv0iwrZEinWET45extOrpvb1sdI0k6qR
	q0gVlSFKkDgHvGN+4opIi6rzZ6OKgxgbaVNJdvbB9ovj1zhVtCLxPm15Sy/k97xE8nBr4GjwZTZ
	RpYdl769URCS34MybCkabxBUXyON3ZWGdDdq40aGcWWhxzpyeuQigJHZDr4GR9UgnIkmwoGXltL
	W1rkvmzPxu72x7oWhruekGYs7iz19TKTF4gQWWBuTJI9e00pqBzrhkS6k1vI9fQwst9ru2lcAuM
	TGTGMqJKpgZG3zJfLq1mQxvRsZLDQQoI93T06fz9nGS3Y/X9Bz1qxTR3T+4HKGqLoHrte4DtGB0
	Qvg==
X-Received: by 2002:a05:600c:3e0f:b0:4b7:6b96:e431 with SMTP id 5b1f17b1804b1-4ba0234e39fmr13458255e9.28.1794273278466;
        Mon, 09 Nov 2026 17:14:38 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983600bc8fsm1829353f8f.30.2026.11.09.17.14.36
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 17:14:37 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so241841266b.2
        for <linux-sh@vger.kernel.org>; Mon, 09 Nov 2026 17:14:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEYBI24PK3yggClDFuKyeg8iys6waA2ivwqQpjkyIXwiMWZb708CANbtLiuI86Y4GlNobN9X2fv3A==@vger.kernel.org
X-Received: by 2002:a17:907:9451:b0:c41:1750:59a2 with SMTP id
 a640c23a62f3a-c50495dfbd5mr87253466b.12.1794273275844; Mon, 09 Nov 2026
 17:14:35 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
 <CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
 <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner> <20261108185953.28054fb3@pumpkin>
 <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk> <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <20261109214558.0d9d5228@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Nov 2026 17:14:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
X-Gm-Features: AclHuK-x8jcOOQUqd2amGoGEAKER9jIFGaeL4LxxWAd0cGV7dz_RR64PtDogpPU
Message-ID: <CAHk-=whsA3tKcUCBJDj_vmJ11rVGT9rivgnKjGRgMO21CPmCxg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
To: David Laight <david.laight.linux@gmail.com>
Cc: "Maciej W. Rozycki" <macro@orcam.me.uk>, Christian Brauner <brauner@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Nov 2026 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> Just that the cast would have to be:
>         u8 *foo = (u8 *)bar;
> where 'bar' is 'char *', and I don't think you need a cast there when
> char is unsigned.

.. and just to clarify: 'char' is always unsigned in the kernel on all
architectures since commit 3bc753c06dd0 ("kbuild: treat char as always
unsigned") back four years ago...

            Linus

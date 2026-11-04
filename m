Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823181;
	b=QV1BL8iTQBPyzZkn2sgqXsIuGoXedYCqDWDfh0hrvzaOGFBQulit18rVBalQ/0P+xqwl
	 oXT0L5TmTKKC4XkQZ/yodajRzjHayqpsZsdwno2T4jHBkv+KQUJJl4NfrL76vivCY9f3o
	 z+BDeE0tWQCtPX5jk4wgIiF/2fgbNT8ynEUnWfZJBPNpj+i8SseLaNOThq7f1inzTwSz7
	 NcyWbycuzuAnZGCymo69zKUwrpQ2bVthH4UM64p6kFw9UVkJxiv3ahibyx7ueuO3WO7iI
	 1HFsWfZKox82cjf7BUxSP5bgAC4LC7jPz1pMR5DesYwIHtqhTYILCzie7qkHCa2yjbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823181;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
	b=4hCgx6PZM1jKimFCKUsVFfyQ/iWs/ovSv9EgBIF05KhbCnETZC0arQ/jRZ+3sWS8HMaK
	 VDML9GP7FQ5eKCtN/RZwYtckIkHU+fJF6osJRhbLVcMHV4FMqrW0fCFZYumHPmxTUokcV
	 aISEbjN5rxP70siJDW4zTJAz9oB2ziXR06qGdvAVc7B+vakSyT5JIAFjtg5S4odhxTUFq
	 LMWAcPPn5RCzm44bjz4LC8DgQ5IDhA8DABxyYWclwIwiCB0/VaO9WTH6/Loh1Xx2XcEa/
	 4fv1Ze06LnDDpyb++cgF1ITMGefc1/7RxoSImXwPE6BxzLseviiPSqoSMnY9nUmnSag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=LuYCxgSl;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843B60807A3
	for <linux-sh@vger.kernel.org>; Wed,  4 Nov 2026 20:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E843B60807A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=LuYCxgSl
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso604421a12.3
        for <linux-sh@vger.kernel.org>; Wed, 04 Nov 2026 12:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793823179; x=1794427979; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=LuYCxgSlAFv9uOhCHG+o26suM4AAjMktrCFd7QeJ1fENekTPdVVSJnDFbg9rMdTZ5U
         0pgTR8rRyDmPiQmzICd2QoZYl+ISrWL8ZZJfLeh69jCpuffMiM38S6F5IQtnejzpkdfe
         uUerBTv/RHXIQAtZcjX7LlUHeXS64xelK/uUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823179; x=1794427979;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LCqiLHf1DIbfKNXx3ccWkvqxBhOdwo3yYkazQxIGarg=;
        b=YtVp9DItexnx0ohObB9VUuNE3YZ1DgV4sJmRMQORS/OylzUodh+hABl2FbcTP7JEfQ
         rhgoHuI3tiOnbbzJFwxNbSmK1mIWuZ/iphafeHIf1mUvfi1ouuUGXXynsnb5pzgkIgdo
         rCHvRUmnApRKnZyottAzLuu08ONO59nGaKvwckVJoswFqcGgLmnHhHhCrJkLPICkyyC6
         8N/66C5GacBE2iniyJdC9dfDsY1TrDaOQEdcaEAq1eCAhnTLqJD+zD63onw9g7YCqfNY
         ucRshW5vJvKVm8LwjV8y2Y0xCEtN/TrZYyYWaoM3SLbnYOQ9Ul2or6518UOScT1GQir8
         GiFQ==
X-Forwarded-Encrypted: i=1; AKwUvByeCiwv519SlVf9oeOb/hI1donwhFAduuUm6YIzK+tOdg7Plk5Ml79AXAa0rGyUi9O2VqBApA8Olw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/66SGB2udy/vvT+9hE3P5AcNssSUuwZZeUTQXJi8TLX/3oOzeP
	JtEWKxkddA1gbpn4/iYKcS7y3hvf/pSoion923HuHn8lI2Reaxp11QG3zMBs/YUl5rCjqnXQdLN
	atZtmfodFIw==
X-Gm-Gg: AYBFou1KuailwcP1QII9HtA2bWNAyHH4Io7nsJ2NYwto0QouVoXTG4/2WIYPsEj13sM
	q89XtMoVmqT7Y9NOFlN0ZjSNWrAitsuUHGgPLQERv8Rx0QeKgqUHaXnBY5NVRTtTcClWB2SFWrn
	ruAFxP6Edo4lF9d11ik1AizYzXwRXGbc/j56JLXDs/6r22GU/zTPlsrcu13syYAWc4MynmePGvZ
	uOVCJlIm65yqlB/faOu4odnHiAljj3KxHLWLmIPx6eMnkcAdCZdM4X6F1HtIXwGCuaKMUIYHzWO
	Bp0n6iglPVIjfE2hZBWavMENznDgRyEXnUjdEHNSVPb7p8GS8LO1a66rbDP4FeMYnRnOvxQ4F1i
	d03rFZuD8Qb2cohlHLcC+jn7dLMm+xxrwseB4gGahHnfgp/4ywpfr4Pic3tKGbNjr3BV9NNfS0B
	DYHDo0iTAQarLIRYC/643ppv0KV5lEjowwlv0wrUubFG3LBZ/bEfJd2yyYyZK+AnGiiZ511B7Fr
	GuHvUCChJxTADarFsAWkjTvcGOHT6E2JJPzYT5lDPXWvvkbdqVAgj8qWScknMvj5GCpr2acsXyr
	zceHnN2yVCG0fsYNr+dfAcyJEIMT/fHvhOgiSdanul2R1/Om27BBASpKy8/LEeXpQMtxA0UaD7W
	hkA==
X-Received: by 2002:a05:6402:42c5:b0:6b5:4892:dce with SMTP id 4fb4d7f45d1cf-6b548920f87mr5346679a12.41.1793823179411;
        Wed, 04 Nov 2026 12:12:59 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac94e8bsm1017925a12.35.2026.11.04.12.12.59
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 12:12:59 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c423b145922so163211966b.3
        for <linux-sh@vger.kernel.org>; Wed, 04 Nov 2026 12:12:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxlrTOwg6GJVt47/g2Xx2P8rHW9QyT2vbg9ZNGYa4WiIRLrI10cSpdQMR9IrSGMA++mRiLHKUKikg==@vger.kernel.org
X-Received: by 2002:a17:907:60c8:b0:c49:a4b1:9cb1 with SMTP id
 a640c23a62f3a-c4ca795fa50mr1973235866b.3.1793822725121; Wed, 04 Nov 2026
 12:05:25 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-v2-0-b45cd5789ac5@brauner> <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
In-Reply-To: <20261104-work-procfs-fs-v2-0-319e0f9a8aae@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 4 Nov 2026 12:05:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
X-Gm-Features: AclHuK9j_YIgrwhhpWOlnull6heAULBd4dgTqoOhUQQjFm_MgoIgrL1vgPfefvI
Message-ID: <CAHk-=wj9Y9NcOesBBm+jhPjYa7qO00fD7g7uwX+H-k0-R2difA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 00/30] proc: convert the fs, kernel and mm
 entries (Part 5/7)
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
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

On Wed, 4 Nov 2026 at 11:49, Christian Brauner <brauner@kernel.org> wrote:
>
> Part 5/7 of "proc: move procfs to what kernfs does", on top of part 2

Christian - way too many patches, re-sent much too often, cc'd to way
too many people.

Nobody is going to read these repeated resends, and all you are doing
is clogging up peoples mailboxes.

             Linus

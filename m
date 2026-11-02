Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642688;
	b=QhzPrSrBafJxrrLZY89OGKC97xeJoaOyO/WTo5vNucQjBU3pj2mvXrHY/rkYyRafrfxm
	 O7ygloO3YnxMAkN8yX/qgHUU4caXsJ3RUL8eKLHd3OtqeuZDbFTe5ipmtxK0qfJQyStRC
	 QFnqORaiiW+Nuic32IsYr5no24sxdALmnX2D+9S8O3PW0MViKaaHF2z0M1gnaxvWulB5p
	 DNLMIHBMQvXCY3XYY9+UVJyj/15ndacmp/dkTK3PUAbqeMeeRl8WIL/rEMLxYWz9t+j/C
	 Ajmsq+Hlk81qdPNuTJbgekFep92hxCo4LWrB/mTXeKoY5IN1NUHyYJtdBYFJoylH8Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=Su0bQNwXWbBRt2Z0/IK2d04MV45k/qHmlZMkauvqUFvOWFCqN6nOdb8D91sh1IpisGwu
	 KE/j8s/RTrc/nkr/wKSibLPuVEyuVMHLeAk9S5gtOsiO6G9nyS7Hze4ID7D/WNjcDgVTC
	 zJwTwANtTpAXRMwnfNuhh1PLkSuKpqu9gjt9kHqrNFxYOj499DDQirYcPAwe52GBK6OEu
	 rCMeTLX3FV6OvkDtA839rD2DAbaQh9ydhTwmERuwsgM+e2CHA/ub+qT1rzgLXOFYMXb7B
	 TIGIPodaJzE+NhRo90Gs4DJtQ7pUpzXrIMqvyz1EAeBHsOiFS5lWNZ3eL3+2RC8YM0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DU3s3HPP;
	arc=none smtp.remote-ip=209.85.167.42
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BA606A5A7
	for <linux-sh@vger.kernel.org>; Mon,  2 Nov 2026 18:04:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 008BA606A5A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=DU3s3HPP
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso4762603e87.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Nov 2026 10:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642686; x=1794247486; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=DU3s3HPPcJu4vylHmsciOrCK7u3u8vK6kVF8+Tt4lUmGKPzvgi1aI+/0BO0Zz1aae8
         bnPAFn+rJceceoBHHlekuoLln3MwW/0F3c0+0suPnQJmNAD3Y8/dNUPzY4UXvawgA6St
         tIxN/ws/SC3HHcl0hXTadTYp1FMHrmBfv75mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642686; x=1794247486;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=reFCp/fSadDyWZ0WzZ8w4Rsh2eytmlozwfArSw+vQB5fpDLM86Z9HQjn960E/w6FPs
         FVKAuA6vgcIzz1w1FdLz9In8YQ0xvORmfnhMa2IATAY0QBa3R+KeFYUH6nXpzSjNvR57
         7BUYDZqFaTZLT2XpJl008iRUXTAPORBWmLqBaReCVuvaRsznBdV9++0dqQtVXj+DQqOq
         PA2b/ZycPn0meJBD+orJcRotOSmD21gxSE3g2WZr/PB1KErYQjdznwwHdZW7uobQcDoS
         Q+V01Ax2hJ8Gvxma8KddAw5Ol8ea310X8h04AZQEcv6iv4q5FihRvgnPXcfgpB3Ra3ts
         rtuA==
X-Forwarded-Encrypted: i=1; AKwUvByxqBxnj2heCbNP71JmlvL3OlgJAb9jmACjpHh97z6F9hDj4xK7AUfFFokHR3kgzFC/ptMZ/wb+tw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/3YmmwIzohR+NM1WfDsMXoHfkm1t2X6Qn3ylR98vV3udCLIFwf
	1ydL9B0oOnDLrMo/ejNpw8zrtHsHWbBvqFbYHShsjisU26cql3tMukyq1XcZ3RiEdIYEVOVRLI1
	yzxf/SVTiqg==
X-Gm-Gg: AYBFou3CIvQ4xeh29pXBmf7TBwu4YWGZiNGUonsIQ3Di5iyCTPv94djXNzJ/3RFayau
	VIRjz6f8Pecq4ujKVaE44FJTnjuPb1g61oI2R263whul2DocdxzkoO0Zd9ZZMtJthk+JVskwDFU
	McGy5v5Eu5F8r32UdDlW6D9e/IL+PDP6PkDm/P+aTg2jT+3+fbEOxtQLhx18zmRYy5yMua+AJSx
	OSYqlxmQv5YZ3+MXuWt15RZZH4B3XOd2Rkura1xro+WYJdNkTjxLuhWM2gW1q5TbmdnQrTjsfmP
	UVz2KNonbpQIodAMtEg6TexwLXT6agEc+CEXrp8q0NR19GhwBTKoLC1155TwKT3diJrBCjIyBu8
	EtCdTfyo4b6IJyOrzCr43Z33/Og7mrw41XoCLz6iPp9ttaGLI+xASShtEBHYv4hkQ9h9IL/vnA7
	D+B+t2WW5+SOsXcvpHAey/uaxKdhg1/C3h/C3bkviJY6uGt9OSj47WblZQfxFgNZiD+s11kPjzm
	xEUNHQj5DbSjJ5C0FNevsEgDxLQDX2GBjG2OygOVWx4Z/HmSAiw1mL8bmSTsoAQytntn9RBt2Bv
	D7hYrOZpFne4ewI2QruuUCfVm4pXDBKCN/EMqyhz8eUWrjjFC8IutLhNbN6jqngfS1rVLiP+2/J
	/Bg==
X-Received: by 2002:a05:6512:3f16:b0:5bf:ce43:979b with SMTP id 2adb3069b0e04-5bfd11f3e50mr3708995e87.21.1793642686150;
        Mon, 02 Nov 2026 10:04:46 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07217fasm1789491e87.26.2026.11.02.10.04.45
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:04:45 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso4762587e87.0
        for <linux-sh@vger.kernel.org>; Mon, 02 Nov 2026 10:04:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByX47lbUKfhx2mnOe5PkYx/wEtinZZL0SG6EPf06BbXUW0XdvIjCGWFd8/lTMMnvbBGc43V6UHlcQ==@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
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
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260763;
	b=k61m8mXRIXR1uab4+2q6OOdgovVPlX4YeIesBU4z1N7jR1MVx0rZTmr+rRJ6ia+VRujG
	 ITXCGCaEEqpbBkCLwWQt4WafxHdDIBTgeNunNaSxDvrQ2R5hEJX9bLlgW8ikUdlCHmGoi
	 Zg4oARAUKHM6VOXI6yAmmtG9iMvPMaDoWCNqSIP0XJPLhmUHlDYQ/gnD6szByJxKGk2mg
	 tvVHhRR/AQ42u7sQOyGFmNQVvncaAHterw4d00tthb+eOLr2iHh7kGjUl/QWr1txG68ny
	 G+H2V4ADRvjaZngcohiBdTR1pVfc4nh3vRGdeztcmTUKET7KRfLAfT0eJjqxavDVclA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
	b=hXFKQ7z3JVlHb/rMx8o+/W7OE5LwI9kPzPvMwunq/7j2A3N09ikzCgNOHeNjpPLioA5h
	 4wqQ5QE2NLfYHxB/kvx77EAh78SKVtEKd6kdPKqahyUwpIWAzky7dYGeaK08aPAAzYv0z
	 lo7Fr+oUqLrruVpfL0UlYP/my3psJdYaABSD8TyuQOR6J0nIsu6jA5HODajmrFrghcP9y
	 sG6bYOrViuX7UX6wsvaCBrAfC3r10whZAmTLV4oKiNXyt2pwtECkvSDea2hk6MaC/Dz7e
	 dBjhijOQ5DGGyTDDptXVaQV7dBCNxhnN48PNHFL7LNJ3UMaYVY5Neq5u578QZ1DqKWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694460A2605
	for <linux-sh@vger.kernel.org>; Mon,  9 Nov 2026 21:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C694460A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaZ0qPv5
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-492f6b7f70dso881099f8f.0
        for <linux-sh@vger.kernel.org>; Mon, 09 Nov 2026 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260761; x=1794865561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=LaZ0qPv5+whTFQHjIA7oYo021SUS2QeXnWN8ii9Y4im7Ue68o46nz2xh/hHMwIUfQ/
         ICad5fyoXePYl6/8nNVhZk6UxBKiDwJbHcHq6QklDSJskt7Ox2MaUqpcgklbAASOb1WD
         7U13gt1MK2zXHTSuMFiAfjmE40I4QhfpTIR2Mc6nMOBQW6Dg/mqe6U/h69Hyf/QnrKae
         CyKIviPRPYc2tnG0IM8qOylYYY2PKnrUJzf833wY0ZcFYDbyZdAS7ekVESO+FaUUNtdA
         WzN6sPDUCv7pE3hPSGmxzNcqgZM1jmpktE+mpPCXGo9ukB9qCsiBySNit7DIM51G+Ivt
         K68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260761; x=1794865561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=874yjmK9ypxK94+nKOJ/uR1d6HpqK0owgIThZQA8ZUA=;
        b=IbLpOc4nhWj9x00k7sHrD7eOTsYy5BE0CmEXK2MAZTnzCqxW9rjUMJo4NSQXyM0yKP
         CnQF4oQVUUyGueUgLb2TAcr1vrx44ewGlk7MyWD7tYuzfKb2lOq720Ejo2jy42SlfSWp
         f+TR+N8LeoZbfWI/ME+oa9Emh/pfjcok08+wb2MoaoeKfDIG3RwZjjpS6gLCMJ4l29Qa
         dNTk9LFI7r3z6/jH5JT5h7O50XtktgNKb878dvy0XVxnCE3oM8nX3Dce4eR1dySVYWKr
         789jefQloRHehaJQN9zKWJ6b0LoYtoC/h85FEZ7PfzNcGtk4/GAhxsvtLKwJnlu23Cb1
         kbDQ==
X-Forwarded-Encrypted: i=1; AL+hErGcJng7eFTxn2uX+yTvJ7tjQtgKWqhchwTHT8BRXIeacCfnlGcGvokXacO0C9vk0YM8wXNjM/JfHg==@vger.kernel.org
X-Gm-Message-State: APuU4Z97mt/Uv1jOqx1fr2jsfD/+AbMKj+IvMNen1x/dQfMDCOgZo/FW
	ZU8/gw4Pw5dPliX9VHQnnh84z/sNR6FWW7bYYYjbw56jN/FTIABFd0rQ
X-Gm-Gg: AYBFou2KyClovHh/vrD0sWXMu3yEbsCwIwMUbV59+Mdn+6QaAgCz6gabBRxReDPh6QD
	PNHX1aa+eQ4bOJ7SdeZVCYrwLDmbuYUCmOQJE+AtoUIE7HSjJuofc8YLP1P5xVJIPuNs6x2JkPc
	JF6p+p9TD830iAJ3Q5aLRYJ4xxM/HlCRgfRjkVHe8Z0buKvAkki5Yz+atnyHL9Px5e90lFYrsJZ
	GfgoTEtskjonBf0eeqwN0AivjDcUzDIS7fF6Q/cE20hVJJhIUTLQlFOFcWOP9NzTPd17KMzXGNW
	sO8gaIEDdNquAEcYy/FbvSMeciKJcSz7X22k6GhjkMFPvIN1Sz0PiDNH7lLzIlNpno4iraOtQAW
	M5BB5TTSkoozIMBVfZnzXsMLwWnR+LY5rE/yafXzWYtTDgwdtGzb7f6parvvV0kOp3e5i3aLisu
	g2V7FS9sjDYb1F9dzz3i4EE8VKrRRZLdJNlYHyuP2gsg253VX5q6QmAyNorSNhixXEh38M17N0f
	IbWvgOuSAi6xG26g5pW7JfAmSn7AOz/gDy1WjfBwUTcm7NCyhMyufUBarsR7XhtOmanOm2v7zgG
	LizLDtGc8U4JGgf8+ii9JfnTagkU7O1Z4TqF/bNoVJKXzPYVwZtmPyLAPd+szOlYBw==
X-Received: by 2002:a05:6000:288d:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-4982b28aa42mr1487213f8f.3.1794260760763;
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1213644f8f.10.2026.11.09.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:46:00 -0800 (PST)
Date: Mon, 9 Nov 2026 21:45:58 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Christian Brauner <brauner@kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>, linux-fsdevel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, Josef Bacik
 <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet
 <edumazet@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>, Christoph
 Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, Joel Granados
 <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara
 <jack@suse.cz>, Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-um@lists.infradead.org,
 linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, ntfs3@lists.linux.dev,
 platform-driver-x86@vger.kernel.org, coreteam@netfilter.org,
 kexec@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-mm@kvack.org, linux-sh@vger.kernel.org, linux-usb@vger.kernel.org,
 samba-technical@lists.samba.org, sparclinux@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-debuggers@vger.kernel.org, Chuck Lever
 <cel@kernel.org>
Subject: Re: [PATCH RESEND v2 14/23] proc: let procfs copy in writes before
 pinning the entry
Message-ID: <20261109214558.0d9d5228@pumpkin>
In-Reply-To: <alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
	<20261108185953.28054fb3@pumpkin>
	<alpine.DEB.2.21.2611090504170.17804@angie.orcam.me.uk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 9 Nov 2026 05:05:57 +0000 (GMT)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> On Sun, 8 Nov 2026, David Laight wrote:
> 
> > > > While at it, I think it would be good to use this conversion as an
> > > > opportunity to replace "char *" by "void *", which will probably let
> > > > you drop several casts from users.    
> > > 
> > > So I tried that too. The thing is it drops exactly one u8 * cast in
> > > ntfs3's label write.   
> > 
> > Since char is now unsigned that one isn't even needed...  
> 
>  Please excuse me missing the context, but what circumstances does your 
> claim refer to?

Just that the cast would have to be:
	u8 *foo = (u8 *)bar;
where 'bar' is 'char *', and I don't think you need a cast there when
char is unsigned.

David
 
> 
>   Maciej
> 


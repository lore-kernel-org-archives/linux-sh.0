Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164398;
	b=KHcpcHzlsDn4UELiW6BwlhmT0zCCd2HYxnJYsiyWsa4nlNhTolJ/MoazFu9pmEJOfmgM
	 FpGFWH3cLW9P1FMW0sF6HEyC4GpTqRVzVRvz/HQW5SBAPIC9OHM3pG6cSpojHm8duBqPQ
	 1oWhUbQQjbrkJvR4/Y/yhawkbsxgLrJq1j3231yK5EVFqsg+Ol9cYLiyJPL5hidcCGTuu
	 Re88NL545x8tq1pYJ/LQ0uLzSO9bzgAnfl/HTLI2sXFDpBgCurbBKRTe/Ct49ptGfEPWW
	 oya0aGxf23jN+OtwNJE3bxnOXuyD1//DmHhWX2OF82Tdk3vBWQEe+a27Wz5hcB6aXyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
	b=hdiLHYK6WJmAi/DGIxW6O6PVA/v3UL9+dwXQhKNJmnSk4P5bodMZTOJEqYuElj+nnkqS
	 DO2lGMI0eY6wmQM+4x4ncAI+IxJq3j7PcNva3yOhYUP/uM9h+jyt0JrwtvG4MghiY3Uf7
	 dTtU79M8lSQOLncak+opXZ4RFFZKFdz3p72CFgW657RpuHeJYdRzQd2LGQl1XO80Ikl9V
	 2Sdblxkdt5zeYZX9mlVK0K9/Gk50fK4Jz2qaPWk2iF6mzGs56NwVlOHnGzDfLjkY6X62W
	 kzKDETJH8RPNL/hvvWfnCT5NyRpxtW+nabcY19E4XHvrDWPq8fwN5t8uLyrUaPWF0Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F52606D805
	for <linux-sh@vger.kernel.org>; Sun,  8 Nov 2026 18:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42F52606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XrEUEgHU
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so1338215e9.3
        for <linux-sh@vger.kernel.org>; Sun, 08 Nov 2026 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164397; x=1794769197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=XrEUEgHUwv+lt2Z0T4RzlOQuYT1yMbnY/MJrtF5HY2pc8m0ujKE+1IGJbqc3A1SsPJ
         Pz+po0Wh7ECcrOl1hyNdZBme+OsO/r11IeCA1lW9KMbstFhlOkC0Hm7Ef+TTavGsfrDk
         7T2AE8nlcorDhYFpLo0KTCt4xOv09AacMRilfH2h4PS2mZ0iBReAF8XAcgtI3iT+qlRY
         EJQPYUIUlDRCCjadf1+24R8V0flZyhCZpLCroCVsidoQ510350k4POOaAcSXgGRrBTWF
         rbpUnz5O6K0TOR8uz/zwLHiObwDAqnCJFWP0+ssCNYCBYnXJwQ2yMfUqdKkv6ro/lp/q
         XMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164397; x=1794769197;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JLhUwzup1lwefYy8NOOFjthYnrByVfTsqIe79kkV+Lk=;
        b=0jiD5T6gNNnwiOh5koQocpTIaRbxTjT+g4V+j5zyVKMxM74vJw37l4fGKD1API12rM
         C/4x+DPFLWATvKRl54Puyxf5Z4QMznaPz447f8f7GYl8E81cMsXMqiCCbcM4Xg6cWQfP
         KpLD9r2CnX37mLaEt/r7ShgYQ7tcqriTs9Ru+4A8y1kH5NMMb0iq6sT66CYAIVOSq+pI
         kpVc/9wcGAmn1Z/YlzK7aeMQv6g1wKx1uqnnpyhqLV5ODb+6Ya6FF4GJBPvDqMtpSXT4
         NSqNBT+jwB2WmYlVZks+fSXv+DKJubsFzLEAURqcmbDP/QPGUoNI+v65ujTlYYfLM9OR
         nXqw==
X-Forwarded-Encrypted: i=1; AL+hErGMTPg0/duKPE36SpfE/eyz8Cxqx28/uZRmPPaSKjlhCebT8ZlQ3OreyG4CiyHMn5M+SN4VQYLi2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z/95SxmX4JNIctrWddc/LN+D/eneAbPMGLOTzNjaS53Kvz1nWAa
	hWTt3rHQ0W/MPdyLKmWB6vJF+H2lhpphVn+e4gm40vJ/rMiYaNtf3rjM
X-Gm-Gg: AYBFou3o2OYEzZhaM3MRj/GJ7jeKcL6y0fRuIvhja3HV/iCKyFmaCmY0N6aLvRKfCRS
	yMxUBM4e9rOds57EOEmaNsz1RVwLdvMu0tnaJlreRdOy9gGI8SuB1O35AAA4mYbObhxPj1/ABri
	YqvOqHaKErsC749S1ga6P+L//CSvGZnFSSsL7qshEMu5AtyuQchCmENC44pasMFQkNL5E34bcSG
	gKgN0CyS3XUchYlaKDlAbugF/fbDZ6r3qLRFzdVTuNnNSlOlawEgFsruYEDTfRTp7okAkvx6yQq
	WV79sum/ViHn+o9EMuR4qHvrJ65vqG/Qbg6wNCe7wgvwD8ev2Oud/b6aJZMyODO+/UZGU9Jj73o
	PVWjtCLh+27Dc/7dmk+i+6iS025mKTrIkZyoz1xom4jE7Gwgoq0Hm7st0Va+KwYY2fvWxMDAmjC
	CJpHjZq8OG/T6UtKtog+0Pt3hxmYu3UJp9OHHARrBDOazBKSIYelcYtijCbPAUpJh+y8w5GXatr
	Dg/t3gIIfsdO451lw+QSZt5q7cUqLzxSi1jAK4EWuEnBR1JIRZqRAElJ/EGZz1lJZnm3thIufKy
	xiTDEjJr2aKMHeT1KJ9uZWgJwpcjJHEdZL8V7orviDHaPD/6g/8k8fK/xFySpG9U
X-Received: by 2002:a05:600c:468f:b0:4a1:7e77:c382 with SMTP id 5b1f17b1804b1-4b960d9b170mr35982125e9.5.1794164396406;
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1f3acsm185228445e9.14.2026.11.08.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:59:56 -0800 (PST)
Date: Sun, 8 Nov 2026 18:59:53 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel@vger.kernel.org, Linus Torvalds
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
Message-ID: <20261108185953.28054fb3@pumpkin>
In-Reply-To: <20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
References: <20261104-work-procfs-core-v2-14-76ace653a773@kernel.org>
	<CAMuHMdVfakapgBK6TBhO1iWX8qzvLDk8jzRS=t2MVa5G=MCUeg@mail.gmail.com>
	<20261107-akteur-gemieden-eckdaten-21304d085e35@brauner>
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

On Sat, 7 Nov 2026 10:48:35 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > While at it, I think it would be good to use this conversion as an
> > opportunity to replace "char *" by "void *", which will probably let
> > you drop several casts from users.  
> 
> So I tried that too. The thing is it drops exactly one u8 * cast in
> ntfs3's label write. 

Since char is now unsigned that one isn't even needed...

David

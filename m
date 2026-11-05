Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872842;
	b=2yXMmKL54gchUDIFjCUDqEinnqY7aqDIC/L8WGZx6U4SwHbjBKQMFXsqKABu31B0RJWm
	 6yJuZ60rI/c4mxYxntE+BRi90uT8oI6Jf+KEf2aSiBs17H+al9sUD63JbvwYXWg50/S96
	 nil/m/KW55/HSDpN9yiaY0H5jZCx/hSQs7gmt+x4ssQazBxa1uaslkw+WG92YI27X6zdV
	 3xrNlJKJQv7KoVXfIkBmxGjMtKQBo4F64wsMRLiKfW3I/IzW3bc9Lqx0YzPfy71CTeFAY
	 Obua3XJUPJ8u3/NWotSkmQT2otMBUs5uYP5BQW1E7ZNSErYxfvHyUbTU41qsYuVCElQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872842;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
	b=2qwEAGtaV29Y/yqdE5G3WQ1gLMyhBIRiBXRAv32rriUwQrOfEuW7YiGaVAvAoEPNwc9I
	 /MG+1rhPv70mdfNIvdf/+aXkKUKag7nLe2joTKfz7gK9mG2lsy6fsBI7YUcbv0MiRd+Oj
	 c3TSF3+FZYX7HuCoUpDE/owzlhY6/26+UrDRHs4oEw2Chg5DiYa8dEr71Ml63R10MptcO
	 FsEXozTN5cnLJZydZ/7AFKM/0gWvSfj7B0JqYYaJxd3zb2mO6lDp8RoxBm0gtqxj+Q/0d
	 5IHgtKAE5yacW1IuHsrA91jddYC3Ok683f5GojDCti5OmG6qF7Bwui1Q0fh0Bn8fZKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB311606A336
	for <linux-sh@vger.kernel.org>; Thu,  5 Nov 2026 10:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB311606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23363726d6.0
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872841; x=1794477641;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=n+1lmuZTLENNkpqKh8T8PUriZ63OKZ7RGcjsYNzzAGM=;
        b=F61S7kcp0EKMuWWt4iFbVzWdi5kDKjEl+VtgrlM8y90ggeb+Dx/1h5AbkwUbkZ4fm4
         Zvi3+r4wh5VeH5VSKYYnhzt1fw60DijNoJnMR0pRh0e39WDGDRYcCBq7GIOIAS/20tY6
         0cLsh+HZn/ib32Np+Dd4imWWAYVOAZBrSWfI2AdhXiXCTgNxwn8r970Gqbkpfap/0xEf
         9ky8nWgC/jMp3nKec3w9gPDXyw++uM2jyORpPkX/ft2d2n0X4YHDrtAd6QPEfv+yRQDy
         cE4qP0KF88DjAIiNAeXlq9h9rkYJyfDdYcwR8cSrpAuZIP1mv2eaM0wKlpNlpUZsYj7m
         Gy+A==
X-Forwarded-Encrypted: i=1; AKwUvBwl0jHsWFzMobt5tnfj1eiT6Y0dLy6cttGErnqrG/4pMs95ek+AKD6Qtp0rOnsfrtig3zh3TgQ5bA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/uUWjDc3GJEL30HqlJ8TFUhc113TbFOe1C4xRDncpU3DQ1pk+Z
	DxAiNDYCCH53/pIU6K5CwmPLJYWoZQBwYkt7grUXDNBHZKQUeB6zsNQYq6V6Jj+zN+U=
X-Gm-Gg: AYBFou0QRL23IDA2Zn0oP+5VaQFPv04m5SQ4duHy6Wqh7oxZWD1a0xX3B20L6DMnMu4
	KZ16c5EjUI3HP7uQcBFymrKgd88BYvKv27UK2uGR8UgHOC8mWgrwe3lN706INvyP955mIpxCgkx
	hMzn5NEWiSeFuAQbhnUucym40JKZOKGFGkhUkTN8A1iQfn30BVgTRX2m+xJR7jq+yNPR4G01uNL
	9rPWLhfRZXXOQt2Z7B2AHVWO5bzy4FnMerFhZiUnurB3GIlyLj8w5X7+AdCtHUylHBacz7SsxRc
	31as5diurOWAw+pOthuqSJmpL+QUEa2fv7QOvR0AVBHaK+/9gSf70IYnjHZxP38e37XJ5MvBsgn
	FQQC/o9mCZP0vaAmd8UXB/zAkmuplZOOZx1cLdCN3tCuDW624YPB41XzlfWHvje0iMQe0ec2zWI
	W5ELn/pzLdGLSA6VHV4DgJrqOSOJRqMqn9LicvdowcCcyKeQv8JquG0Ux/UADs20JnK6qy8h5ev
	5+py4mEzswxnUG0UcgIdH9ovSaIlcSn7lLkbcwsB7Xe/rRRkPGKq6bxECxUnLCilvXYWlwCiwHF
	9mO6nyCR4VpWI7kQDuSZoCVKfiTdFhsHxSMiwR2JtfX4PyYyHym7GgePAymGJIEF1bfaJw==
X-Received: by 2002:a05:6214:4012:b0:917:9915:1f76 with SMTP id 6a1803df08f44-91ca4b238d3mr311318956d6.30.1793872840524;
        Thu, 05 Nov 2026 02:00:40 -0800 (PST)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e013a5dsm44009016d6.27.2026.11.05.02.00.38
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:00:39 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53653e30353so22036991cf.2
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:00:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzVFSiTsCg2NrgM7yevMtUHTd8Mv5cVezMFz5fTZloWB2Q/w+knVqebZvZJERgxlfZf8Dcj6rjrsQ==@vger.kernel.org
X-Received: by 2002:a05:6102:6449:b0:7cb:bc5e:7dad with SMTP id
 ada2fe7eead31-7d072baa450mr7614890137.10.1793872492413; Thu, 05 Nov 2026
 01:54:52 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-arch-v2-0-2aeb952c9597@kernel.org> <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
In-Reply-To: <20261104-work-procfs-arch-v2-4-2aeb952c9597@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:54:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
X-Gm-Features: AclHuK_RsrcE7hVRjmpZezBV5tMd490Mza2XAQiqUTgUNqAiHAzRP5z7NIbtMh8
Message-ID: <CAMuHMdUNBs_NyhFpXonirMXkYptUWsAizMvVpGHUDLzto1LGJg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 04/23] m68k/bootinfo: let procfs copy out reads
 of /proc/bootinfo
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jann Horn <jannh@google.com>, 
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

On Wed, 4 Nov 2026 at 20:36, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read to userspace
> after it unpinned the entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

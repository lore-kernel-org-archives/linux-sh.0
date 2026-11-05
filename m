Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872954;
	b=1zJMr5gt3dopoxoPbisr/qT2sfoo57x1aXL/SVKCyPL52SsYv3WmFkfr5sCwOV2EzrPV
	 6+xsjG8YJrBjKWRigxvCg3hXxlU3nMvYK7EqZxiDnzyILo7YHIXLgMv9/KQD20e3781c1
	 VUia7IFEwuPg67Iey0s4vNlslBDtayhyKAN+ejklzIFNcCg/UkHM8U7EDWUMmr4tu7EXE
	 sy7P69yvHVgxphW9BxYpjko9i++/oqr0eCd7ju4GPrd7VTdnbVr/AbmBAw6PXXygs1G4H
	 ZTFy0t+wdUyzodlE7JUc4Nvyu8qyGOAXCwAMEU7bk4h0mfavNcO07e8H6VplGzk61zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872954;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
	b=jaKVih51N+mb7Zys5Au6hzrk+d4CT5VWOWQivmoAgGafWW8uNigMDzU8XuqbruojGyKU
	 l0wjSjAmd3ZUd6ZXhaPIcUMB8bYQgNXYnLo8d0Pj334Lme9ZRiZm0F+IYimiGv4WpiAA2
	 7Dby+EX7/dlHihVKQqUprQK5EUTTXgvotYeUCB5jdUekrd/ikrIlB150B0XSJZw7u1brB
	 FDTQGnf0tKsT2ovAOkGYB5YuDZxqJdZysSGG1H2gJQfCfBZTg11oGABh/ZHpm1v6EFLP9
	 5uYpb1elYWI3SK1TqHNg8cr/nnIpWwAUXWvI/q3R2BOq8ZmCJa8uAyUOHN8/5UpWUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E46F606A326
	for <linux-sh@vger.kernel.org>; Thu,  5 Nov 2026 10:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E46F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93e7ad9f78dso201372085a.1
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872953; x=1794477753;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LrgDMUrSYXpYgkAhfsYKg0ebb/uLgOfOMhqzX4yL0j4=;
        b=p0VEtz1Xy2lvKg3zbxjTHt1TPNP3r1rBRX4TMBcmQ0K8kd45Q2BSac3n6w8uyRdxcz
         ffzkIsi6SdnSBZ9nauMc6VjaIdAhiu7yrwpU679IaUOdw0VJdpPFthaVT5+xUiEENj9N
         6dptw2Kgeagupp8ZT21igMhhA0m5URBO2NN+MTkUDvSZD/K7Q/Crb7WJXP3Aw+MEtzKK
         QGrgEU5J26RieoXxvM1Obh99f1Hgjj0P5ydYIPy7uZGwgyEAEVTpUPqAVHNBmxKST5QQ
         UBCkjoFEG6/2Ob3oKk8uOl3QOgM/6AYll5re2Ket70OEogs4I6GsAevx/YgpZm207OIs
         AooA==
X-Forwarded-Encrypted: i=1; AKwUvBxh23EcvJxZVp1A387LaEjZUP/bMLRoRCRwfzVi3DCcCyIejOfDYAlgF6IlC4/6Q2bUmNxLQioI1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Ez7h+kO5qV080bCEnMIA2xdJhkDE5w+DjmomRw+IJA8ukLiRR
	tuz2SfX43bK46tt26ltA8PGoHmJ2aTrEQoMcsib61PKAzB8AnTcEmyDAEmN0dXskl64=
X-Gm-Gg: AYBFou34chnMUgJU3t0qeW8xO5RuPFTHxbvfzRHnMN2xJoXCxktIo9v2kPnArnIOgif
	yUuUeXxd4qCwCJeKpd9G+oT+QPhXS/rgxAa/4GsKvFT3lV5SdHpEAoTLt1a2JqIpMOVqk9AwY6/
	1DCLaKafS3pMjGcBGpUb4WfRfa7Y1noV0nnD+6EZ7b7vTJCkqspRX4/ryIlI7xCKe2tAm3ceC9T
	g/RnSwDJQc2/18zikXCK1mJn/sLrcw9J8cFJyscFFPsq4WF5V7WFLm+PmfLOeqCjB8VreJ/kH+C
	a0OfN7kgI4Fe7wjaomTtyGNGmbHc7tTtGgcKs7eAfKhZHvjbRdMuLFWMpkp+je+kqbe4LGeL/es
	Y73qO3tWPOMU/c0FnAapOyXXXYFO4mIvY1ur+WajoSaSVEFG6EqPIeHvwQ6d250pybSrHYs2ggF
	ylKjx4baxlOiNNMmIe0OfT3aH0tUAwOhi+2kAY0mfmOgiGjywZ3T0VuUFUKvupoMQa2LURF/rCO
	vKgH0S0Y41x+qJy6Q20rmUh+QOJ0INLLJFr0q54MCpxfZ05ZFmqJI6cGSvdXbzWhBBMSgc01cMW
	+8wFH9nqLSapyEITLcy8BIA7BOqvsan2A+CrstqQOAjxXh9rMnh/OpH5KZBR+NVcE5vdjA==
X-Received: by 2002:a05:620a:1a05:b0:93f:2938:48ba with SMTP id af79cd13be357-944217ac2a6mr3019681185a.55.1793872953023;
        Thu, 05 Nov 2026 02:02:33 -0800 (PST)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d47f68d0sm427117985a.19.2026.11.05.02.02.32
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 02:02:32 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5364042eecfso22736691cf.2
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 02:02:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzIjFr188YUQNCTjVI0c9pJYnoymKMj9pmXfQbhE8Sjm9EJSNAl6qFowTlmTr+Rlzbb6UrHF3MlvA==@vger.kernel.org
X-Received: by 2002:a05:6102:5108:b0:7cc:56a:58e5 with SMTP id
 ada2fe7eead31-7d072d84a58mr8269567137.37.1793872526219; Thu, 05 Nov 2026
 01:55:26 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-drivers-v2-0-245e54e87116@kernel.org> <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
In-Reply-To: <20261104-work-procfs-drivers-v2-2-245e54e87116@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:55:15 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
X-Gm-Features: AclHuK_UsJ1nGicdWEWcMLQAICTi1A7pGF3yhNkxXkXRPqohle17eXAHHNBsR6k
Message-ID: <CAMuHMdVHxQvKnJyKHrOZhaOg9Rn2hMeRU1JnMFFEEi31FPZaGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 02/26] zorro: let procfs copy out reads
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

On Wed, 4 Nov 2026 at 20:43, Christian Brauner <brauner@kernel.org> wrote:
> Implement ->proc_read_buf() so procfs copies what is read from
> /proc/bus/zorro/<slot> to userspace after it unpinned the entry.
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

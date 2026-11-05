Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872309;
	b=HJMfEyo0vlJxIdcNybrEh7bWjC1tZyx7DjpQRPEUNU7e08UnTYp/ckSa+Dnc0EpbBBY+
	 WMAyWZIKgsswGP/E/NPjrz8ri0vYx/vifzVWuoUHWFVPsHIBXR1tdcPxb2sPmlv7MfScN
	 mKY+z8wc+5b1GAPgiKo88/y7ymXxJnHx7GKd54cbLc2CvtOuOtwD6mdcphChA7NEOxTmi
	 Vtjl+p5DSLHQ6hwM5TGFFmdNGMRTqJM28HEjG2IxLo301WG2s4W0971AYVL1xxYW5v7Xi
	 FlsRiTiN7Nq25Qtmr8EOjt1vyj2FBtbKPNq15D6OL+D0QPbmECu9kW4GJV1lWOZVYxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872309;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
	b=gBj8qN3nyP/PspiDJgb9zPpiqYu53NvK5t2ZUuUjoGvhWKr+sKm4GIFf/J5Sh33L4jiD
	 FLzAaTXqOcXSwZJ8Qu6K7Hst/2eRlmG7iTO3xGejMQjeVtSVRjkCJ84qeUqgiD0MzrG89
	 yJnZ2IL0eUUscTCPCweRa1u4CLrXzvBIPUdxZtJmcJYsbwxNhzM4OZFDBmYlW6w81u7Fx
	 pQZeEpsA6TmImrxh7pBnRW2BTmJL6Ofo+bL6RmeurLyVPjtq+NLZIrvVqJ7ijAfH3GjFJ
	 VillOz6KvadElwaPxIxmBrmHUrceY3v4rzBm1gp/mRD5WJ7AMgbExGdNYc3DeCHfkaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3424C606A329
	for <linux-sh@vger.kernel.org>; Thu,  5 Nov 2026 09:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3424C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c7a0c1617so23262666d6.0
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 01:51:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872308; x=1794477108;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SqrTjgENN7Dfs+HehxbKPgACeb32UvvfMAFijNHd6N4=;
        b=sAe4CoSStjHY3070fnxjCeGjgTViOxmektjRSgVMJN69x+PT0/6G9ZW2ELY/wSmQmx
         Dp1Z8YwQiUNtdlzAsba+L1YEAJC1VyffUanDDwdgnMQmU4EquYSTFFaY9i4H+6/oYrb9
         g3UdEfhvW783yvuEJRKcY7fzKXKfPoRV9ybq70GqOlHn3NjfZ4/3cXHgxQzqX52gufKF
         Kmjq53WG637jO5iFjpo7svvr0G4M1c1X9dV0lXXDNPXiuPYqjYahOLBOJOd8YXcQRJ7P
         onuoiLwq4B1uFDB/jEFzJ9P97nePeWfiRRNA1juUa43rQiF67UBNzAzYIUEWBRe0uSM8
         9DmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwjR+CE0e2Q81WR7O0RhodFJR/HypVeuliVMrdpmcFqQg0WvGv/Wn/mZAPEIEymhNtoqJsZZG/o+Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9t4qO4GJx1VooyWZ6wA01SyXJ8KOkTzUV6MevvsjYuL4s7eYim
	1oD+z8+hgVYmjlot2FvEjYTjqyz+DQVgLgIn0HHzN58Luec8tWvKdIaqHTIF/8xXkZc=
X-Gm-Gg: AYBFou0OnK5/hS3/RWEDxIwjZzkPgG6Qq2h1CIo+Ls/2Slv9PU28CchC1U8Gv+NCK64
	hZi9d5GEk8Ir0dS6+ZBp2fYWwdzo48beMVRzdvvp3xfV2fxc4fPjC4bYE9AIWgIye6+JxE6YldN
	LgMJTEu147Y5/URgq3ES96GbiakyIryoVfwvZpSac+YhP6kDchn7aN98Vt/T34N6PDuaW5bGFqw
	ZGJ26s6aVuyeXQ+rl4Vg/7/ebg2geyUGJNqbXzrucuUk37ykUEqLXL4Mz+VHlSduTFB5kq/xtK0
	n4m2ZDgz3fugjq9T+kGz/SHcItAqL2rUiXhBCM1usmPm0j6VZiuZBONYACQw6LZla2Tx6tYv1Qx
	3+mUYz+EEQaOYTv1Dqd34W4ZkQH88/1nZPRGoHeojUmMbzII6ARPbErkEFwfACr46T+DDUA09Mr
	P8RWsZcgZC9JOSNtCpSJKBcIEsMf1C+cPiCiFRDrp70XBPV7MdJtJX7lZQS/2wSGDGJ9bkKU68t
	IXspzUkSn0ywuZL7j9F324rigiafx8LnvZtqs462zNz2KIgoR9f52Eqnz7czaFsggEzDpA5Z32J
	Y6+bpGPbeC4pqYKQaCwX6JKgsl2HGrGd3jlrUmR0VySQLwREnMTQX2WnGXZf7UHKng==
X-Received: by 2002:ad4:5967:0:b0:91c:a33b:36d with SMTP id 6a1803df08f44-91ca4b4c436mr305275616d6.36.1793872308168;
        Thu, 05 Nov 2026 01:51:48 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e9a5d0656sm10055996d6.16.2026.11.05.01.51.47
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:47 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c79a9a739so23584906d6.1
        for <linux-sh@vger.kernel.org>; Thu, 05 Nov 2026 01:51:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwoZjw0w3T4aL5IjytXEoM/5NetjQP5dJCq2J5d53uEuM5Eru68FH+nSHEn2fQCPa+J62N4Lpv4og==@vger.kernel.org
X-Received: by 2002:a05:6102:3ec5:b0:7cc:2bb7:131d with SMTP id
 ada2fe7eead31-7d072baa484mr7324212137.9.1793871885062; Thu, 05 Nov 2026
 01:44:45 -0800 (PST)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104-work-procfs-bugfixes-v2-0-021c84d852e0@kernel.org> <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
In-Reply-To: <20261104-work-procfs-bugfixes-v2-10-021c84d852e0@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 5 Nov 2026 10:44:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
X-Gm-Features: AclHuK9D-nB8icBns0zdoQH8fV1cfUPJ6LOey8o_VlUZpDIGqKC4cFf8-j5-HdE
Message-ID: <CAMuHMdUy1RYKG0g8OWss3AD-jyYx3DXL0K7ABYkFUdxTxZ9VdQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 10/51] zorro: size the proc files like what they serve
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

On Wed, 4 Nov 2026 at 20:18, Christian Brauner <brauner@kernel.org> wrote:
> The files under /proc/bus/zorro hand out a struct ConfigDev and seek
> within that, but their size says sizeof(struct zorro_dev). Say
> sizeof(struct ConfigDev).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
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

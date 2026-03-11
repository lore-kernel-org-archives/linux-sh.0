Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1B3191A5
	for <linux-sh@vger.kernel.org>; Wed, 11 Mar 2026 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235459; cv=none; b=VswxSu9Vpp6GkdrDywsDEbadnD/jVzOAM/gIn/yZTZOKS/0JI62p77kk18ZLs/LxFrivxcgWQxSa1fXUlz/cAfavHHOBsaXdiJll1d+Ae76xB21TDjAQaMYrNizUc6vt5mWTZMN89GlS4lZj3NAWZyVj20L2uUNVBL/q6Pc7WL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235459; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vnta488eZ+BLd/xAjJcOfMoYGJ9AoIb7azHKLlhq6CXo+I0duOQaeqMSkI+1U6YuPdKWA8mh7brTXLvHg1qybIiu7hqJNNr6Mi1XKfqUeaVyyt/qRvIcw5YDu8LA323elmbXpzXL1VpY+hBj07N8l2HQfJOfgD1xcyPYu++qu+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-94dd0f3c4b7so8223585241.1
        for <linux-sh@vger.kernel.org>; Wed, 11 Mar 2026 06:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235457; x=1773840257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=QmPbC4XoC/AB7FIpPGzuz/eYOs4Qt8k2mBUh+de1ekRc84YT7cv54XPP9wEzRSYX28
         HaMVDS1kCTd3gXcKFbbC4m2Xpcemzsm2FW/e3Vr+ap5z/gpnDiUaAwWahFf3pLQAk8p7
         wIm4RwO+n6tB9tP7+NEIbMqTOzE9IwmvSfHu5/vDI8ZUihJGvu0XwCXzSfEy2+PoyhYi
         G2/YU9fiNMF2mEjt0wAtAIgRTwDLfJrR9gMhYcTozycmLUK4Lt+NRJiz+nAwGsxEAS4j
         4Rr0u7NBS9TrO6a1UxAR+PcHtSOGEtucjgsryTuwWRCODiw13tJ8qoOTxtjH2DeAGhI1
         J4pA==
X-Forwarded-Encrypted: i=1; AJvYcCXlCzprpb4VYht89CfTH37N7V3SERx+DWCydRKYlurnQp8lFWFK/lrk1KAGS6lim2fHooVo9pw2xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0Ri/Hvuh6EXzMlElmsVvqyxmgd8rd0TC7sSStGJlraUq9lax
	RPvlaGytarvtQX6AAztgWRvwDOByK/6jqA2nEBryZtd7Wemf778K1UHHqh8N3LjMj+I=
X-Gm-Gg: ATEYQzztRTRDZ93bVwYO/Hpi9EER6mEqH9YxEpYmF/ljZ5A82gqjxcL4tdH6bSYw5fN
	cMf+YIm4NL0Fh9CWrCdidiZewcI2fsPu8jdEjZ81YXm3iGr9Sk6zvolMUSkwgrf1LmbF0Bn3oOM
	1gmHUBknCGA5jr24aBLS8mRMZTF/vI4xSVWeVDYEty+wjx+3MGfI0Kg9VHB1N1U4c2SN1K22Xr/
	cofjCAzOB3CmZxpQ1nqt85cZgJQzHLZKupAlACucsRPJ12WjqvnzvRjA5hd3Brb7uGdXipwDNFh
	CWWfvA4AX6IzizqSKuLqYgSvvamVkjCMDKuQ17jZExSvSJnLQSvKioprvhTfwLQ/ZesFmx37SWl
	7T++k+UhjAiT697SWpjNqkBm2Pa0qLyOsaVuPpD0fsBiOXifwGU6fTx8GgNcZk3ElYy0hkLj6b1
	iYYKid5Kj03fZ1NlTMnjr532oAbqIFwRRddG5QDPxVxrZQXEw9hBNjU7RAoKEusWBc
X-Received: by 2002:a05:6102:3588:b0:5f8:e2eb:43d with SMTP id ada2fe7eead31-601ded2f067mr1027129137.10.1773235456954;
        Wed, 11 Mar 2026 06:24:16 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94ecfd0069dsm496094241.7.2026.03.11.06.24.16
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:24:16 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5675d609621so11792983e0c.2
        for <linux-sh@vger.kernel.org>; Wed, 11 Mar 2026 06:24:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQ6h2BDp+ymrcbRFsv1dZSYoILhIOf/kffkzzHUTqhNRY9k9a/eYme2N8ll9sMTtDeMLNLL3eNEQ==@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

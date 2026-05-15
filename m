Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31164413D73
	for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 19:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874737; cv=none; b=EP4qwFrkVbw+Mn/I8eSXhnFdLQM8dIM4wkphNwUPBCXpKIjF3Ei/hL1wP5gVVoO4yTtwY9a4SA0Bf02D4ntM/GLy8CvXWxmI/ltBAht8HOlaLdNBDTD18t6FJBrI75yKexUckfEhvkQ50to3sSf/AAYPZx2uM58H1V5G7nZr8fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874737; c=relaxed/simple;
	bh=67v01lutIIJe+loL2irKpXHgU9bSneJunpWke2ocJ0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k0Z6e8uvXSvwRmI9rb51bgZOttjDJq9k+ivHzKllo0M3XjTjDiQyuvVlaqrm0PJSs9sMox3PuxJMrCRgRWS4bp1qftaFmu89gbOUET4zHHQsxg9IfPSYy66Vx7dLhIX8YDtVM9PB4yZS71xNkdPrLquY550rCixHQYv/L1pw1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sQA0OLMk; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQA0OLMk"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so1233375e9.2
        for <linux-sh@vger.kernel.org>; Fri, 15 May 2026 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874735; x=1779479535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQgTHiwAaq/3ufGCYEG/RW9Unijgsix8K9ENtTZJ2vY=;
        b=sQA0OLMkAN4BtVywQZvMFpqkEe4TMHbX5zG/lujd9MurEoL58GVy5cjgLZYhUWVPV9
         G5RzTz/HvfBUJunKCA+zoHFF3JGk06QuWRMNka8PF2LaPvXEQrgv6rU/cakmxTTnJkQU
         d/HDWkXoJtAsuPKYtY6OBEskAWMGn/QFwX7TfevrslIQPbuAvSzwzfxf0xdpmQwEunoX
         G0dNuXAzAwOAV0aKoSQ/E1wnm86oE5gmJCq4CLNydXaJdxsnyTOTjQjA4rEZzkbOb/xy
         96iQhfZCORUebArz4um3txJEj3ZKGmBUE3Qzs9QoFHmS03JCQjQ4lvsTmVOEGhIcdo4K
         /qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874735; x=1779479535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQgTHiwAaq/3ufGCYEG/RW9Unijgsix8K9ENtTZJ2vY=;
        b=BlQN5tOGy9CPk4JsxakzJb8kbRZ1Qflu8tCjmggvcSB1Z/nqCl5acxOmcoSx9u+c3c
         DOscUPhFsGrzW4XKMSP58I97BbwJoB7iLLqSBDsS5DcnGfaGvJRZzcxmSBHXLmdnPK49
         VVx/bZQdxaXqg0tbrmFtCPtycAlF9yDJwfyanjH+aAjTkwZwh5kXIZTYVRpn9Sm/36uQ
         oJdo0qW4XyKt90HdJIfjATDj5UTXP41i4s+/WYi7kzvRoHiYF1sV4jJRFHlA1bQ5iVjk
         WF+lSoj4RHuRnZ3JiK1g/0EdqW1t3kQMm047wFeqZafY10Eom1UkUtH0LP+5csKyX6Wn
         EdrQ==
X-Gm-Message-State: AOJu0YzwR+LRT7CwRkmJ9wWIj50QzuI88KwX5C2nH+EocZRG6AQqgBN7
	iIObusjQra0sDWd9TGKtfF7NGWJiGUxbUiGPPrEsw24voeUPcncque5RjqJG6r4=
X-Gm-Gg: Acq92OFHDZvwNv6I3utcwEBM8oabgP7wG2enM8VW+r47K1ASmyLyeGyAPVthhqrRQK1
	wpFOOX118BicTGdQs2izufBBBiW+aC/YFeOgRNEmOWwlWlqVkdu+EYZUsfnbD0iIwey3FMiWd3Z
	vUiHKC1Jt2u8Sx5uWvqpECOepPJriRUvQ7GGqlEkLm6rd+2iLD1irDuV29toMfj5M5i9oGqE2i6
	btsmgDEuVA4mzI4BFRSvI9a2F3WgLkg0Q99CGfxQSAucYDn4YQYMuhfwPsvyEBADPCeSmX52VTE
	tO4AeYIBa0OIXSLk/J9/LPRw+k41sCCIlacZWEw/DYjs50R8rVM9EUKXSHOXIReJSPJ4lMRNYFP
	8v3rJANgh7uXak45skbam8izIDuMiLf9CutbYcx1BpcF7lXeE2OauLNSbgy3meDgEqerI7V/jrs
	IVHxmiFJyS28fAwaMoxbuYvUVuSfpFwZ1eEBGMNy0OVQvK3qZQESv7qfNCDLVyP8NSSdkwfVsVV
	BMsfQU=
X-Received: by 2002:a05:600c:1389:b0:48f:de4e:882b with SMTP id 5b1f17b1804b1-48fe60e524dmr74553605e9.6.1778874734409;
        Fri, 15 May 2026 12:52:14 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:fb24:41ce:1d7:fad9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48feaf14d22sm31388355e9.3.2026.05.15.12.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 12:52:14 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>,
	Adrian McMenamin <adrianmcmenamin@gmail.com>
Subject: [PATCH v4 0/3] cdrom: gdrom: fix block I/O and capacity setting
Date: Fri, 15 May 2026 21:51:08 +0200
Message-ID: <20260515195111.3295031-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This series fixes a gdrom driver Oops due to bad MMIO register access and
fixes the missing updates of the block layer gendisk capacity that
prevented ISO9660 mounts from working. It fixes also the case of disc
swapping by sending the Test Unit command prior to cdrom_open().

The change was tested on real Sega Dreamcast devices (PAL-E, NTSC-J,
NTSC-U) with physical CD-R discs and with GDEMU emulated discs. Before:
Oops on mount and an unusable drive. After: Successfully able to mount
and use the inserted medium.

Thanks,
Florian
---
v3->v4: Simplified condition in "cdrom: gdrom: update gendisk capacity
	on open" according to review feedback. Sort trailers correctly.
v2->v3: Added patch "cdrom: gdrom: verify device access after disc swap"
        from Artur Rojek to also handle the disc swap case reliably. And
        added Acked-by, Reviewed-by from v2 to the respective patches.
        Also handle the GDROM case in gdrom_update_capacity().
v1->v2: for "cdrom: gdrom: replace port I/O with MMIO accessors": Don't
        use helper functions with io.*_rep(), but writesw() and readsw()
        local in the respective functions. Improved failure case of
        gdrom_update_capacity() in gdrom_bdops_open().

v3: https://lore.kernel.org/linux-sh/20260423194132.693271-1-fuchsfl@gmail.com/
v2: https://lore.kernel.org/linux-sh/20260419162823.2829286-1-fuchsfl@gmail.com/
v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-1-fuchsfl@gmail.com/

Artur Rojek (1):
  cdrom: gdrom: verify device access after disc swap

Florian Fuchs (2):
  cdrom: gdrom: replace port I/O with MMIO accessors
  cdrom: gdrom: update gendisk capacity on open

 drivers/cdrom/gdrom.c | 61 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 4 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0


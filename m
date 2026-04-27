Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953737AA66
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290678; cv=none; b=NiLiTj/D27dBT3RD0kIrI7wXK0ea5eObcj4Ee0aLCWJjsNwVWDvr+I1QP1vDTyf8R0+x6W5ZsPe9bmb6fiHNxNHMOJEBA5Q+TsQ5KUZZiN/KAW0b2UcrnPuUaZU6JfIinnNY+R4zcdKwlleWwPeIQgoWAqDSmKoMwBZta3uoBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290678; c=relaxed/simple;
	bh=aiD4s1L+z1/whHFiymkZK0Cz388Qnl9M8T5kOWqATIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raeU7lVYLNx0UtZQ/Uxegow9qHQ6uc2Wr0lgBQsP5+EQL7XtII7MisWxfSgFuK6aUgoC2Khe/VR/R67WDtuT8Owt0zzR7w1qJ15v4IUi7IxNrMaCP4idVk3+238oTGpDzzHqGWiWiHtO/lbmJ7JyzNJcXUFjsxV/qWDYqLiy+vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBSH4Dho; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBSH4Dho"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso93709815e9.3
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 04:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777290675; x=1777895475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c9PGXNkAslwn5PF5hDFlY4Tr7da2SwHFO7xPTeUxuok=;
        b=eBSH4Dho9t+u//1E5INuvxkWty9rpy3s3v04R8otiPTl34MEBnq7dPPuFNbig9p8/p
         cWASibojNBGWu05nTziuSS1caI4zPNjWTsYxnGgrwh90b2e9RA8Gqv8Yso6DVbS3qb+U
         kHFDQgHnAzENXt/U2jDDSlM0t8mp54P0CVhQm6r0ABLlfqPIMEzkfH4kDLyysyovWwLv
         Qv5GKezIlJoaR19+1oMP5IbQ8D9aw26ixu6b8XdvmCU4qWVcORJHj57PEjFSwYVj5jRb
         1rK05PXocLj1TwuZFQG+7geKR9XRSD7tTOD5eiWvEgogXcbl0wp28rlCsh/6lrHflpX2
         op5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777290675; x=1777895475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c9PGXNkAslwn5PF5hDFlY4Tr7da2SwHFO7xPTeUxuok=;
        b=HMLNP+GWM9RFNmKpZHiWss77+e6CnnXvxnZQC7oBmqmTfTLOoXBwG9S7kYszng0Fx2
         W1BiOXGa6kfrfkaj+5VG1zRGjNLIYpn+TulKgOdLcED+EA2rYBRlgKITlcItdgrf7P59
         uxPgRCAJt5X25L7undTN55tYXHTHlPBi+33zvV9NFFG8QnNXUX2DaF6ay3z7ztpxxGfL
         Ew5ScriWPRKz3SDi8rtIjhzngwbVTPZAQbdvTnQaFBHsZE+UsvMNbuVgHz9T+fzFV9V5
         q6wwCRHPF5BHD9Et1PboeQtd3XrMJGO3VVfO6Tvw8fT28KV8UiNrdFZRwMYExy8RVoR1
         p4vQ==
X-Gm-Message-State: AOJu0YyqwEf9OAV9hhvAZ0grGTAf+csxF1QJBPhtP1FYtc5lgIXoMfiq
	TAeDczYJ66kMN4NnQl86ZSaxWyzE9ToA+Bqa8yutFBwbO0z6hjW7nB0=
X-Gm-Gg: AeBDievLJhUgJCyb80OcZ+Fhpg676HOq8ui97PeMQD+2OFy1bo+JTneIAGdCF7fZbLY
	j7kTWguTd6ssUMjszeH5VQPqe5QmhwQ3T8OOt+DwG9WHclPqolgtO7HfwpBUtUJxFZOGpW2pXmb
	Tvah5LzxgTbk9gk14pSPUG4FSsGbf8qbKj8EC0tga1lpouPLobKuU9haCZp4nOaJ3x/n9wRP0Rv
	bO1DWLTwZgSRVjCrDbflvbh/6UjKaYCsqJFkhXIVfs/n46OqouaodNHtYIcunewXP9Z7SEZ55/F
	gXcTQs9txLNSTIs1JNj4Htn2RUzgLLs8t3WermwJU9TrGaDn/38pdsf64Eta6P64YAf72fwhaL5
	D5xadH5u/H/Wx4eKnp3XJRP+/MC2+eToybYWN/XfXdlwNv2QcDAP/0bU6s171kjQkD2X5YrXLqI
	D+2B75BVKRAP2xKHJM5h6qOXntc8N8Sul7GG1NNuI3BgkxnsyBqyttTX65LqvAkaF610TI3Dbj3
	02Xbay7L0GDqnusmNk=
X-Received: by 2002:a05:600c:1f94:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-4891c2d2213mr476219715e9.5.1777290674926;
        Mon, 27 Apr 2026 04:51:14 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:3c87:b0bc:8c35:1ba0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4c221cdsm81399615f8f.0.2026.04.27.04.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 04:51:14 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v2 0/3] mtd: maps: vmu-flash: Fix build and runtime errors
Date: Mon, 27 Apr 2026 13:47:47 +0200
Message-ID: <20260427114750.2480900-1-fuchsfl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This small series fixes build and runtime errors in the vmu-flash driver
(enabled by CONFIG_MTD_VMU) and the included maple.h. These changes were
verified on real Dreamcast hardware with a physical VMU. The VMU can now
be successfully probed, read and written with MTD tools like mtdinfo and
mtd_debug. Previously, the driver failed to build or crashed during
probing.

        bash-5.3# mtdinfo /dev/mtd0
        mtd0
        Name:                           vmu2.1.0
        Type:                           mlc-nand
        Eraseblock size:                512 bytes
        Amount of eraseblocks:          256 (131072 bytes, 128.0 KiB)
        Minimum input/output unit size: 512 bytes
        Sub-page size:                  512 bytes                 
        Character device major/minor:   90:0
        Bad blocks are allowed:         true
        Device is writable:             true
                       
Thanks,
Florian
---
v1->v2: Rebased patches and fixed the hotplug issues in other sh
        patches.

v1: https://lore.kernel.org/linux-mtd/20251117224408.498449-1-fuchsfl@gmail.com/
   
The original v1 was postponed to fix the hotplug issue and other runtime
panics, that are fixed in the following patch:
"[PATCH v2] sh: maple: fix empty port handling":
https://lore.kernel.org/linux-sh/20260426212714.2286437-1-fuchsfl@gmail.com/
 
Note that in order to use the VMUs while there are empty ports, it
requires the above patch.

Florian Fuchs (3):
  mtd: maps: vmu-flash: fix build error due to missing include of
    linux/device.h
  mtd: maps: vmu-flash: fix fault in unaligned fixup
  mtd: maps: vmu-flash: Fix NULL pointer dereference in initialization

 drivers/mtd/maps/vmu-flash.c | 7 ++++---
 include/linux/maple.h        | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0


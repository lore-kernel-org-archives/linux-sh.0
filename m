Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB38B322DA8
	for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 22:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763419614; cv=none; b=rv662Gk0QlcqEKU9dt7DWlBllWK9F1q+AOlzj2zl8tmareR7zzRwJsVvGBHvHTbiIIMEgZ9fvNv7N0YyhmIGgNYpwf0eKxx2yEkFyu5WFklarEXXQsj0ETkf9sNWq4j2a4LErlbylIbcdTRzRjcd77QJONw8cRyUy8U5PFtIas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763419614; c=relaxed/simple;
	bh=waB+Bl+gqyfn68lDq5DMzr9orLK8RdiDWJj9QfePFn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIYpN36UCQI56++VD0xmHIh0gSLpoNjM/ki6JSBnMaI5zBoG8nam+HBbuAxVip3LSiYbWSdRTjmXNGrXMSvwMRyl/qYK7g5MZzC9j1xI4LjNpI/vDeYRY+7hMXdJbyOjX6PirzK6ffDjxVoCr+KHjdOZFS4c2/M9xrBKQiK0miA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMX4y87j; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMX4y87j"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so8265817a12.1
        for <linux-sh@vger.kernel.org>; Mon, 17 Nov 2025 14:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763419611; x=1764024411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQx5Zus/kcblPuTEEWB+BahVU8fEHd8HqEQoD7L2fXk=;
        b=MMX4y87jiYXbx1g6SuiGnuHmKGd2Q0i7OxGJhViltZn20xrcUKfh19tf7aBWPKgOon
         YMrlANpoiCFu5eawkVft8BlnS89bbMHNRwsP7EOlu6d/u87oxQ4qQzCZsrQSbOnpV4zg
         bKl+knfsfLHu4MmWds4RoHU+E8ofeyfqKICqpaG3dmvrokWfAOx3gbpNy7lw/CdheSjJ
         uxwYC6nPlb6nr21jOF/YGou6ZIgo42/UgLJK5iptOZ09cV48upfMSlF/v9HvA2Ib6ATz
         x2xvhsLcF9aOA410d1c7Xt7MIsAWUTXXVm0Rpsozry4vUgGNMKmXqnbqLDiZyLfiVsWe
         tLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763419611; x=1764024411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQx5Zus/kcblPuTEEWB+BahVU8fEHd8HqEQoD7L2fXk=;
        b=dN9wZeaAPUOgR76Jr6FWiVkfMOrb7mRo/uEePFXZ+Ozk9YTrXvEa1PdOM55uHVfZs/
         gDlCa7ZNVbj0rUb/8/Z4cyUoXad/8VNEjDXJJVhHv65HggRobgFSqCbRHWmJsWAceWSY
         hKTGI6alPcf1d/psrTplmG3E1mvAA7M5DTgh+UpDprsYyFUihi9kZf/nxqn2C+Q13toh
         g/d6fuyRS2kjDE71oCOU+0/qZLPn3/AvkVDCFJiur41WNkIAjqRNagJJ9z8DXiq9GVx/
         tYXa++h20PykOpaqcrfX3TUig+VcUSCf+JlgVbCW+Mv1zET1zlB+d0xQ3GUZ1/4hpHaz
         seEQ==
X-Gm-Message-State: AOJu0YxgusBfiV6TsQ3WrKDuCXqH36ctUs7dPGRBzsWWmCa6hTvit5GY
	Y+F8c6BiUcU3yKx95I1CuJyeHTqOEPWfZpmpqWOLHLUMQslGWku1AIuLKzN87LQ=
X-Gm-Gg: ASbGnctWbsE/25bLd06rAlI5coKL6tbLAquXPHmNT/RA1+ndeB5t9rfWpSJqamdeu7R
	3neG8kvXD5/YRTRp4p9ZgM/K2mcP9Vp6BQus8pFjW75g1g3AFNbqQ9iliWcRtFUvnVPjxaRZau+
	Mjy6D0CASR7ZvJnBOrKq702k88Uq4Cp46NTn0Zt/4DyCyhTjqWqyLO0Nv/+HUZJadmp2dCjQw07
	n3on68l50rkrNCBNaHakdSm+PZynjHndBEOlAoUm49yA5q6zaW4f3RTocVtowK280sRzrPrtGF6
	cpuRWgzv5oFZauMJUON7urBLNrHbLqUlPPAmOoLTFSW90Nv6/nUVWSjLMuzYaIsDOo1ncfnx6tG
	WPSTJuv6bBLB612A7SUcqiDxuknUaU6TQNJaJfXxmup5MelCkoQFfSANLFUsYa0VQSYMTk2RDhb
	Ty8glx+GkPK//kToxkF+j1U+dYictndZGkPla0C3ZqMyzeKtb2kqELlx8muGy/XVMxBGvhpTXkj
	c4/7+ExwQIAe/TiSP1oCKw9
X-Google-Smtp-Source: AGHT+IE7k66LCLymhdfQOLn0JxvzsVErM9Ncx8SurVFaS1hwSAHD12i4vAoErL5LnOE7oFHNVJw/uw==
X-Received: by 2002:a05:6402:90b:b0:643:8301:d10f with SMTP id 4fb4d7f45d1cf-6438301d619mr6480812a12.31.1763419610795;
        Mon, 17 Nov 2025 14:46:50 -0800 (PST)
Received: from localhost (ip5f5be9e8.dynamic.kabel-deutschland.de. [95.91.233.232])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-6433a3f94f8sm11266265a12.13.2025.11.17.14.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 14:46:50 -0800 (PST)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH 0/3] mtd: maps: vmu-flash: Fix build and runtime errors 
Date: Mon, 17 Nov 2025 23:44:05 +0100
Message-ID: <20251117224408.498449-1-fuchsfl@gmail.com>
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
be successfully probed, read and written with MTD tools like mtd_info and
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

Florian Fuchs (3):
  sh: maple: Fix build error due to missing include of linux/device.h
  mtd: maps: vmu-flash: Fix fault in unaligned fixup
  mtd: maps: vmu-flash: Fix NULL pointer dereference in initialization

 drivers/mtd/maps/vmu-flash.c | 8 +++++---
 include/linux/maple.h        | 2 --
 2 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 97315e7c901a1de60e8ca9b11e0e96d0f9253e18
-- 
2.43.0


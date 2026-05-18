Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3213E1D1C
	for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104832; cv=none; b=NAfU7J9ZPuG5ryoBnncmAUvtF5QVziv4XfG23lvVshjEJRH6U+INdfjVkb7zwfhx7XJj59Ess58CvefvqEv4aLS965w4a13Ds1E+LAcWVX31D9iQvkAs46hNmbeKHWh73fbyaRSfRzNnoqxrJ8yenH/t3kx/ChHVRyMEiGGOnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104832; c=relaxed/simple;
	bh=youasXlMRX9ful6QDGAzpUrQ9X92iBZf9ThkyrDCVjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KnoI2E7XOe0b2S2RuhCqWn6ybhfs2eQ64gmCpD+4J/0qsYq4Fz9w2CMvD68IqZi/nDEp8aP17mX9QQzXiPDsZ3HzpQ9rWnI807oiSGTLf/zUWs4qgtSx/7LDDXkKSVjMZiCpW7v2Fycgxgkz24bHh/RFaQzaVkGsXDCYGE0zWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qvd3Flxm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvd3Flxm"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so15877925e9.2
        for <linux-sh@vger.kernel.org>; Mon, 18 May 2026 04:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779104829; x=1779709629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HP1FkQP3upUXw27uw6hA2g2czB6GYP9RbzsbFRYmzIQ=;
        b=qvd3FlxmKmYpnDsB8SP4FymgVwHw54GhRCok9iHeFZzfOP8T3xaigVjywKcD+MdC6Q
         ehDJPMFMEYQSi3A2S/pb2WOh79MbDYvMIyY1zHSTIZSH4xEakTm5yNWiOwUEIhA8g1Gb
         7jCtDgBScxY0lO3K9gVf0/DzNcbBTGaw+kX70Q7jt1DPvvk3rl8r3piKbptjF+RGC2F+
         fH70d40ET0Nxbh7o9FiaRuMPlIKoBzRTnFxdRKjd+62pzv4plJ5klietqYQYtcMeuOQN
         3tIFx2nkUmQSj5Ed5Vd+x4jbwH3aS6Hfkf2Gy0s0AVijKxNhrkU0jgQ0E6Ly7S7XsV0s
         1v5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779104829; x=1779709629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HP1FkQP3upUXw27uw6hA2g2czB6GYP9RbzsbFRYmzIQ=;
        b=Tyay+XrbeIBmP+mHonIc9iMmgkreYDD+6VZ8EtsMShqquOlTV8NzarlCCm39Ek2F1K
         lbCIR3NeD6QzqVoOHo1BEGa+/JGa40sc6SgXxK67IsGce+B2tNy9vOQL1qFY5ohSqmU1
         kEkNHuyBZYBRpM9IKAG+8iUIcREl6pOzTrPr2c3i4braweMGnYg8yywx7A6Hytwvzt+i
         emq1g+ExpT/6wPcc2gpHYF9lNDexoC2hsoXSwSfohoWwdJqJ2wROLQ/jArVLGmc6hoIL
         TcgX8AdjjP23yEkL0UGbXGj8N7bAhHnj9G9ty19xPivYv/dVLzF4B9WJpBnbzto1Hvgq
         YHjQ==
X-Gm-Message-State: AOJu0Yy9JPACcV+fJUOo6YnjmwYfle37Sy9PUGOgiykdWZMyIqhtaN8n
	SCO2DgqPBWvLb6sBnnuqRBvRsOI4Tvn2uyg+iwk0M3oxpGKdtLy0qqc=
X-Gm-Gg: Acq92OHtnnpBhW0rpUzsrnTyXxUX8Mj05FY3vjoEzMVdAt9NjpY7V+mAyofvggs9GHL
	mvZyGM1jMxZi9FiN0ck1quHwTBL1mpIo4OLGA7atQMnMfOX8H4Se0apuHYp7opXJVGYKjNKdEFL
	aJXUK4AZgF+ca2gzYSrj0qtEs+DMsMMVToYEeRAl/E4YNJ3mSW7P3Rl0JvVAAHu3Bh1SuwsVYYq
	qGpLCMtwRKGQtwvLCNvRRdRgTNsQcO8TrKy0q51GTVAB+l8xe6lGZl2zQmaL+kgV0oIgOdKXZdB
	C+ILrUr6BljTayTaqI9wbXg3owiey3zqxOpJHJm9lmBcdFCyXVKloMWvAAFsM7uAtQUvOmsSfZB
	HmYekXvpArFtIYO0xW1h7Olv44P2wzN7QItUIf5fC64gZkeVClgUz86EWqW/fifbeU9ceHLOaZg
	cIaAxwQ/aODYoNMhjwiXX/525cHu1LbTP3gGzj52juocUtyLMwcaDwcve2lj9fE7zdoyn8ZAT1y
	Rgym8pi
X-Received: by 2002:a05:600c:3f0f:b0:48f:99a9:bbcc with SMTP id 5b1f17b1804b1-48fe60ecb9cmr207456935e9.10.1779104829093;
        Mon, 18 May 2026 04:47:09 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:f15c:fd38:3fe1:9653])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45d9e767d0bsm35203411f8f.3.2026.05.18.04.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 04:47:08 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Adrian McMenamin <adrian@newgolddream.dyndns.info>,
	Florian Fuchs <fuchsfl@gmail.com>,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v3 0/3] mtd: maps: vmu-flash: Fix build and runtime errors
Date: Mon, 18 May 2026 13:45:18 +0200
Message-ID: <20260518114521.81564-1-fuchsfl@gmail.com>
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
(enabled by CONFIG_MTD_VMU) and the related maple.h. These changes were
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
v2->v3: Add Fixes tag to respective patches, fix subject to previous
        commits
v1->v2: Rebased patches and fixed the hotplug issues in other sh
        patches.

v2: https://lore.kernel.org/lkml/20260427114750.2480900-1-fuchsfl@gmail.com/
v1: https://lore.kernel.org/lkml/20251117224408.498449-1-fuchsfl@gmail.com/

The original v1 was postponed until the hotplug issue and other runtime
panics were fixed by the following patch:
"[PATCH v3] sh: maple: fix empty port handling":
https://lore.kernel.org/linux-sh/20260515181115.3244161-1-fuchsfl@gmail.com/

Using VMUs while some ports are empty requires the above patch.

Florian Fuchs (3):
  maple: fix build error due to missing include of linux/device.h
  mtd: maps: vmu-flash: fix fault in unaligned fixup
  mtd: maps: vmu-flash: fix NULL pointer dereference in initialization

 drivers/mtd/maps/vmu-flash.c | 7 ++++---
 include/linux/maple.h        | 3 +--
 2 files changed, 5 insertions(+), 5 deletions(-)


base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.43.0


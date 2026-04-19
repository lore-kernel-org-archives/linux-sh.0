Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AFF29BDBB
	for <linux-sh@vger.kernel.org>; Sun, 19 Apr 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776616153; cv=none; b=PD5feQNVpmP/h9D92VWOHhr7g1AoVxaAPFzjVrwzVoOCXQ1W69QKODEyfRzcWL3ih7QUoLNYA7s6+puNP/aDW+PJgBm1TKXsDyJ3/yV+HEt8HWnoKEHTcwRXbijWbQK2m1ORoxmGbsQXpPst9fhaeOCDeLS8XzeGbTwxBjnQjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776616153; c=relaxed/simple;
	bh=xOdVN/0EMkmXQwQWgtbNpl75ReFL2FTwywJIC/XOHlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvLA1VsYemG9ckxbRt/Fr75sHr1iq8lhcvY3aYK49LOhuV68OJMjqOvEgSxpX9Xp95QUdPA+kZ9YQ+WHEk6QnRvyIIQoftrnyfjOM9dFwZmsmRtPAHLCeAUKgwYqU+zvFPl1LlqYdq1olPGBdwYCyrRBhCNqlfOfm+XLksH2w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv5mnyf/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv5mnyf/"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso23400715e9.2
        for <linux-sh@vger.kernel.org>; Sun, 19 Apr 2026 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776616150; x=1777220950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lw7gLEFgQPPa5Wc0Jw8A31UUBHFJTGmLpr+fXJ3IdcI=;
        b=gv5mnyf/f0MI9ndGF0W0cUJRiv6wEYkdyb8nRGkvyCv35NcaEsnA8X6ucQa9/9zFxY
         fdddRqUz/eKj4RXQxhrLQvCQrooY2euj6TwZtrr2gVvBnO6XRLD93VZWWgHcKOBVh1V0
         ELjktwiWwFz/C+yqIbiaxZT8669Ei1MUyfvj2YCp6jhZnm+2Pjecqbiy6ygBN1yLENM4
         EvZhDFKs3c0MpLHlGHxnMETi7AaC1f0xOye7NmLK4A0HsD3kAnuxd0rLPIew2hc5vToj
         k5g2awHe1Fi3ZHJuyNOmB60itiljClhV8nHyz3zxpKhk8arVSaE3TyhsUaegtPGWU/cn
         Sadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776616150; x=1777220950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw7gLEFgQPPa5Wc0Jw8A31UUBHFJTGmLpr+fXJ3IdcI=;
        b=ZALOcrNyM6Bwz8oZRPHeENCAJaj4rHKGmr+ndJy7RkmsnqPCWHDkX872AE4sQVF80h
         X5nLvOZpZd/r2wceKxLrhD4w4Wn1BrbE9G2tRVZR2InKeAGXESG3bBt96WZnRRvilHdh
         sNk8OFGLxr5FMqLsZK1s1k7VpeJo6ISKY45+hjpKgxCsd4GcaAbODoCqQ1x/55wd1Yv4
         WKuDzVEgJVTS6PYyx93vdZsaosus4WrZXRVMeRnp7hDuvxkG+7veONCbiFHS+PpsYkJg
         rzbyxzMY7Bm7m/Fz5EFiV2IF0npqlvlZ11ZcDDiEDgEE+uYjrr8g4u0PyOk16/koQOwq
         VBpw==
X-Gm-Message-State: AOJu0YwuT91+INPmaVrt4+iVE2bibREzU8OJwqV3fA1ll+PQp2j4Sq2p
	mgESZxVd1fMruR5nnM/TI3wKY6ybLRreimzplsBfoM4EBXkvAI+CrrfHVHTPwzI=
X-Gm-Gg: AeBDieuj5+F/ti38OBNutjITDFoXljXjl0sJ4BSKJbUIuldAZGwoDr3ovyjiXmaATC5
	UpUdiOoybLIyldLByR5E6DdUCt/V1+YIEedtqXZVyorNf+b5MNrwfZgHuGv5goBLAq9NEJTZhuw
	jC5ET6DATcH+FY4uNt1IQWs2D1k7m6gj1WfMkRuow7ZjOzIouoxooT6YneTXMn8E61Lo+3ioFOE
	QwggTYl3BJAGphgdLILy9CqvTEaSCM20Nf3aRO3OuCrsoYlY07jxJFSld1L707DynA0tNmnJhbi
	kPoDq2ASWM7wkPbrJqZ1uENgSleN8ORHXKfr5QNaVUac6lI3/65p1YG/9jBoolaKnaVak4OIrPb
	5QIwTYHyMXsVene9v1PbbtW2W18Q81uJqDOxwZ/4651/blfbOtk+TT3NdTvPuQBjZdCayYDliec
	oZ5K8BuJn9keIHgp18YR68c+jW3PvZLxtXXprt6zgJzSd81U1q/yrOZtRnxjPJXRymmW3JsLepx
	uF3WtJN5MsJyT25ahQ=
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr148291265e9.1.1776616149505;
        Sun, 19 Apr 2026 09:29:09 -0700 (PDT)
Received: from localhost ([2a02:810d:4a94:b300:e7d2:9a54:d18c:d3f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb74c7a2sm69092445e9.1.2026.04.19.09.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 09:29:08 -0700 (PDT)
From: Florian Fuchs <fuchsfl@gmail.com>
To: linux-sh@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Artur Rojek <contact@artur-rojek.eu>
Cc: Adrian McMenamin <adrianmcmenamin@gmail.com>,
	linux-kernel@vger.kernel.org,
	Florian Fuchs <fuchsfl@gmail.com>
Subject: [PATCH v2 0/2] cdrom: gdrom: fix block I/O and capacity setting
Date: Sun, 19 Apr 2026 18:28:21 +0200
Message-ID: <20260419162823.2829286-1-fuchsfl@gmail.com>
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
prevented ISO9660 mounts from working.

The change was tested on real Sega Dreamcast devices (PAL-E, NTSC-J,
NTSC-U) with physical CD-R discs and with GDEMU emulated discs. Before:
Oops on mount and an unusable drive. After: Successfully able to mount
and use the inserted medium.

Thanks,
Florian
---
v1->v2: for "cdrom: gdrom: replace port I/O with MMIO accessors": Don't
	use helper functions with io.*_rep(), but writesw() and readsw()
	local in the respective functions. Improved failure case of
	gdrom_update_capacity() in gdrom_bdops_open().

v1: https://lore.kernel.org/linux-sh/20260405082330.4104672-1-fuchsfl@gmail.com/

Florian Fuchs (2):
  cdrom: gdrom: replace port I/O with MMIO accessors
  cdrom: gdrom: update gendisk capacity on open

 drivers/cdrom/gdrom.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.43.0


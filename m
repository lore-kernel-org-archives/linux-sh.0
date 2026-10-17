Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37023EAAD
	for <linux-sh@vger.kernel.org>; Sat, 17 Oct 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792210478; cv=none; b=fJ5h5q74tVMZAmAgsKpIG2Bqj77NbWIVDvbLGW1rmBFQty7pkMs9/xJCFPJnOVJaT74xSngciAzCVhwjpE6NYYDgU3eG/JGG5LI4TyY0fMj+hoOEMQieTbYLdI64mbu9zFHW+lEHxHkzR+84k3T1UwXym83KfIee0akP3yA4lyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792210478; c=relaxed/simple;
	bh=BriZC6DxZrhy5N7Op3EpDAZGaSlOcuqXDcaA1Y4+xCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGcLRrawFlTW4d7FQcB9Qxp5y7D6y4UyYZvOtM5I9P9xksGYjAJPVeLV1QZrQlV9AEu/A9SHYWBTsmb08k/Xmws5xnaHDtZ1EHLLA49W1NUuyOa3TWE5rJUjcI32kb4l6nNNckoDowXZm38tkUrtBUtZ6W8JBQI1H1kU/j3Dhw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b=PGcCkczt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="PGcCkczt"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ace9e6e1a5so460313a91.0
        for <linux-sh@vger.kernel.org>; Fri, 16 Oct 2026 21:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1792210476; x=1792815276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OgDC/ta2AGryucvreeu/Kd0cvPv9S+G98Vpr8co/uPw=;
        b=PGcCkcztfa5r4uN7V6QPvbDFLghssh2OuFlAn4J05CUR91MWPaKo1q6rwRTERkeaLg
         MeCJ9cAF51qR71En2k5PJ7qm40c5ZkLEBtnfRY65lm4EWR9ndAYdzQdf1US/8knN9H7h
         qiGrG0ouUaEy6kKPNdT5Ye+KfM7BJNvyMXyfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792210476; x=1792815276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OgDC/ta2AGryucvreeu/Kd0cvPv9S+G98Vpr8co/uPw=;
        b=weOYxKIPkc6LmtxKmFZNG6s3DJsBUUgBD4igix5qAozRX8NHwWp09n9xa6x3Aa0Pkk
         ktQ6idY/9eEB47ZYsZkqPk9PWMZ06hBEvQGqBAqUR/PVxTGfXoSFhr57q3G5Fet2Wm/x
         UixhsKQeRwEKUppvfJkmHTgEexL+IA8QQG/3L40zDT0OLNcY1jYYq4fJxeyPJg3yH9/H
         sh30S+tuIJ7p/d59qpalDIHVTS0aph2J64dzE5Ggh0uIoVOWhFQxfPNme/zobBPWpgBD
         ABYJXBpEndFyBKvlES5g6uvRw/gmacodOxD1zItCK/yHEsbGd39UsTccrN7PqPfnHq7F
         D0pA==
X-Forwarded-Encrypted: i=1; AKwUvBxAES+XxaxLU2HGCXPbRA3a+i1iRThDfY8DSL7qcrKy9SQ4l3867Nl0WsMHmhQPVl+F2qktdbtRyA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKA21Oxu778SJOrLi9tiJy0VQj5Zji6FBbbaf7MndjZxCuEb3kh
	v/W1qVBjunhPiGva6PB8h/bBbxUXydeSgLv61eudEy19PIWgg3dTBGxaVzhxXn+ul/k=
X-Gm-Gg: AYBFou1IY12y2wSGCUlt8XCPUklXkTlD/m1tRvm+rzbwLmVbNh3Ry3U1HyQKbWqrN06
	i1sd5X76XqcEsuiKeTpmDHd9itzFhCEM4VOutGe2S1gux2Qs+GgRIO+2wRksZ/hLldrelJnShBu
	5vgXv9YiXr6exdOEhXH8eEHY/LMOFJEx0JxagXwDC9G9T+YXjHNM+LA7/H+7poW6U3YTs9ypGOC
	khgUUbxb4bUQH0xlnxPA7MMpM8F7FRBl+bfqUKdqNBGd/+aM+YtzPfsdM0ZvdbYEDsmhaA77QKa
	kzAF/jlnd7BLTzL+PfRSqLxHrTK810JX8QKVueH6UXwhV9dqIvw8Gu0cpN1LJIxZ6Z3EVIcOEkZ
	4hN5/qJ4QJZHqB6QMaUAWrGyI/sjsT9r+x2ptKl1jBRoEySKcjGZk3CjO7uQWEGVjzW/evjCedG
	vzBSmi6nZiQVpeYtx4aA0C8HwRAOZoNQbjceIyqz4fxmKzy5O3ervetyVKGT7u8SeG/jU/tq582
	3lH9yukQ6a+1zLQeBpq39I7E8P9FQ1bwF+cav8J
X-Received: by 2002:a17:90b:4c92:b0:3a6:f6b0:30ce with SMTP id 98e67ed59e1d1-3acef55d641mr1125765a91.36.1792210476334;
        Fri, 16 Oct 2026 21:14:36 -0700 (PDT)
Received: from shiro (p1722188-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.142.188])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ac945e72c6sm11609714a91.5.2026.10.16.21.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 21:14:35 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	linux-sh@vger.kernel.org,
	linux-ide@vger.kernel.org
Cc: geert@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 0/2] sh: Fix IDE on landisk
Date: Sat, 17 Oct 2026 13:14:17 +0900
Message-ID: <20261017041419.311921-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I dug out my landisk to look at kexec for Geert. Since I'm lazy and
LLMs are good at fixing bitrot I let my LLM work out how to get
it to boot again.

There are some other issues (perf is apparently borken, there are
some issues with the decompresor and big kernels..) but this
seems to be the only thing stopping it booting with the defconfig.

Disclaimer since we don't need to give LLM tags anymore:
- LLM debugged the issue.
- It has been checked on real hardware.
- I have checked the IDE driver patch, cleaned it up and
  cleaned out massive walls of text that LLMs seem to like
  to add but I have left its summary of the issue in the commit
  message.

Daniel Palmer (2):
  ata: pata_artop: read the ATP865 mode register through pci_iomap
  sh: landisk_defconfig: enable PATA_ARTOP for the ATP865

 arch/sh/configs/landisk_defconfig |  2 +-
 drivers/ata/pata_artop.c          | 12 ++++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.55.0


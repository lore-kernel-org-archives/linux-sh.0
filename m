Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F13DBD62;
	Fri,  8 May 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778241974; cv=none; b=D+Aum6KrYdYzw5vpU71IwYXV8NkGZmW2f7qpYgICuzBG+evlptt2v8jihUURGxNnEm+mwl6ep6rcPVjttd1z9acarSAWOTYVP3prlnTLW17UmChlgR/JBN4NQKOtkOCbz72RKJCDMrol4HpEEKJliUZ3xZUHdk4WCNHjKH474No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778241974; c=relaxed/simple;
	bh=PNVFWOQaVgJtbLKnyq48kuBTs+YYBu67j9msWdtYLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+70kQep3P8VS4cN4FfYErzK6ZdDdJRzQmDA07ZYpm9GW0OwaOWpOxcTCnBs+e9x7oop1lxl2ILDwcgGteibcVPZsr/0aKndXrhIt9YDeNtWzFLeAI+VEWkdHvnHdg187gr5biyPC4mtF3+cgMsSGeeypw5r+pSQb6UA2KTwS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R1hRB6KI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1hRB6KI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBE2C2BCB0;
	Fri,  8 May 2026 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778241973;
	bh=PNVFWOQaVgJtbLKnyq48kuBTs+YYBu67j9msWdtYLM0=;
	h=From:To:Cc:Subject:Date:From;
	b=R1hRB6KIrpQDJNbGqUnweQo5yUZX6G1wqqo365wu1/yDNEyKiXpHgjgjSfLrZDDMb
	 jfoNrRS/f1TbavK0vteS1U4eO52qTnmLRmE3a7wwmVrkDiCC95N0ZoqIyr4uaupCkD
	 s69oQ7N04xrHF8E8kLXvqa+eJopgKMG0XhEuQj3T+UZPHJLwSsGQFyOr/Pl0bakG7v
	 KjnxD46GGZTIWHSk0t75M5m50HYSPNxN2U+WNUO16wskxxgAsAThx7l/6vaEjloE6c
	 wJi1bK/z8ZJur4/n0sq8sSvmmkqi6cYv/W9qtpgpTHnEhz235h+8qi2jF3lQwePkvZ
	 /y2oteX2mHVWw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wLJy7-00000001mrA-2oC9;
	Fri, 08 May 2026 14:06:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] sh: kfr2r09: fix i2c adapter leaks
Date: Fri,  8 May 2026 14:05:59 +0200
Message-ID: <20260508120601.426115-1-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kfr2r09 platform setup code fails to drop the references it acquires
to the I2C adapter.

Johan


Johan Hovold (2):
  sh: kfr2r09: fix i2c adapter leak on USB gdaget setup
  sh: kfr2r09: fix i2c adapter leak on serial console setup

 arch/sh/boards/mach-kfr2r09/setup.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.53.0


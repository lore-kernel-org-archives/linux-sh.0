Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD41B974;
	Sat, 11 May 2024 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455048; cv=none; b=SxLcG+lbBsdq4wkdnjv84uNHvUEKTt8N0+RaGzXF8pl1Ug8VIlRmI9ty39w2KD6OnI0VxbfgZZB5hc5pRiwbC/U7NU9JzrgaZ3TI+zYBjcHTbx1YajcxjsSLbeaGHOe4zKza4nQZRgh6U9SxxHbGhOP5dcsxNb3NvZtSkTtY7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455048; c=relaxed/simple;
	bh=o38WDiwjHTrWZ5SJmgAhXw6gq1MwIlG3qU3F0nw8CDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EE1HC4AT7ylYmeAPjtIYbaAl/kPzjOXuK/A/M5sLdJmX3bmzy93SSSwdw87mWbKzupaioFfXwoDRp7UjbRR+AahGR9k14twI9bWBTccYCQPzFxoTXg3tgTqO8y6ARaZmhb5s89prpyjbiUjiaFv+5AbaBciVvVfOEY0Dl/ZpWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id E2640E0004;
	Sat, 11 May 2024 19:17:14 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Paul Cercueil <paul@crapouillou.net>
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 0/1] Fix Dreamcast GAPS PCI bridge
Date: Sat, 11 May 2024 21:16:13 +0200
Message-ID: <20240511191614.68561-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: contact@artur-rojek.eu

Hi all,

this patch fixes the G2-to-PCI bridge found in the SEGA Dreamcast
hardware, by setting the appropriate IOPORT base offset.

While being just a simple change, it's notable to mention that, when
combined with the DMAC fixes from e82e47584847, it allows Linux to boot
on the SEGA Dreamcast again, probably for the first time in a long
while.

Artur Rojek (1):
  sh: dreamcast: Fix GAPS PCI bridge addressing

 arch/sh/Kconfig                       | 3 ++-
 arch/sh/boards/mach-dreamcast/setup.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.45.0


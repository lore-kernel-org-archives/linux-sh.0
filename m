Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3F62EAE4;
	Sun, 16 Feb 2025 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728587; cv=none; b=AWwCesx9JBFn3a/xOnIKLV3ZA0m+egEzUtJAyvbJ6lGVo/ku4qcyF596MltRErWMNjVV7PTzbCbFOiwUFM4+eJCi+N0AMp1s6bEjPcv9U9aI2HSmYmd/fxKovuJrOr6YXrSQxLdyJAoT4ty/eljslPH1X72jBhzMBFt/3rbcTp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728587; c=relaxed/simple;
	bh=FMY76YmZC6MfjEmhw9CcYdxhzlkfSrDD5ZYtT+X3eaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqLWnLK6KeTV8xps9GdQgTI44s3dr1cRCmraNgwjRCA1jPUpRzPsrTxQBkHM6UPwBWnFP9cl05aWDgXpQLV1p0zk7QoOBOmk57F9JGFU8tmlIWxcKZM6axwIxYtghC2GpW2Cwi8y63mlIf+j1DeUdgQS67L4Aiy7Himvq1HWoT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id 98F9244389;
	Sun, 16 Feb 2025 17:56:14 +0000 (UTC)
From: Artur Rojek <contact@artur-rojek.eu>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	"D . Jeff Dionne" <jeff@coresemi.io>,
	Rob Landley <rob@landley.net>,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 0/2] J2 Turtle Board fixes
Date: Sun, 16 Feb 2025 18:55:43 +0100
Message-ID: <20250216175545.35079-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehieduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnheptdeileekieejheeuhefggeeluefhudetvddtkeehgfevvdffuefhleevtddtjeffnecukfhppeefuddrudeftddruddtfedruddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrudeftddruddtfedruddvledphhgvlhhopehptgdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrt
 ghpthhtohepuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihho
X-GND-Sasl: contact@artur-rojek.eu

Hi all,

this series fixes boot issues and allows J2 Turtle Board to boot
upstream Linux again.

Patch [1/2] enforces 8-byte alignment for the dtb offset.

Patch [2/2] resolves a problem with PIT interrupts failing to register.

Even with the above fixes, Turtle Board is prone to occasional freezes
related to clock source transition from periodic to hrtimers. I however
decided to send those two patches ahead and debug the third issue at a
later time. 

Cheers,
Artur

Artur Rojek (2):
  sh: align .bss section padding to 8-byte boundary
  irqchip: clocksource: fix jcore-pit irq request

 arch/sh/kernel/vmlinux.lds.S    | 15 ++++++++++++++-
 drivers/clocksource/jcore-pit.c | 15 ++++++++++++++-
 drivers/irqchip/irq-jcore-aic.c |  2 +-
 3 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.48.1


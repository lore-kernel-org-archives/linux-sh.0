Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F119D881;
	Sun, 16 Feb 2025 17:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728589; cv=none; b=KXPSWLQ7pK1TvppNhsvlahnudbRJOMBzuHeZxQ56LZqXJDPuL8wPMRVp7CCzSvcBti/ZHdPg4wTsIG/E3l9pit4Q0/kqbiHW+bo+ehLqbn/e5YrpDWNO9xfGoQqFWkUC97rgRs5RoKs5bulzgNcJwBHXeN4M1D4z0OgR3RS3+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728589; c=relaxed/simple;
	bh=GbqbGRkA0ij276UplGyHztWbVzm9XhSCf2P3NGSMUZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HQrz8iwjGr/3AUW+NwtUCX+rHod7YsEwmff4EWG3ZgcyBWangaQWXikCUACa/1X4vRmtqCjj39PtIM7WcsEeoaKSYcTuotaLHMm9Ud3MIFPcAZwNdJ8F0XBkWC7j5nDjf73tC1SudjUQNMV5mCI6ERku0I6nI1BQ25S0Xf7gVVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id A4FBF44384;
	Sun, 16 Feb 2025 17:56:18 +0000 (UTC)
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
Subject: [PATCH 2/2] irqchip: clocksource: fix jcore-pit irq request
Date: Sun, 16 Feb 2025 18:55:45 +0100
Message-ID: <20250216175545.35079-3-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250216175545.35079-1-contact@artur-rojek.eu>
References: <20250216175545.35079-1-contact@artur-rojek.eu>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehieduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepgedtieevjeffvdehffeiieehjedtudethffghfefvdevfeetteevhfetledtudfhnecukfhppeefuddrudeftddruddtfedruddvleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeefuddrudeftddruddtfedruddvledphhgvlhhopehptgdrlhhotggrlhguohhmrghinhdpmhgrihhlfhhrohhmpegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohephihsrghtohesuhhsvghrshdrshhouhhrtggvfhhorhhgvgdrjhhppdhrtghpthhtohepuggrlhhirghssehlihgstgdrohhrghdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuhdqsggvrhhlihhnrdguvgdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvp
 dhrtghpthhtohepuhgsihiijhgrkhesghhmrghilhdrtghomhdprhgtphhtthhopehgvggvrhhtodhrvghnvghsrghssehglhhiuggvrhdrsggvpdhrtghpthhtohepjhgvfhhfsegtohhrvghsvghmihdrihho
X-GND-Sasl: contact@artur-rojek.eu

The jcore-aic irqchip does not have separate interrupt numbers reserved
for cpu-local vs global interrupts. Instead, the task of selecting this
property is being delegated to the device drivers requesting the given
irq.

This quirk has not been taken into account while migrating jcore-pit to
request_percpu_irq(), resulting in a failure to register PIT interrupts.

Fix this behavior by making the following changes:
1) Explicitly register irq_set_percpu_devid() in jcore-pit.
2) Provide enable_percpu_irq()/disable_percpu_irq() calls in jcore-pit.
3) Make jcore-aic pass the correct per-cpu cookie to the irq handler by
   using handle_percpu_devid_irq() instead of handle_percpu_irq().

Fixes: 69a9dcbd2d65 ("clocksource/drivers/jcore: Use request_percpu_irq()")

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/clocksource/jcore-pit.c | 15 ++++++++++++++-
 drivers/irqchip/irq-jcore-aic.c |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/jcore-pit.c b/drivers/clocksource/jcore-pit.c
index a3fe98cd3838..82815428f8f9 100644
--- a/drivers/clocksource/jcore-pit.c
+++ b/drivers/clocksource/jcore-pit.c
@@ -114,6 +114,18 @@ static int jcore_pit_local_init(unsigned cpu)
 	pit->periodic_delta = DIV_ROUND_CLOSEST(NSEC_PER_SEC, HZ * buspd);
 
 	clockevents_config_and_register(&pit->ced, freq, 1, ULONG_MAX);
+	enable_percpu_irq(pit->ced.irq, IRQ_TYPE_NONE);
+
+	return 0;
+}
+
+static int jcore_pit_local_teardown(unsigned cpu)
+{
+	struct jcore_pit *pit = this_cpu_ptr(jcore_pit_percpu);
+
+	pr_info("Local J-Core PIT teardown on cpu %u\n", cpu);
+
+	disable_percpu_irq(pit->ced.irq);
 
 	return 0;
 }
@@ -168,6 +180,7 @@ static int __init jcore_pit_init(struct device_node *node)
 		return -ENOMEM;
 	}
 
+	irq_set_percpu_devid(pit_irq);
 	err = request_percpu_irq(pit_irq, jcore_timer_interrupt,
 				 "jcore_pit", jcore_pit_percpu);
 	if (err) {
@@ -237,7 +250,7 @@ static int __init jcore_pit_init(struct device_node *node)
 
 	cpuhp_setup_state(CPUHP_AP_JCORE_TIMER_STARTING,
 			  "clockevents/jcore:starting",
-			  jcore_pit_local_init, NULL);
+			  jcore_pit_local_init, jcore_pit_local_teardown);
 
 	return 0;
 }
diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index b9dcc8e78c75..1f613eb7b7f0 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -38,7 +38,7 @@ static struct irq_chip jcore_aic;
 static void handle_jcore_irq(struct irq_desc *desc)
 {
 	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
-		handle_percpu_irq(desc);
+		handle_percpu_devid_irq(desc);
 	else
 		handle_simple_irq(desc);
 }
-- 
2.48.1


Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D8419D083;
	Sun, 16 Feb 2025 17:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739728588; cv=none; b=s9Sc+O1WfMGdtoe/yYd8p9cX9TrrXu18u2vzyvNhfjKrVpdHv97gG0MmgF8hPtvRJC+iTZbCQxQhWS+CMt11Jq5VkKsHohj0LJDPf2zEyHeeZuR3L4+Fh0rux5exCA32yl4fsUkXFl4izJsP683shmBuaP7i5ZqX6XtdH2jwVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739728588; c=relaxed/simple;
	bh=ZDY1aJPZDgeCwOYVMqaVpQ2knOg9rXSiKOZ0IoAXVcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6/PGIFIYdrvUHxgYZvwZk9ooLSA8C5IEMydjUTJpMQ4Rj8JS4MtYWj03HD5r+tFP9syuAQUQghMukkv/EeQjwwiMoci0T/kIrkD2pHQJ3RCcLY17Uu0tB0lKIsyBcwsS5/B58sxR37+Jf6qsZ4vJDVgguitmZRdN5Yp9jvlH1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu; spf=pass smtp.mailfrom=artur-rojek.eu; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artur-rojek.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPSA id DAA7544339;
	Sun, 16 Feb 2025 17:56:16 +0000 (UTC)
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
Subject: [PATCH 1/2] sh: align .bss section padding to 8-byte boundary
Date: Sun, 16 Feb 2025 18:55:44 +0100
Message-ID: <20250216175545.35079-2-contact@artur-rojek.eu>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehieduudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehrthhurhcutfhojhgvkhcuoegtohhnthgrtghtsegrrhhtuhhrqdhrohhjvghkrdgvuheqnecuggftrfgrthhtvghrnhepiefftdefueefveduuefhleetfeevvdetiedtleevfeefleejvedutdefiedvgeefnecuffhomhgrihhnpehlughsrdhssgenucfkphepfedurddufedtrddutdefrdduvdelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfedurddufedtrddutdefrdduvdelpdhhvghlohepphgtrdhlohgtrghlughomhgrihhnpdhmrghilhhfrhhomheptghonhhtrggtthesrghrthhurhdqrhhojhgvkhdrvghupdhnsggprhgtphhtthhopeduvddprhgtphhtthhopeihshgrthhosehushgvrhhsrdhsohhurhgtvghfohhrghgvrdhjphdprhgtphhtthhopegurghlihgrsheslhhisggtrdhorhhgpdhrtghpthhtohepghhlrghusghithiisehphhihshhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehtghhlg
 ieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehusghiiihjrghksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgvvghrthdorhgvnhgvshgrshesghhlihguvghrrdgsvgdprhgtphhtthhopehjvghffhestghorhgvshgvmhhirdhioh
X-GND-Sasl: contact@artur-rojek.eu

J2 based devices expect to find a devicetree blob at the end of the bss
section. As of a77725a9a3c5, libfdt enforces 8-byte alignment for the
dtb, causing J2 devices to fail early in sh_fdt_init.

As J2 loader firmware calculates the dtb location based on the kernel
image .bss section size, rather than the __bss_stop symbol offset, the
required alignment can't be enforced with BSS_SECTION(0, PAGE_SIZE, 8).
Instead, inline modified version of the above macro, which grows .bss
by the required size.

While this change affects all existing SH boards, it should be benign on
platforms which don't need this alignment.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
---
 arch/sh/kernel/vmlinux.lds.S | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/vmlinux.lds.S b/arch/sh/kernel/vmlinux.lds.S
index 9644fe187a3f..008c30289eaa 100644
--- a/arch/sh/kernel/vmlinux.lds.S
+++ b/arch/sh/kernel/vmlinux.lds.S
@@ -71,7 +71,20 @@ SECTIONS
 
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;
-	BSS_SECTION(0, PAGE_SIZE, 4)
+	__bss_start = .;
+	SBSS(0)
+	. = ALIGN(PAGE_SIZE);
+	.bss : AT(ADDR(.bss) - LOAD_OFFSET) {
+		BSS_FIRST_SECTIONS
+		. = ALIGN(PAGE_SIZE);
+		*(.bss..page_aligned)
+		. = ALIGN(PAGE_SIZE);
+		*(.dynbss)
+		*(BSS_MAIN)
+		*(COMMON)
+		. = ALIGN(8);
+	}
+	__bss_stop = .;
 	_end = . ;
 
 	STABS_DEBUG
-- 
2.48.1


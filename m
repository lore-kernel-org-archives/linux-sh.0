Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424259;
	b=P9ycl0/7KxFQBgTYeIC0BkGCgR9szjOxlDb9BcZAcUWSpRfChdrnO3vo/amTjJsBfYnG
	 kZDpXeKJNZF1xky5jR27dxnWai/JATrpBkxmMzJe5H8xwRMBzd1ZlvURCo2idVFBgectk
	 gp7Y1//g8BrdI0kEmJjXJSq+hp6AXipmw/YpW5Ur4qhl4UwfUJ8WifRWGPDHSMzo3A7zQ
	 WvLpOK8YVNFKiX2yQbiUvGmm5dnBdPec6o+6/TNXBn9CYDy2bB/IhAiSuv6mOF6bRb15b
	 EIM1q3gYsKRVNF99fykN7InKHyAqzxJQ5a2n6NIveUa+jd87fGvrc/2raISG0bEdJkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424259;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jp/k6GjIc+LyPCc3Ht1FwP+rIDTo5lLHU1BcYciultc=;
	b=Xu/B4vUuPPL99+F/6yeiuVvE7iCHWJ+jQjAwZr9X6JZJl5ESfZcDfVHCnfxUPqN1Q9gY
	 co8UVoruDTz4pBbVu7vZFjTemMVE9xiARdLE9RkdvqkiW2zyKcQktEpOinBJXZjyhB6rU
	 QyFk0/Pq3lZxT0MVKPe/Cbjw4Vs0DOMc4Bxx0hRTztEvI3Sj4aznJrhIZ6lzJURCUuWcK
	 QNq3Ippetg4bB45jfaAnUYMZwIbYWfSrKE5A0FZ2+rb4fdiJewKiPc4nsM4P2wOX07Tyo
	 2ccNqjFP4rkxutJi9HjUUo/2h4To5EmoFmEaGIjUsJdfz0nuj6pAzZxKMU0nEjfjz/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1B5DpwT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC7606A31E;
	Mon, 23 Nov 2026 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J1B5DpwT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5585A1F000C4;
	Mon, 23 Nov 2026 08:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424259;
	bh=Jp/k6GjIc+LyPCc3Ht1FwP+rIDTo5lLHU1BcYciultc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J1B5DpwTdbYHX9FNc/fPFRC3nhMfjLoCSj/oxFIyt5uhwVPQEqatgQI38lSZxyZMF
	 VEBzndz6gwSPCebui4tpurE+8Zuq69AyrU1z72mMWlD+b/UnDjIRyJSjDSfwADThEo
	 9axsNO96d5rWOBYbe9xH3krXOzI96nM09vkQoLsPtjettKWsKp5UM83yc0baKKGGvn
	 lipxamSuwf9JREkbT021VVmcNDiTGoTyAKsVqSSNR7P+VbP7gmiuhVUAcsep+ZNFgB
	 jacczHdYEzuMb51SqfeKVM6fgkfUx/bg62d9kQyZK3YFk1P18NZ81+aWlJdIUu/vyl
	 tEl2hB2Mp7PXQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Gibson <warthog618@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] [v8] gpiolib: turn off legacy interface by default
Date: Mon, 23 Nov 2026 09:57:22 +0100
Message-ID: <20261123085723.156933-2-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123085723.156933-1-arnd@kernel.org>
References: <20261123085723.156933-1-arnd@kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All users of the legacy interface now select CONFIG_GPIOLIB_LEGACY,
so it can be turned off by default and only get built on platforms
that still have one unconverted driver.

Allow turning it on manually for compile testing, in order to keep
the build coverage of the legacy drivers in allmodconfig and
randconfig.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9db764a3bcfd..56b5553b51de 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -4,7 +4,14 @@
 #
 
 config GPIOLIB_LEGACY
-	def_bool y
+	bool "Legacy GPIO interfaces" if COMPILE_TEST
+	help
+	  There are a few legacy platforms that use the traditional GPIO
+	  number based interfaces instead of GPIO descriptors.
+	  Say Y here to enable build testing drivers that are specific
+	  to those platforms.
+
+	  If unsure, say N.
 
 config HAVE_SHARED_GPIOS
 	bool
-- 
2.53.0


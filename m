Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795424256;
	b=Y1UEOu1pjaG94tbWtSutkUEgG/7s6q6Cis/tKR+74Qvz2kDZ75tJ+mA5nlnuGiNXIC4s
	 mMRcX51J0ygys9a00uOBIJBr07gz3q8STcQOpKFzWaddEPbtBYWIY/sjfz5gux1+vJCBo
	 N4i/BlQi28BRdV6yEbmdaaPcBwwiZ/7SxJGYxhMXY2gTM6nc6uWejGoI/WiPOxx2294bB
	 QhH30vAevj15u3adrKp0qxyYf5KsTkivoI5KIeKjz1NM9Y39IQvlCDhQwKE6WraBy2Nh+
	 vhjCTr1xVMgy+De2/XcbwTx8T4vKOaon+H1UEtrpPZjah9oFafTORf3pmtdONhiv2hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795424256;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ICUuc8qfDorosnSyDbFaFChnLx8Yxx4qXbGHRvFiZq0=;
	b=AdqhI/0bB+ey/OABLu7WmbLfcAf7IadHPijS01ZkAXsp+EM9h8Fwj2Tf1Whxdx2JJ+W4
	 AsR+gHf65p0lcVyCS7tdiUMjkmQsJPXHiEOs47LrFOjWpTwl04oGoMN6zhn6UxVI1aU3e
	 frJf0yqdSCKmI+amg0KX3NKE87gmTtcs7paEin4JuqWE24fTJ+PscFbh1kWx8ZnCcH2Xp
	 wgWDbU0YuPA6ckfTGrYHleTm9RZs7krDv0vVT/tN/PycWRhXt82q3SVpF18bD4yBTuOPJ
	 jqs+7a0fpo5+L3kz+5UfJRR0MJjC551Tkw6U+Hz+mjGWh7oldrUPhQP8Rzt72Jd+IRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtoWod7i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C05606A31E;
	Mon, 23 Nov 2026 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtoWod7i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B9C1F000C4;
	Mon, 23 Nov 2026 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795424255;
	bh=ICUuc8qfDorosnSyDbFaFChnLx8Yxx4qXbGHRvFiZq0=;
	h=From:To:Cc:Subject:Date;
	b=TtoWod7iPqMqdo7PvKMGoKSUKOd+vxUSv4Kxvj32cQgIV10fY1NkiobvW7Stuj/aq
	 CPcfJ0QieVx+ce9dpfovyVmbrBganLBje4Mn3CQKmHzIIuqOykem52yGte+YHNFbqo
	 DacOOMdQU9LyhHH1CFt5TfS75PI2WrEnYKXwwElSH0SdlIyuNomhwJj+CHVr4/eI/X
	 HHpvC8NXUku4mF+8oPZunClwlxW16u0mHVx6puk6SG/mcZ1oPI4l4tMUsmz9FgDWiO
	 39ApjGwfUwaY6lAWkXlKJuPuM101pUhSsoKCpNPvpHjCTyGUKhhKqrz6VY5eTnCMmx
	 EOZ9biCGO+z+A==
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
	linux-wireless@vger.kernel.org
Subject: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Date: Mon, 23 Nov 2026 09:57:21 +0100
Message-ID: <20261123085723.156933-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

These two patches are left from my cleanup series, finishing off the
work to turn off CONFIG_GPIOLIB_LEGACY by default, and removing the
include/linux/gpio.h header.

This was planned for 7.3 originally[1], but kept conflicting with
ongoing cleanups for the broken rsk7203 board. I've skipped the
oneline rsk change now, which will be fixed properly by Dmitry's
patch [2].

     Arnd

[1] https://lore.kernel.org/all/20260907090956.2825703-1-arnd@kernel.org/
[2] https://lore.kernel.org/all/20260929-rsk7203-properties-v3-0-02f84aeb8e47@gmail.com/


Arnd Bergmann (2):
  [v8] gpiolib: turn off legacy interface by default
  [v8] gpiolib: remove linux/gpio.h

 MAINTAINERS                                  |  1 -
 arch/mips/txx9/rbtx4927/setup.c              |  2 +-
 drivers/gpio/Kconfig                         |  9 +++++++-
 drivers/gpio/TODO                            |  4 +---
 drivers/gpio/gpiolib-cdev.c                  |  2 +-
 drivers/gpio/gpiolib-legacy.c                |  3 +--
 drivers/gpio/gpiolib.c                       |  2 +-
 drivers/net/wireless/morsemicro/mm81x/hw.c   |  1 -
 drivers/net/wireless/morsemicro/mm81x/yaps.c |  1 -
 include/linux/gpio.h                         | 22 --------------------
 10 files changed, 13 insertions(+), 34 deletions(-)
 delete mode 100644 include/linux/gpio.h

-- 
2.53.0

Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: linux-wireless@vger.kernel.org

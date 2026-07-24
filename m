Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF9A27FD49;
	Fri, 24 Jul 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784917399; cv=none; b=tqzvfUkTEF8jq663nxN5RRIHyqTctdUtPMrhT3+uLzkra83TlVJF3whraMkLxqJRGFO7hfR3zqPLU3nOUyoEZCrp6VxHHQ3uWdfSlfpbrmpfOdpN2AYy4rGiXIHai0xTSuH2QE4Q7XT0PXfCO0CF69gMzPmIQJTIGhmERq1VwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784917399; c=relaxed/simple;
	bh=e/pxS4dkSGV9JdHD+Vse0KlAUzgS0XeW+PIyOEMyORU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=fejG066kYa+5OSyuDjmG1G2H8nAxn3AXF42ejIZ6g5tYRwboQtEUPoPFSW7O16mhNt2YEF/Eq3tsYfUO/xKahVCFeKNUA7qo7C4cEUoRFIX2ATbArm/9/ruT2mlwBSVPvoIXWZjzStAgUxiGHX3VEl2Z+yoPYxKuQjSD4qa0zHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ec3HLge7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+2j6IzE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ec3HLge7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+2j6IzE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id CB929EC0066;
	Fri, 24 Jul 2026 14:23:16 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 24 Jul 2026 14:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1784917396; x=1785003796; bh=W2
	0qbJDbSJFftSzEeXdf2eDqff7ZSn9IsDKzHlBiZlM=; b=Ec3HLge7uoy5cU7eCv
	nBNS3cZWHWGzZJWb5ytIya8s4aHhqm7AiZFhXQumItaMc2LF8s0Cb4LEppmDo9Rf
	JOtEcInCntxCaHc+ITowldhG99JL5O5iEDcaIGEIopXEK1if+PW8ScOzwKqj2LTf
	IdRT/Vt+r0ak3mo5knt8iiTujeUsFtzdvm9XtMoChQFtNqtLu3xCyWRYFNc+26ev
	yU5jN4scJtVicQOMQjgv9IcJ/l4Vhsub4whrhse4bNPEWmLel2KzcNM6DV+I4a5E
	/hnQGMEtxUun2h0cIr9DrpWK23D6DfRVHl2FexRR+MB7XpgihDkyhIhpBKdmIP/j
	7sHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1784917396; x=1785003796; bh=W20qbJDbSJFftSzEeXdf2eDqff7Z
	Sn9IsDKzHlBiZlM=; b=l+2j6IzE1P68SGwvc7tWA+OzJZzk9ATyz5nWuS2+3nx9
	/d7I67Ql8Mr2moeXylIOT2RLN58Fr/KVwphcRFmfwWcqlHkEDYLfRQlR9pBARrq6
	/o9VSew9nYvqWQoOvcNCahx2OHvR4J0roaLTHzrzUG1WfHS/MpYM9ev1tgyB2hb5
	PgZELemxndtHy5gzBrRhagESyenpScGtdot3C+vblG0Wfs4KuhPX44rqCx9uNFXu
	U/eVfJWrO+5Vf0JbEkGXrS7pObT5jbdC941iXuqALsMTPZqsVlOhVpMV87v3bV0K
	V6TzP+cwLvCXeceBve3J+BmrQzyoEsGmcLFMvy0pig==
X-ME-Sender: <xms:lK1janDqrOHLU0FYBO3NMNqdO5NM3-96XkZxKMf2ZhgamGIuCwW77Q>
    <xme:lK1jaoVFD4yjglpXGaK9APQzeC6CD3eSG5hNsGbarH7bKQgY5ENhl-VexE3DLg8G1
    BRYxx_C23ihfvpJDsRZ5-AVhmJygUpDITghSMxQ2tiCqwHwOKJRSaWm>
X-ME-Proxy-Cause: dmFkZTEvYcxSBfTwSD5AempWkdIZsZ9EqLQysnZHsKDg1LqZc4V7Tg/p0Q5pKvPzc1h6lN
    jIXnsivyjrLbzcHYmvyrgdjRPuoUUSXHIPouQSYZv8pQIl/Kgk8SSRP3A10jxNGNbW6Gdl
    vzwWvoKGdZmwFjYC17hslCBSSdvrnhcCaXQSAiEsrNSUpK+x8aLq53t07SZ67R6KEfG/ub
    er5f9F8Ij/i+uWZBMTnrM71NrwN8wlS52lNnrRkqbltz2Bc4SOy+qwB9Tb4YWVoCKrWpoE
    DaoRt365rsEm2Rlw2UWMp7tzTjGuqT23ComDZMoFrRH9KL2P2au9EVnvJHGQZC9/cnAYmV
    TSs7UlrZqbgcn5AKBYfqC3cmpsxl/C1VvhEFPCAg0+HKkVwwG4BWCqt301xpcsYCDbcZ03
    P/a4KjMtSQc0txkF6MTedKlsaLnUiSCM0NUsaQ90AHJ+jX231a20dakp+OEbblRmIqEvPm
    Dac28msjtv+4QC4CLVsEmbNkcrSZRmPLQcQQBvZXMFjP5pdoZeZvYeQ95PpJxXZ2C8RUhe
    0DsbDGSyuecq+OBne/4eir8QfNA643qpbxdxbU9hjMkEw9U1kSoLo44cxaiBoxqot78YTc
    Mv1CXXKYhb7S15CKrHMmQTEugf26Vhex6ysL2Ysjhd0l6OCXDFhKB9jZy84w
X-ME-Proxy: <xmx:lK1jau-dStUIjCw7Jrp6GtfVDSU7OQq4EIdqqC_T3MZMrq6ggNOV5w>
    <xmx:lK1jajquisIK_PI2rDw4R5cDbwEvXQgGRI7y9naD-1OBBIisBc6yiQ>
    <xmx:lK1jaoR6jNi0DGm0r08I8g5geh5W6OdvIPiPui3yImuScfVhCEJYYw>
    <xmx:lK1jamN4NOUFKNysTEhHhaIJYeDGNHE-jVvkvbEmfVhrbD2xSJiamg>
    <xmx:lK1javSP8fqG8Gp0dmIiD_EsVCfVhGQbjRyhuA2ZRVN8bVeAITxfgRS3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 960C4182007E; Fri, 24 Jul 2026 14:23:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 24 Jul 2026 20:22:45 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@kernel.org>,
 "Linus Walleij" <linusw@kernel.org>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Lee Jones" <lee@kernel.org>, linux-kernel@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-sh@vger.kernel.org, linux-mips@vger.kernel.org
Message-Id: <aa9cf4a4-a848-43cc-a236-e8e4b89101a6@app.fastmail.com>
Subject: [GIT PULL] gpio: legacy interface cleanups for 7.3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git tags/config-gpio-legacy-for-7.3

for you to fetch changes up to 57f64d52ab5e836a5f3f4ea6fd868941b2d7dcdf:

  gpib: gpio: replace linux/gpio.h inclusion (2026-07-24 20:12:48 +0200)

----------------------------------------------------------------
gpio: legacy interface cleanups for 7.3

These are the remaining patches for legacy gpio interface
cleanup, ensuring that files referencing them are sure to
have CONFIG_GPIOLIB_LEGACY set, and use linux/gpio/legacy.h
instead of the old linux/gpio.h header.

There are a few more patches already merged in other
branches for 7.3, including soc, led, net and media. Once
everything is in, we can apply the final patches to turn
off CONFIG_GPIOLIB_LEGACY by default and remove the obsolete
header file.

This branch is based on the immutable ib-mfd-legacy-gpio-7.3
branch from mfd.git to avoid a conflict in the rohm drivers.

----------------------------------------------------------------
Arnd Bergmann (12):
      Input: soc_button_array - select CONFIG_GPIOLIB_LEGACY
      Input: gpio-keys: make legacy gpiolib optional
      sh: select legacy gpiolib interface
      x86/olpc: select GPIOLIB_LEGACY
      mips: replace linux/gpio.h inclusions
      sh: replace linux/gpio.h inclusions
      mfd: replace linux/gpio.h inclusions
      ASoC: replace linux/gpio.h inclusions
      pcmcia: replace linux/gpio.h inclusions
      phy: replace linux/gpio.h inclusions
      Input: matrix_keyboard - replace linux/gpio.h inclusion
      gpib: gpio: replace linux/gpio.h inclusion

Dmitry Torokhov (2):
      mfd: rohm-bd71828: Use software nodes for gpio-keys
      mfd: rohm-bd718x7: Use software nodes for gpio-keys

 arch/mips/alchemy/board-xxs1500.c                  |   2 +-
 arch/mips/alchemy/devboards/db1000.c               |   2 +-
 arch/mips/alchemy/devboards/db1200.c               |   2 +-
 arch/mips/alchemy/devboards/db1550.c               |   2 +-
 arch/mips/bcm47xx/workarounds.c                    |   2 +-
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   1 +
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |   2 +-
 arch/sh/Kconfig                                    |   1 +
 arch/sh/boards/Kconfig                             |   8 ++
 arch/sh/boards/board-magicpanelr2.c                |   2 +-
 arch/sh/boards/board-sh7757lcr.c                   |   2 +-
 arch/sh/boards/board-urquell.c                     |   2 +-
 arch/sh/boards/mach-ap325rxa/setup.c               |   2 +-
 arch/sh/boards/mach-ecovec24/setup.c               |   2 +-
 arch/sh/boards/mach-highlander/Kconfig             |   1 +
 arch/sh/boards/mach-highlander/pinmux-r7785rp.c    |   2 +-
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c            |   2 +-
 arch/sh/boards/mach-kfr2r09/setup.c                |   2 +-
 arch/sh/boards/mach-migor/lcd_qvga.c               |   2 +-
 arch/sh/boards/mach-migor/setup.c                  |   2 +-
 arch/sh/boards/mach-rsk/Kconfig                    |   3 +
 arch/sh/boards/mach-rsk/devices-rsk7269.c          |   1 -
 arch/sh/boards/mach-se/7724/setup.c                |   2 +-
 arch/sh/include/mach-common/mach/magicpanelr2.h    |   2 -
 arch/sh/kernel/cpu/sh4a/setup-shx3.c               |   2 +-
 arch/x86/Kconfig                                   |   1 +
 arch/x86/platform/olpc/olpc-xo1-sci.c              |   2 +-
 drivers/gpib/gpio/gpib_bitbang.c                   |   1 -
 drivers/input/keyboard/gpio_keys.c                 |   7 +-
 drivers/input/keyboard/gpio_keys_polled.c          |   4 +-
 drivers/input/keyboard/matrix_keypad.c             |   1 -
 drivers/input/misc/Kconfig                         |   3 +
 drivers/input/misc/soc_button_array.c              |   1 -
 drivers/mfd/aat2870-core.c                         |   2 +-
 drivers/mfd/arizona-irq.c                          |   2 +-
 drivers/mfd/lp3943.c                               |   2 +-
 drivers/mfd/rohm-bd71828.c                         | 125 +++++++++++++++------
 drivers/mfd/rohm-bd718x7.c                         | 123 ++++++++++++++------
 drivers/mfd/sm501.c                                |   2 +-
 drivers/mfd/tps6105x.c                             |   2 +-
 drivers/mfd/tps65911-comparator.c                  |   2 +-
 drivers/mfd/wm8994-irq.c                           |   2 +-
 drivers/pcmcia/bcm63xx_pcmcia.c                    |   2 +-
 drivers/pcmcia/db1xxx_ss.c                         |   2 +-
 drivers/pcmcia/sa1100_h3600.c                      |   2 +-
 drivers/pcmcia/soc_common.c                        |   2 +-
 drivers/pcmcia/xxs1500_ss.c                        |   2 +-
 drivers/phy/broadcom/phy-bcm-ns2-usbdrd.c          |   1 -
 drivers/phy/rockchip/phy-rockchip-usbdp.c          |   2 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |   1 -
 include/linux/gpio_keys.h                          |   2 +
 include/linux/mfd/lp3943.h                         |   2 +-
 include/linux/mfd/ti-lmu.h                         |   1 -
 include/linux/mfd/tps65910.h                       |   2 +-
 include/linux/mfd/ucb1x00.h                        |   2 +-
 sound/pci/Kconfig                                  |   1 +
 sound/pci/cs5535audio/cs5535audio_olpc.c           |   2 +-
 sound/soc/codecs/cs42l84.c                         |   1 -
 sound/soc/codecs/cx2072x.c                         |   2 +-
 sound/soc/codecs/dmic.c                            |   1 -
 60 files changed, 248 insertions(+), 117 deletions(-)

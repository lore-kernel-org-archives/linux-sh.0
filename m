Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF00F3DE429;
	Tue,  9 Jun 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994447; cv=none; b=gQOLYGnbruoeJN1xNietnS8ZCMM0XCrW23ko9L/ToB3GyE4IoFG+RnG4TExuBarla77p8ZtOCzDHFhAyynlFX3vk3MTCVdTtYUeDZkrl5DD0Piq0BEZm1wIebqL2UxgwIYq0MIMZnOH2ziYRiI/XDgu7vYxG0K8mO+LEzQEb//8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994447; c=relaxed/simple;
	bh=+kLQLV1248ptOYNNjnp+rwEHWHiWoKwSBi+b0jVxE+8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f2/KziNClQHGVydLKH1ywrSRrODwZZEfGFxQVCNdidy+wL+LfzcODc3DodiXwavQpTlBhoA71P03qJFvnsWxZHiaQfcQxzBkDJmTLNz8+PTsX+cJUWyQSInOkPSWBgzhFrDsNTII2T9ybcpKgBnuaxUydBxS4P9xgYKrdxAE/P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE3nC4DA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE3nC4DA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B9E1F00893;
	Tue,  9 Jun 2026 08:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780994444;
	bh=bbzTi8vgEBGrGu0YxoCrG1r/RD+HuZcU9G2SCTNpP18=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=UE3nC4DA/FeIBG8XyQdYxp7B+aGjyUgo3b8qB6aCFmRA05vFlyVmVmu46XQGvpPKa
	 jTtPhjcI8TM8GI8jOCoOhsZnqn40VE9LFrxcn868dcjX4MuKVbT8AI9V2i7Z/bjv6h
	 eEyufxlb26yFp/FbvKhN5IG8EGWu8eYZlDF6e2WtDyRK1qELY01lbMXoxp8/Fm6JeJ
	 xizr1+A/ML11JhIPDaWVi8iPdfzCwN1SdMtZyBphZi0a6bK0iBxecZEezYHr/uyojG
	 MW9hpULUg3raQAfRQtdahqYaore02Fyq5z9vHBI1DshpS8wcP/Le1nXSVjf3q37u8F
	 jtxss/2Tt6Heg==
From: Mark Brown <broonie@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Jaroslav Kysela <perex@perex.cz>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>, 
 Rich Felker <dalias@libc.org>, Takashi Iwai <tiwai@suse.com>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
References: <87zf1le4fu.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/3] ASoC: simple-card: remove platform data style
Message-Id: <178094130630.20828.12708103059145547835.b4-ty@b4>
Date: Mon, 08 Jun 2026 18:55:06 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1530; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+kLQLV1248ptOYNNjnp+rwEHWHiWoKwSBi+b0jVxE+8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqJ9GIwAGxzD/ZtsWxpGXo98kZGj907Ua0+dI9m
 hlBF3wtThWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaifRiAAKCRAk1otyXVSH
 0A2mB/4pLtPP3O8Cf2wtZymnXjuSiozk2Q5NM3kvAy2+rNJCSy/18cwEhmpuwsMdIUj5n6d8jst
 FoUSD6oKJCAgZG3UjkM3KsCqbORnaxHbEAJ48qaovaTe/pSGcY+SZ3jvwcNBvQECUQaRIng7Jir
 HO7RwAaacEJilCSyhH81vwDodmA8ydHx+W0Vca8DN6XG9pc9DWl8KmA8Ym1gxEbRGtp4ZsZwCL1
 JH++jxaeKcGTOklZpRQHEecsL3wpFLCe3CDMtxXad759+Be/hxcSkJp7LwCvDOpBk4KLqV7tvuK
 y2ieVxexqeo+qhkKlq2cXsSij/9fVkw/b1QxMXJiPUqt1pY/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 27 May 2026 06:45:26 +0000, Kuninori Morimoto wrote:
> ASoC: simple-card: remove platform data style
> 
> Hi
> 
> SuperH ecovec24/7724se are the last user of Simple Audio Card as
> "platform data style". It is mainly supporting "DT style" in these days.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/3] sh: ecovec24: remove FSI/DA7210/Simple-Audio-Card support
      https://git.kernel.org/broonie/sound/c/9cc93ebc85e7
[2/3] sh: 7724se: remove FSI/AK4642/Simple-Audio-Card support
      https://git.kernel.org/broonie/sound/c/deadb855b694
[3/3] ASoC: simple-card: remove platform data style
      https://git.kernel.org/broonie/sound/c/325fea33e141

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


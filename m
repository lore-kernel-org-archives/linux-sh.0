Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA34157485;
	Fri, 24 Jan 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737734287; cv=none; b=Bwq1Jcupw4EVmylyXLCnREyoyIT36MGTcN/QAAsQSeaKh9BmBw2TYoJfzDedMM2bwr+gofAv6m8XCJY7OolZ10zEp5OgicJOUkzaW4nkMwYvUnJ0pJ6XJnNcInZKtONuBz7hAg6mvmpppJsBsU15jcDO1wuLAio8mXfUnVg+Jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737734287; c=relaxed/simple;
	bh=1A86Zz6bBgcaV7r3S4D9v59QUu6vk9y6MxJJ7gSJ4cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a1zgpfvzsWyNsl5AhTasrvRUg6G0c6UF8bHet+fpK28Kn5+4K+8QkwLQ+A5hZJT9oL3Tu5FJnCktiZE2DvMpvgDd4DIRavCzPBp1uxBC6W/aUYyrrO1yQ0bRzhb84F5HkhHxN9Wv+EvD9Yqsx5Tj/+kp7kp1DXzhLEXP2dU3neA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehk766zG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehk766zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05323C4CED2;
	Fri, 24 Jan 2025 15:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737734286;
	bh=1A86Zz6bBgcaV7r3S4D9v59QUu6vk9y6MxJJ7gSJ4cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ehk766zGEdAoQkghwFc1HgDd4EKnhOpun+/k4KGu8CPkoGGPk4OniSuoYbBftbB2h
	 SUQMYwoMgb4EoKDtMH5UATdMNCop3qLq9rXp3uCzjPqE44baDxlFdg0Y9w8DUwtduX
	 5BmnNfHm2HdQC9drlhWqFoOvY6f+EctQDWFTLs9jGmwe9BQaC93Mw9Drwkauz/4sgv
	 4CafUmXvKKRtUPKQmTQI4WmUC2X6FZAxdTEX6jp/OK4/sIFv7+x6lnPNnOAQ74SgZb
	 7MgQyXHYzGUYVVt+ufXqITY5zzHil8iBQFijBhPNY3ZrGFC8IhmfeVhUGYPIXF52fc
	 oeS4hTDFKIfTA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sh@vger.kernel.org, linux-sound@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <8c17ff52584ce824b8b42d08ea1b942ebeb7f4d9.1737708688.git.geert+renesas@glider.be>
References: <8c17ff52584ce824b8b42d08ea1b942ebeb7f4d9.1737708688.git.geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: renesas: SND_SIU_MIGOR should depend on
 DMADEVICES
Message-Id: <173773428475.46042.4071074696257192145.b4-ty@kernel.org>
Date: Fri, 24 Jan 2025 15:58:04 +0000
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 24 Jan 2025 09:52:45 +0100, Geert Uytterhoeven wrote:
> If CONFIG_DMADEVICES=n:
> 
>     WARNING: unmet direct dependencies detected for SND_SOC_SH4_SIU
>       Depends on [n]: SOUND [=y] && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && ARCH_SHMOBILE [=y] && HAVE_CLK [=y] && DMADEVICES [=n]
>       Selected by [y]:
>       - SND_SIU_MIGOR [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && (SUPERH [=y] || ARCH_RENESAS || COMPILE_TEST [=n]) && SH_MIGOR [=y] && I2C [=y]
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: renesas: SND_SIU_MIGOR should depend on DMADEVICES
      commit: 2e3c688ddaf2bb8e3696a773b5278711a90ea080

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


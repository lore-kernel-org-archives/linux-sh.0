Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ADF384238;
	Thu, 11 Jun 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169872; cv=none; b=QCjcz44Of0HioCqonAenU0kehd2A5weg/7lf88RvnuPWdSGBc4iD0/jQ+bn4m9NCWVML05/2fkoe5BGv8t99zK2WMReJCwMx6yXTmjzd4bW2ilfV9Z1yFpCJgKciy4pdNNwlza/SBqfcqox/tOARH5MiWJtxE//TSDOVxpiHOo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169872; c=relaxed/simple;
	bh=YXaThjFaTvqK3pMs/4PM5iwnXmqdetewmJRINYfZP2I=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oEloASqefVvt8uF9/vzAkmME/8PO/U/4iUEJKkyV5YF4MKulOGAqokGxV9fkG2Psz06yZBVw6NhqCT4HLlskTzvhyT6rHHF5tNu+dEMcgmhsDYZazzaIUHAudZ3goVZMY5vP7UNqLRxpU4zXe2BDb4iye9k46QMyE3JghGzZU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCEhws0d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCEhws0d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1721F00893;
	Thu, 11 Jun 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781169869;
	bh=qLEOLtq/mH/Z+jkcaJMzXzXM0IE0yJQT/QC+VMPWm+I=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=WCEhws0dXYtZ6Xv40T7ZGv7krC53jp3fTXcKk6SvvgZxwAUjVKQUqotO7VSthfJzX
	 X/0GwpZ/Yk3G4DIJLEhm6m+lqLOzqmS+VTcYeKWdinW8j/SBTbuFoZFxP63tzFf6FV
	 cT6uAPvVptXM9wU8u8F4DFDZfxqzhn9wFYAEKA8Yn+aGBGWF/4vJa6HngN0aM0/C/N
	 cq9zENi4YBaQDlzfJ3F4uP6S9+zd9FtV84OM4qpBC8z5e7oOp6TYWx36Wg3iIBWjg8
	 o0bxfps8ncGOmOq3A0RLSg9HuaDHpoYcbnCQnq8jhwgKw3T43zmiudpk0wqHHSl+S8
	 ywgTKqjo6EGGQ==
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
In-Reply-To: <87wlw743x2.wl-kuninori.morimoto.gx@renesas.com>
References: <87wlw743x2.wl-kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] ASoC/sh: roll back Ecovec24/7724se Sound support
Message-Id: <178108922909.232889.4715118215836071321.b4-ty@b4>
Date: Wed, 10 Jun 2026 12:00:29 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YXaThjFaTvqK3pMs/4PM5iwnXmqdetewmJRINYfZP2I=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhiytupPxnszGi9ILmrP1r+68LnX8wwXPtfV9S7Nn95xZc
 uC+2HaTTkZjFgZGLgZZMUWWtc8yVqWHS2yd/2j+K5hBrEwgUxi4OAVgIsZf2f9XsCf/0bSre2ze
 4LXI2ng625bgIvca5kvJd2YZi/ctZ7MJ8E/13fHTU8mu6m9+laBe8J45lvZd7DlPn7I/5f6UEBJ
 3tFJOak917Zo5jH0FKRIvf3hIKiwwr8hq1nIo0elm6E+seC+0hr+wyyHbXrvN3tzkrO+iB/NNKp
 exh/S8aC/4Gnh+YazOyclLNHWaXSX7p/3liF7cW7l9HZ9hJdO2M43rLuUqeB3cfkDt5uL2y3n7N
 0r2BNjqTfYsygsO1di24oKk9dkVxw8u2/j0qOeeh1x9olsbmJ3aI38JhBz8IJvrzq8pmXDAdbNR
 wdeIgrUK/6qMbz384P/v/cVkk5yimTMm2TXuDfi5lysKAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 10 Jun 2026 00:47:37 +0000, Kuninori Morimoto wrote:
> ASoC/sh: roll back Ecovec24/7724se Sound support
> 
> Hi Mark, Adrian
> 
> Due to a communication miss, the Ecovec24/7724se Sound support
> were removed. We need to keep them for a while, until they will
> support "DT-style".
> Roll back Ecovec24/7724se "platform data style", and its necessary header.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] sh: roll back Ecovec24/7724se Sound support
      https://git.kernel.org/broonie/sound/c/fc83c6a271c1
[2/2] ASoC: renesas: fsi: remove platform data style support
      https://git.kernel.org/broonie/sound/c/38d3273075d6

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


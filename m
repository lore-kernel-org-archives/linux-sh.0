Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F49125DA
	for <linux-sh@vger.kernel.org>; Sat, 20 Jan 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705771794; cv=none; b=Nfa28HzfWuekj1v50g2rgYUf93eAkvrIYn/drTSiHikQfkv5lYtaLFiw+bDKg97sIhl9LbkjJ4SXGnVf0aPszit63gGBy0shADtocAfTbyZ+bdx3kXlm0uG8am73kKX/iFZwaoog8lGfZEUto6I+SaaMX/Jgr4teL8seJePyZxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705771794; c=relaxed/simple;
	bh=hssXSEq39nvsONlSQ/fl+ueVOXiT1TfoxoA6J5yyZtk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Bs9iqK0w5SsQRNDp0XHljPLo76RE1PV3T9Qfq8AKjKAHcK22v92zD69VygCMzE0SVS3n6RUPsywcVINTaAiyfl2uNC2K747wtCA20q9A614i8Var/c9gyAIS1svqTfdNekGO5GjToAx/XrnQHlpmi037DDZA2pp3TeA5hV3rOIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SibxHJgi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SibxHJgi"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1F05C433F1;
	Sat, 20 Jan 2024 17:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705771793;
	bh=hssXSEq39nvsONlSQ/fl+ueVOXiT1TfoxoA6J5yyZtk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=SibxHJgiPXzotxTaTyYUGtNp06GitmgiN/BbZxk4QQ2DRggwOluPEt6rPmDjUoHuG
	 bfAVEPbTTFF8S6OxcwU4iwMowhQRsmcuzHBrBoumbwAYWf6w9zrsxk2bHnNA52/RkH
	 8/0p/10XUsznkuM6WrT1jMvavGm6VAU+iuC7m7kDImCPvWp9+9ImL2iRejNgNHUbPM
	 5xTFkxwEzZhOuFRrsBj6nJGxzcGxKseNNyadExBTfuOnmzrysMIicVXRKCti2OluBG
	 8LZm/d6tfPrwQ+GCc4Fkvt98a/s73Ah9/oojKGxphpDfQ4LDM9Z3AOGCRYpm6kUkhv
	 /XrFyquoMeL0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C262ED8C970;
	Sat, 20 Jan 2024 17:29:53 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.8
From: pr-tracker-bot@kernel.org
In-Reply-To: <f66b859bbf36d33b6998be5d64d536eeb7c75db4.camel@physik.fu-berlin.de>
References: <f66b859bbf36d33b6998be5d64d536eeb7c75db4.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <f66b859bbf36d33b6998be5d64d536eeb7c75db4.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.8-tag1
X-PR-Tracked-Commit-Id: 99fe83ab3bb0e8aac4d45a9361919794336b2ba8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 125514880ddd381fdaaa4d11f32afdb55f1c0307
Message-Id: <170577179379.28838.8226395177609765095.pr-tracker-bot@kernel.org>
Date: Sat, 20 Jan 2024 17:29:53 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Masahiro Yamada <masahiroy@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh <linux-sh@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jan 2024 13:29:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.8-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/125514880ddd381fdaaa4d11f32afdb55f1c0307

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

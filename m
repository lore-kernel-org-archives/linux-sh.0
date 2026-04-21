Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2619067C;
	Tue, 21 Apr 2026 00:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776731522; cv=none; b=gHAhR400jCmVitBIUFUFkV8cwRGYTDVOkncK9S2S2PZtH9n0EHe3XPPqtHR9jhLzB9+mRZHZkgRxOcdLm6K+unPjeLGCvy9bm47gASGdacLDYU2bhAPd4EtAevmdRdpLT9m4JXpQNhYmN2K/mp0T5xbvV6k1XFbY9brBM5J5uY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776731522; c=relaxed/simple;
	bh=GUKfSyxtjIRgN+w91PW1qbX4CymGFvR79K/GAe5ZTIU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pANOjisgRzhE6ew8YCnFIlZwuvXUyI+4EMOmMvYIecj4TwDJTDqPHKm+Z0hb8utoBR57hwWVSPeswXHflwNvY0l5WSXp0lDtw4iKqcfVQp+Wvtk2FX4fEGTOG7+qt5AYtigzORZ2ntPgJJd0b1hUwDGMSDXTSyMh/mSgM76Fkrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwIe0y02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwIe0y02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A82C2BCB3;
	Tue, 21 Apr 2026 00:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776731522;
	bh=GUKfSyxtjIRgN+w91PW1qbX4CymGFvR79K/GAe5ZTIU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AwIe0y02+D4gusb5sB3JJGcUNxjvk5ws+ppvVFJd6CCiDCWy1lqvtKSMAHdGhYJOp
	 WUeh9W6U6mfzpelgINqISiFxGYiWVXv1/tfNyUUwAfazVo+eYo/R+BNBMP3N0UpUFd
	 rVU1WD86WP/b7RxkvthF8TlHBXxm0ternFY4tqczCXgI/ceLoin1f7Tx3skYohdrwT
	 cuq7YOQ3o++D67OEl++Rs4y85QaeNhz9Ty2An1nrIry45t30LrzjERedRLlC4oATjS
	 ecC4pTQOX3xcpQDMROa0OJY2Og12af5BqZLIGmoWLFtm+oHQgij7FVLThApmMv36xK
	 VQNyuD/U48ArQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE623930023;
	Tue, 21 Apr 2026 00:31:28 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v7.1
From: pr-tracker-bot@kernel.org
In-Reply-To: <6fd0b00bde4213ae0006a98f517212a7803f69fc.camel@physik.fu-berlin.de>
References: <6fd0b00bde4213ae0006a98f517212a7803f69fc.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <6fd0b00bde4213ae0006a98f517212a7803f69fc.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v7.1-tag1
X-PR-Tracked-Commit-Id: 647b43f65357673a9ee4fe8a99247a7549bdb368
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce9e93383ad71da468dafb9944a539808bf91c06
Message-Id: <177673148673.2145745.10105680556707732446.pr-tracker-bot@kernel.org>
Date: Tue, 21 Apr 2026 00:31:26 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Zimmermann <tzimmermann@suse.de>, Tim Bird <tim.bird@sony.com>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>, Rich Felker <dalias@libc.org>, "<ysato@users.osdn.me>" <ysato@users.osdn.me>, linux-sh <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 20 Apr 2026 14:57:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v7.1-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce9e93383ad71da468dafb9944a539808bf91c06

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

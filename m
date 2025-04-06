Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E82E14A82
	for <linux-sh@vger.kernel.org>; Sun,  6 Apr 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743955291; cv=none; b=nTnEfrbg6+/THaqlzbcaO4Y0IYv155fanIQvwYU1PBd/A584DZjLva1jxe8HoU2vdZSA7XZM3Y8s0Xz/MOqpgGM9H7OQ5ijYx4d8F6NaeEGCKn6A3RIzg7tLQN/r2h++F+bQqUACxh96Hso54GIjKJMVRUAh8pvdVae5CgBtR8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743955291; c=relaxed/simple;
	bh=WXa9FMrtQR5r3h2a1obo3VqKFuy+VbAOmKzOFGYDNFY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DXsgxB3CCnxnIiN4iJscjEEV8nmk3ESf6irUow5jBx5lSCx82RXGdnJSxBfX8TTvBDp75OKaDTue+S3TQXWckpDTcmr67bG7C1HoSLq74hkl4IFnLqB182fLIU8YdkXNpkMTIkyit+fQDbMEVkTOi1DSxUv7f+dvT0qGB2/2MGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAZqvisI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAZqvisI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD9DC4CEE3;
	Sun,  6 Apr 2025 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743955291;
	bh=WXa9FMrtQR5r3h2a1obo3VqKFuy+VbAOmKzOFGYDNFY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=fAZqvisILFkcugvrmzpwmqHQLKQHtBJmdXEzRA1lyVlBYJgmu4QubtqOmALxOwMgo
	 L/f7YF6mhvv29IZlitMAdazbcH+kPA3qVeD6+PULBBA0UAFmebTi+1JbnzcWvF6MeG
	 MHYkbVmVQLGy/6M9kKe5E3kU7TzPR7GIknd27DFlH3tLADAnYL1D5RkMXj5ultU+Lv
	 TE4kf5Kvjsh78SNPILtBaz84K3ygxk4R8cOHTmgcwhA6wYSmDQfFwym6G70I7rWtnk
	 wB56tvRpMU1pZK4g5Kusy2/LXxcyVmyHQ5uqxvZqiBCPMvxTSMeX+E1v8TcH8jhmd2
	 yPvEUiRF34R7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB00D380AAF5;
	Sun,  6 Apr 2025 16:02:09 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <9c7331defe8b6991bf7f00a7d5e565d6c6784f56.camel@physik.fu-berlin.de>
References: <9c7331defe8b6991bf7f00a7d5e565d6c6784f56.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <9c7331defe8b6991bf7f00a7d5e565d6c6784f56.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.15-tag1
X-PR-Tracked-Commit-Id: 5f2efd67a17e5f4e2fccdb86014efaf8725f57a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f80fbac0ba7d10218b0902c3c51460617cc7cf8
Message-Id: <174395532863.3904920.8332426137530013389.pr-tracker-bot@kernel.org>
Date: Sun, 06 Apr 2025 16:02:08 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Artur Rojek <contact@artur-rojek.eu>, Johan Korsnes <johan.korsnes@gmail.com>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 06 Apr 2025 10:22:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.15-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f80fbac0ba7d10218b0902c3c51460617cc7cf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

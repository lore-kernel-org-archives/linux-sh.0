Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996820B81B
	for <linux-sh@vger.kernel.org>; Sun,  2 Feb 2025 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738529790; cv=none; b=VM8slL7UpvjbQJb126I2LN89RAwPGwoBcwT03Tpyu+qPwWGWc+iUsJ5JhFwpjD/wrGmuS3Syzmx3YU0HILxZIOJkKdD8VqbcQ2q0avGYiZEBaRsfqcBLzDWP9tv5eeuYQDRW2UGyLPnY6XMSnCFMoZz1RyMKXkcHTFtKju4/KBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738529790; c=relaxed/simple;
	bh=xWLy5EJNDHehFUDQBy0PflT7VFVG6cV3FB8m60tCiAw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Ah/2Jp0Ofze39B+shtHykgYFEcZpif/z6gRpcmQXZY6iFy7mEltXpxx/9aEnevsBlrt0uWFk/Z+SsL0qfI3GMb0k5yzOkyZipWoNvEpdhvLL8S3WNyM28ZiUho0GYCCPGuHrX69XlnCIrWlAFNwEJQtbqAOhhy1Fn2Q/Gq9l4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnqtC+yQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnqtC+yQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8929DC4CED1;
	Sun,  2 Feb 2025 20:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738529790;
	bh=xWLy5EJNDHehFUDQBy0PflT7VFVG6cV3FB8m60tCiAw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pnqtC+yQyg0TwL0O77W05Ji5fjPPNxFA3XUDqI4Gfb3OvV6kuh0HFjUzh2dSynurb
	 ls1tVhh4IAxwlQodMXGUOFKDBDpsmd4pWS76znx2M1YjTdzSi0f3yhbBIXbDoIx0NF
	 5J0URCsDcdoR1t85Y4wBaEAzJ3tegkKlYcJ/VDfsWMhmRKVoORGAIKYG2ugTA65PtM
	 b+7lb/BfOLaPGeUYK3kcfbXPIckxtNOhnJgAJBtD1434XrEYi3TSs5Xlj3G5fRWIhB
	 1UF7372zw9SRyi/feLU03kIuF5bK1VVolj9XVfQW7GQEcUcZQzlDv8KK+hM0x7tDR5
	 X8M8BEdQLPv9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF6D380AA70;
	Sun,  2 Feb 2025 20:56:58 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <e69caa6dbc35338b2aa898b3647985823e0548ea.camel@physik.fu-berlin.de>
References: <e69caa6dbc35338b2aa898b3647985823e0548ea.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <e69caa6dbc35338b2aa898b3647985823e0548ea.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.14-tag1
X-PR-Tracked-Commit-Id: 909f3c55d887a9f9d4cd2762813cbfcaf640ec57
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d82ca7b5019d880a579831278eb73cbbfdb87da
Message-Id: <173852981740.2208626.5336292661647006744.pr-tracker-bot@kernel.org>
Date: Sun, 02 Feb 2025 20:56:57 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, David Wang <00107082@163.com>, Masahiro Yamada <masahiroy@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 02 Feb 2025 10:53:06 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.14-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d82ca7b5019d880a579831278eb73cbbfdb87da

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

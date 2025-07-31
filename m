Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F02245019;
	Thu, 31 Jul 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753988831; cv=none; b=BmB8qnnJQElAN8E0ujI7ngcOM2r/8Jyvgmy3LZtJd4rB0RbPFssNHb3SArH3UBzgMS2HeK5m40n0W4zmbp2Bb+q5e3JZW9OiS+T9U0bKlbT1wq1wl0pUFK3urVtoXHCCjPmJ2w1JLtUwGXMT4Sd61gW7yKzu5XtxJN+rDWlQLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753988831; c=relaxed/simple;
	bh=gXcwsYL5F33nRcflVqxFs2CIOeik54bIimrGPL7Un+U=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=gmEKZIheRf71bfRgL+NuvuAs9G2L5gDYYxd7kZYmNbdKs4ElKDC+7DT+2gN4zzyzkE7YyT3VNcvEfLvmUFJQTZOIHq9PmCCLLV7h8Cua7VRqX4ITD/0BgwB2yQkQT2L2mI/KatqDiNPqd/RKJLhZHlhPtf0ZnLVGWZw757nGQro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVUIDePo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVUIDePo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11519C4CEF6;
	Thu, 31 Jul 2025 19:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753988831;
	bh=gXcwsYL5F33nRcflVqxFs2CIOeik54bIimrGPL7Un+U=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=qVUIDePothy6bbajAGSm7uPh/U0OC1s+rfskrPk/HIljAd+xoQT1HlgEzT2H2+Xxx
	 biah6Uvf6mtIjDteUf0vPLXd9tfNmgPfBNxOOFEAR4Bkex/Vyme7vixx+JUW9qG9jr
	 LucmbWiMTKYq/4BnDOhQnVQqsKqzc6G/5Ic+qKgFEo7nM3DONgGvTBEWlcXkCy+A5d
	 zpt8jNkjE/sL/k7P5LgrdxS23snCniH7eVgSeVK00Ls8hRqK5zhx1IFQbwYefsg20E
	 2SehCWmT0MUW4MeFJdlQj0JRWM+AxG6QNGEzpclIeXnc8ODmae8dpJ5VkU8Wmw3Gq5
	 lVYQEFdHQ78HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD69383BF51;
	Thu, 31 Jul 2025 19:07:27 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.17
From: pr-tracker-bot@kernel.org
In-Reply-To: <949b52e4e97f7531cd5f40d13e7689ae7768cde3.camel@physik.fu-berlin.de>
References: <949b52e4e97f7531cd5f40d13e7689ae7768cde3.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <949b52e4e97f7531cd5f40d13e7689ae7768cde3.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.17-tag1
X-PR-Tracked-Commit-Id: c32969d0362a790fbc6117e0b6a737a7e510b843
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ae8021583b4b49cd9a1fac635fbed2449b6c4d0
Message-Id: <175398884654.3259326.6003617544514410391.pr-tracker-bot@kernel.org>
Date: Thu, 31 Jul 2025 19:07:26 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings <benh@debian.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Jul 2025 09:35:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.17-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ae8021583b4b49cd9a1fac635fbed2449b6c4d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

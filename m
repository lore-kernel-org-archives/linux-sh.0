Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F0B20487E;
	Sat,  7 Jun 2025 19:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749323219; cv=none; b=hbkpyuAclSRkaiH53ptqNSbLCqW01lyVvKCMKyXpO43pgxbUDJ2Xpw/4bbug1LlbII18pxycY2EbrCJMVSVuErtD9kw3DLpeTcg+cYph2d2a03X3Mv/4sYNF83jsDcW+zsvdmSkslGPSeNQNAAaaeWngenlpujb1I1/1bldAEVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749323219; c=relaxed/simple;
	bh=eTEyRjfq0QfBLld3BGuJhjFCrp7Wg5wSkHaty9DDl6M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EQ20/eg/LwVc6JZYo4HEE8+VF6lpPfOttb4AIrzJ7xsyJm2xlRTXzmfpxF1o320ELwLeNYhXH3pv5qFX1IXr1wHn6R2hpPX3ulwESz4g4hYCrQqTz9fqpk1DB4JPF2LlJT1+Enauxc6twX4kpMKAmGb46Z57TV1JJJMoGzu9isY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3U5jRT0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3U5jRT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56D1C4CEE4;
	Sat,  7 Jun 2025 19:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749323218;
	bh=eTEyRjfq0QfBLld3BGuJhjFCrp7Wg5wSkHaty9DDl6M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=c3U5jRT0osGmIM1cvXPkTI+5eFzpqOMR9JQCSiRpP2tGjBXEhaMkyr0f9PNlzgB4g
	 Xl61cmmf/vTIt8oIrlI2RAk5FdTN0SAerKlxGnNs4oGILgHFWeAzYFoXkLmDV7RCES
	 OfBOuGH56lHkE+ym+ZpjyMEvyfrx1bxFT26r5eYQd6/d1dciBZbkZ9TmGt/1vObXz+
	 +GgenAWHBIfAtKYi+bspvoy9BPRhQgyfWKNXLR85hI2heSmzoUVTNqEJabGU7Fwo/d
	 XPijD3ov2FTXXm5vnQcH/qBqFe5Bnc8h55tGY9a0wyUXUo8u7VgRoFHHKAr7WvN3gF
	 zHeTtvq6bnqEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70F583806649;
	Sat,  7 Jun 2025 19:07:31 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.16
From: pr-tracker-bot@kernel.org
In-Reply-To: <878859a81e32c216669a9f80a6c30eaf83be5a9d.camel@physik.fu-berlin.de>
References: <878859a81e32c216669a9f80a6c30eaf83be5a9d.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878859a81e32c216669a9f80a6c30eaf83be5a9d.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.16-tag1
X-PR-Tracked-Commit-Id: 8a3682601ddaa4ef0c400f627a7f4b9388bbccef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b3154a6ff1f53b794c01096577700f35b1be9cc2
Message-Id: <174932325013.115837.4506232687079260591.pr-tracker-bot@kernel.org>
Date: Sat, 07 Jun 2025 19:07:30 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Thomas Huth <thuth@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 07 Jun 2025 17:33:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.16-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b3154a6ff1f53b794c01096577700f35b1be9cc2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

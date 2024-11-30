Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1DF78289
	for <linux-sh@vger.kernel.org>; Sat, 30 Nov 2024 23:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733008578; cv=none; b=JhY/qqQrDot8oa2y1MsNnsDKDp1k+0d7fLwi8WO4WQaFRXFwy9BzFOz51xoslUX/u8hAYgTW+MDkFsMjWRFacrQW30JSttPcwyrbWD/5Bw+8PKHQ3zUr7b5TbMgzsm4of3IT0q46jZf0ez9dW/Jt7P7iXFWI8sjAFte1QVFOUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733008578; c=relaxed/simple;
	bh=3ipA5XyxDBWQUtQdPm3y2ziQhYy2Qg+fWcP0VjtyQPE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=uwiZDaZq/po3bGgbOfDqUqrLn5JxOIqCkxS+BJksh2Pdi+OEKxEHv7hNnU81dip6yksM9/4X24LKVFrzRuJW2f3+j5QZH3DDFnE4Jb92KQIDWKoz6lNjTr2cLHapGaBJVyQzOL0dvnOM615TI5Eei/eTQZi301bnwJn4sks4kNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdVpMzMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdVpMzMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1B2C4CECC;
	Sat, 30 Nov 2024 23:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733008578;
	bh=3ipA5XyxDBWQUtQdPm3y2ziQhYy2Qg+fWcP0VjtyQPE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=NdVpMzMYfyMDqFoM35cXz04RKoHXfZ8DDo6vNiweGV8s+EZQlM7t2HNJn+oq3UesM
	 h7gv/XF47cY0VRhTcKG0hoAThNoVbf54ACmP/CBaYsglmRi0YuvpIENlzVbkLSviSp
	 kAXzwUrU8KuWt4frb/5u/vFZmQdmjfkItV6L3K34J64UtwQv3I2OrrckQF5jbImZGN
	 PwoSRyQ4ROJ8U/ipqUpfu3PKkxOHuSFdMbe5cejUy1FyWal1DNugjWCuGiXzPnbcDB
	 zqPERQFExyNd4SmIGpKBM4Ob7blBK/+kF0iVFqOrXkegHrvFajv3UZSZQeWOMrz6pU
	 4f1Om1RjXDcXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CCF380A944;
	Sat, 30 Nov 2024 23:16:33 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.13
From: pr-tracker-bot@kernel.org
In-Reply-To: <d1daf444a9699b2677f9ae9f8d7e675aaeb3d340.camel@physik.fu-berlin.de>
References: <d1daf444a9699b2677f9ae9f8d7e675aaeb3d340.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <d1daf444a9699b2677f9ae9f8d7e675aaeb3d340.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.13-tag1
X-PR-Tracked-Commit-Id: 63e72e551942642c48456a4134975136cdcb9b3c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0ff86d8da707c5620cd8f363e88bf49a24730b52
Message-Id: <173300859183.2503582.10215260982711276318.pr-tracker-bot@kernel.org>
Date: Sat, 30 Nov 2024 23:16:31 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Huacai Chen <chenhuacai@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 Nov 2024 21:16:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.13-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0ff86d8da707c5620cd8f363e88bf49a24730b52

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

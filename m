Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC513D89C
	for <linux-sh@vger.kernel.org>; Tue, 23 Jul 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721761439; cv=none; b=Z5omPeZwWe1ecv4yz/HJNBrHFCY8149gV12CegxUsEtRKAd7kkc8DhcKJx0degvGGtAZ5gq6aylOopYC83cNnrJL5N6nrGBDTZv8q6xzJf/XfASeJZEdjkM3JfJswRTSrJzDAWo/e0bTpD6q9KZDaQLxUExLpYLsIrTb780zBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721761439; c=relaxed/simple;
	bh=WK0t554AbhbEQNNy5dwGZE7QqQPry83iyLP+Kj3+KVw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=G6y3wxWcf5TbRn+CZdW+cAl4cO3CpFodo6d5E/24GcymkgR4NDA09dORY6Fenm/cjtpk6xWGzs5CztE5hOxrZMIRISWCeL6Ay3XLyVwRbgkXJdF5D+777tqgOGXMkbn4VGBQmcREB8BVlf+I6vmk2x3W7u4NB5WLv/mpO3629gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BEjQheRF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BEjQheRF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE444C4AF0A;
	Tue, 23 Jul 2024 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721761438;
	bh=WK0t554AbhbEQNNy5dwGZE7QqQPry83iyLP+Kj3+KVw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=BEjQheRFHNgtDAv/J3udRpE9Ux3jMXhCw/ZyHc+SO/rm+3FJ0UpvQyYPglZRX3y+5
	 uvVFBEsyNmucwjjosCfOuTGUDDq2tiUMCrL8lsc0GEQl4MsFy8E/8qJ6WxT968meoX
	 PBCkC8pJ5KpybT8pDC8660K++7oKIHJb8wz7RrzNOFE0EQcZfDN/fctXihnBA+5UGG
	 0TYKi/VU1oIEtGcf18EOlX1dER3xao+tpMoSymlMskmtUPn4PUkwrlnqqTPbyNfwv3
	 o5aZvxFDcbFbDnIEGvA/cay6BhtCHPFhPUMh58CCBhDvCxaBsfRaT/3a9PZnAGBxZz
	 gLPijFtPEAjPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF3F8C43443;
	Tue, 23 Jul 2024 19:03:58 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.11 (CORRECTION)
From: pr-tracker-bot@kernel.org
In-Reply-To: <1fb1189190ddd4c46b19e3e00cfa901388ee8835.camel@physik.fu-berlin.de>
References: <1fb1189190ddd4c46b19e3e00cfa901388ee8835.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <1fb1189190ddd4c46b19e3e00cfa901388ee8835.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.11-tag1
X-PR-Tracked-Commit-Id: 8fe76a1c2264a02155895cda9f97a6a5a9b97d91
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9680017b2dc8686a908ea1b51941a91b6da9f1d
Message-Id: <172176143870.11519.15113720456706837810.pr-tracker-bot@kernel.org>
Date: Tue, 23 Jul 2024 19:03:58 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Oscar Salvador <osalvador@suse.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh <linux-sh@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jul 2024 12:25:25 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.11-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9680017b2dc8686a908ea1b51941a91b6da9f1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

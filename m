Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DA8C0A
	for <linux-sh@vger.kernel.org>; Thu, 21 Mar 2024 17:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042477; cv=none; b=jJqNp6Alf/5ToKWEygSwwlyJYWZKqwOwoDJP4x8QRX2xoyMKIDhtohzFhVxS401rCTaTEtdqlytNp8o9VT6kKz9oY3M8vLIRBP3T+2lPRAC/7DajQuzeCpWJk41KNMDur3mjS+/T9OHvD597UMCnq0cJXG34JQk8Ta2i2ZWEuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042477; c=relaxed/simple;
	bh=GF53QRkUB90Ouv5EohF7ht/Q2CwL62CrUFvjQ8aF81g=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hVuPecmPbrCZxJcxXS6YkLLkJRDaENVwdmHbG+TRSd/V+YhvRje1zgs6tMRif7pCP4eSSmUj2T/KJwBNFRo2lXagR0Fsp+LnVzXH7V+4DtmMSsDm1AUw3rJOh5TRtuEM0CxYvbPNLrOGKYfUQIHE4BnRQl0OCLhc4ANUZeiFhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7V/GCNz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7V/GCNz"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D6B4C433C7;
	Thu, 21 Mar 2024 17:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711042477;
	bh=GF53QRkUB90Ouv5EohF7ht/Q2CwL62CrUFvjQ8aF81g=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=r7V/GCNzMEzsIE/RDr2niISPE8efHcpRCLoNattB0GniCElp9wNSaiv3lmORE9Uaf
	 8WzSN0t9o2IbNnxS85RcNqqp0eCCy+c3GkfOJ6c99sUmF0ba8TrWUp9sOBf/23NOUM
	 yYS9h08BEGH4cTue2vIN/o/He1HidHST8AjyO2LqMEh2bPwBOcwRoNuj75+Fcsaj/P
	 ifUbisxAHpuRleb8vFlDtIv6KwLRyRVpa1BuqcZTxGWbPmNwat/j3VzfWm3M3HK6I9
	 5oQEpIYaUTVlV3nV0qQBrfNpovpa5iB9OWLgeHsaVoptDisFiK4/bhDZjFo3UE7GeJ
	 p4vvkgXuSNHYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5425FD95060;
	Thu, 21 Mar 2024 17:34:37 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.9
From: pr-tracker-bot@kernel.org
In-Reply-To: <e05595fe22203dd8ec7a7800e25aedfc136b8aec.camel@physik.fu-berlin.de>
References: <e05595fe22203dd8ec7a7800e25aedfc136b8aec.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <e05595fe22203dd8ec7a7800e25aedfc136b8aec.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.9-tag1
X-PR-Tracked-Commit-Id: 1e21acb7fbfb15fcb4afe21fb5a50a1bc00743ec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26bbcd630f2f521e60d7ef0a58da188e766553ad
Message-Id: <171104247733.9254.9755820417880696605.pr-tracker-bot@kernel.org>
Date: Thu, 21 Mar 2024 17:34:37 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Artur Rojek <contact@artur-rojek.eu>, "Ricardo B.Marliere" <ricardo@marliere.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh <linux-sh@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Thu, 21 Mar 2024 14:52:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.9-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26bbcd630f2f521e60d7ef0a58da188e766553ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD51157A72
	for <linux-sh@vger.kernel.org>; Fri, 27 Sep 2024 17:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727457920; cv=none; b=Lu0uw17SjmjacISOUvWSg3JYvtjnSj0xNBLUFKU1CNIScJHYnOdtL1+7aXSQOEpxMYi5oH9enUBc3wg0VyBX33LC8uKEMXE2tuY80yOoBrfm5rZQCia+6ITDO9Okyvkx4V3rRdyuYDF0erqef6vw3LwKmqg88Y1pItbkLnyHIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727457920; c=relaxed/simple;
	bh=eNY/30W3RkWPtCg5aZajHM+k7gbHtam46jZkYs6nRmM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oxo/UvR7yIPrIBfvMj6SVfnrH8ZFp77TCQ2kVBisLYmJ6kdP9BCbnN4PKWc9OOpgesHqw6JaqhFaRaqtZp0C/gzNIZvmxhzAm5S77To5zSSeXADvey33Po+ZOD9bEXtXQOif084LwhL8gNBTSumx0iM6AQA4Jf1RqTF0MYIjM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFMxBmii; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFMxBmii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 104D9C4CEC4;
	Fri, 27 Sep 2024 17:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727457920;
	bh=eNY/30W3RkWPtCg5aZajHM+k7gbHtam46jZkYs6nRmM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=oFMxBmiih9Je4V+mRofDOcOtqbpurjI0/GgYlREqiyd9Of7F6oMec/DsDtlQ194jo
	 eGDkCOZx/HFSnPVArxjFGe5wXTGOw5j/uaaIEixo9K5rgT7xohPcAt+6HVUJQob4Kd
	 jv0D7w70lFF0IMzs3HjJsZOVThoa5d62lggo+ZSc6ujkaLACRu6Bf+cU5NZ3NwJhcN
	 tjEXhRi2h93unfupN6ocSFiNQYA5/1y0JK3ugXigQNo2aKeEm+vIlztkLZB46ZELS5
	 B83VhASK8dPOJjztaeJJ85cA3OcV9k+zIHtshG4cMMrnISIhg7JkxFh913s7WyQnqf
	 80FG3aqUE/sGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5863809A80;
	Fri, 27 Sep 2024 17:25:23 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <37b245abd7eaee997eabaf74aeb02bd7d5f2e983.camel@physik.fu-berlin.de>
References: <37b245abd7eaee997eabaf74aeb02bd7d5f2e983.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-sh.vger.kernel.org>
X-PR-Tracked-Message-Id: <37b245abd7eaee997eabaf74aeb02bd7d5f2e983.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.12-tag1
X-PR-Tracked-Commit-Id: c3e878ca7b6663d2ad77a6e17460fc47a2347f4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec38498450a96a8d85f0409d9e4a41415cde9c1d
Message-Id: <172745792251.2030610.3723087033784615350.pr-tracker-bot@kernel.org>
Date: Fri, 27 Sep 2024 17:25:22 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-sh <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh <linux-sh@vger.kernel.org>, Hongbo Li <lihongbo22@huawei.com>, Gaosheng Cui <cuigaosheng1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 27 Sep 2024 15:17:48 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.12-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec38498450a96a8d85f0409d9e4a41415cde9c1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792987640;
	b=c5rgApMBWksvpkpmohPUShJdF6Xt5PaCAaCIZp6GOBZGDOd3wK7wlkvqWA+UrQlMEYQ8
	 mOktdI8EL5XQmT67hkOuTsB0ZUXTreMR5wfFbanwUsDpJ+KtZjiIS3nuL+WsccMzyhNp5
	 XK/yqKYcwI04xkYTfGzO4ThLIqgMpdtixygSWWyO9Npy/r5xqMNTDPs9TNI6aUsZUSEsQ
	 QCAvkGKUXhDN1spp0R474bCmR5b3wlCfI+DDsK6vXbjSjaLbHjIAdCZ+UiZUeZhjp5gCG
	 VWMcjkSt7WDDn5vPywkvCA7XDCLzbzEeI/6D7MvpMQMeHFhGiEkYWiOtn7LQT+6T2PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792987640;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=2vRMZbacmySzNGUn8WSwiNYuSu69FcIXaed/9EqnY7Q=;
	b=tdqOWEtuNjhZcogkdrWFB5Sa1yAUNDfiau4FU52GOR6omO6joW2Ns0WhMOul1AxoJCnT
	 qN58gSBH7q1+XFS0w+NWznKuUE+zQEa3QJ7YGT4YaMSPsu7MC3ZwHdPCurR3I/oy3G3U5
	 tZLp3Ue42N4ARDcaQPp+mryoMa7LpG8E4Nzi79loeX7vHTX3cBwgNHuRxlTSuftfQsdnB
	 su9iDBud8wo1DQTRIKfO3M+PPI8REZvShkTyVkYSugddyPcx+MFuTZ6xaF3E/mrBVGuVH
	 wf+xrTug2Xidpi/nGMlYYAupjam65Gj6SpTq6ll0AbZgriarmPO12oJnb9mydUxmdPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdmxNTdh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0167606A321;
	Mon, 26 Oct 2026 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZdmxNTdh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7631F01825;
	Mon, 26 Oct 2026 04:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792987639;
	bh=2vRMZbacmySzNGUn8WSwiNYuSu69FcIXaed/9EqnY7Q=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=ZdmxNTdhqsXDOO4151X/RMG1VChNiuygJ0OYcjmKT2e+1z4pBcp2vJK0BlcEwU0J0
	 9Jf6PzxHJoxT1+IRNIxaFM13ey1Ipl+iWavZkO1goX5F8/fYl2LLODUkxEsxm1/7uH
	 Iwqor2+zvdpH2hcXcCXVu1X8SHexs9Pdy7aadTulw16hZN+0zpGeF0OYjCHmCoqN61
	 KoYmv74Nqn2HR5NKeERCeb49ZH2UhD/zeqluihUwvb2tNYdUT03t7mq8DJWFVkYx+V
	 Le09epjxmLV6YFbczwu94NLRNUZ64QRAXfeFsvSMCHvbH92d1k3G75l7OL3uf1ZtTN
	 IVIcfnwYk99ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8151239EA761;
	Mon, 26 Oct 2026 04:07:19 +0000 (UTC)
Subject: Re: [GIT PULL] sh updates for v7.4
From: pr-tracker-bot@kernel.org
In-Reply-To: <3d0dc3463d42cf55ee69648fde508043b104369c.camel@physik.fu-berlin.de>
References: <3d0dc3463d42cf55ee69648fde508043b104369c.camel@physik.fu-berlin.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <3d0dc3463d42cf55ee69648fde508043b104369c.camel@physik.fu-berlin.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v7.4-tag1
X-PR-Tracked-Commit-Id: f45711b39e03ff5e80b60dcc1fd34b3fc7d3d36c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44dc57ed1e77a23248ef28732486f4b7e9468cf7
Message-Id: <179298763810.2452649.1059596724368197811.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 04:07:18 +0000
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Fuchs <fuchsfl@gmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>, Runyu Xiao <runyu.xiao@seu.edu.cn>, Waldemar Brodkorb <wbx@openadk.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <yoshinori.sato@nifty.com>, linux-sh <linux-sh@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sun, 25 Oct 2026 11:02:46 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v7.4-tag1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44dc57ed1e77a23248ef28732486f4b7e9468cf7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

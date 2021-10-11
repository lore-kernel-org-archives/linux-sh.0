Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DEDC433F5
	for <linux-sh@archiver.kernel.org>; Mon, 11 Oct 2021 17:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C013B61040
	for <linux-sh@archiver.kernel.org>; Mon, 11 Oct 2021 17:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhJKRD7 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233351AbhJKRDx (ORCPT <rfc822;linux-sh@vger.kernel.org>);
        Mon, 11 Oct 2021 13:03:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C0A460F3A;
        Mon, 11 Oct 2021 17:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633971713;
        bh=5cqL9zWFZBEBMTUX4ZfpDqFN24XzofHHL51jBod0crk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PB1fq8/VYbqOg3HlflwTVaaHg9aibDKfx91ypOkx1H2qs1SxAs14Oj/+pdmMX/2ZW
         brEt4C2FEwsqsBRR2wJk6/CfEhXNvSbW+xvzt5CUru6Ek8vSXh5PI7+dLUKTZF6akp
         vaeTvsSl+1aXbAFgZoA5oCgVx7NPCmHNGkpTTj6e1wToSNsGMgn9Fyr5Lxv6vCTA3J
         hMjDCeQTqpuus+U6BHbjgdw76hYMlE0Yc+ufAz56CJp5D0DinR+gp475pqNWcLkp0E
         7iQx+glAMWVpPJHWT5JWOLBryz+KVevcIsCd9KMBhS/VpQ7a/RxkWLChuArXWtf5H8
         egSS6YVOe85LA==
From:   Mark Brown <broonie@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] sh: Use modern ASoC DAI format terminology
Date:   Mon, 11 Oct 2021 18:01:40 +0100
Message-Id: <163397094549.6567.3207662556586178987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915172302.36677-1-broonie@kernel.org>
References: <20210915172302.36677-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Wed, 15 Sep 2021 18:23:02 +0100, Mark Brown wrote:
> The SH machine drivers have some ASoC DAI format specifications that use
> older defines based on outdated terminology which we're trying to retire,
> update to the new bindings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] sh: Use modern ASoC DAI format terminology
      commit: 81a13ac7e3e490a76fafb7f62d1dd751ae94ca11

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

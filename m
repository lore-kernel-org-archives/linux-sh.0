Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD9AE7D245
	for <linux-sh@archiver.kernel.org>; Tue, 26 Sep 2023 07:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjIZHia (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 26 Sep 2023 03:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjIZHia (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 26 Sep 2023 03:38:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B0E5
        for <linux-sh@vger.kernel.org>; Tue, 26 Sep 2023 00:38:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CE8C433C8;
        Tue, 26 Sep 2023 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695713903;
        bh=lAxQ/0UTOT6och3JNE/pLFZ/B7SYTjvg5W8X6grQGBY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=D/eiAEd9O7qxPjQYtvyYsV5HfDWJqAGs+tQOLry/aU2hDtmR/zW5+YU1KtmydfsHp
         C0J3CsoFZNG1AhbK+0Y6yhj0gsdTfd2g4w1YZhozlLPUtQkOFTTLVf11CgzofhXV8p
         n4CwZWGDfuF0AjEyIuEsEnyohJZ2jUi8LY/CglKKJI3JhFj5iy0oTeeCzKliDrb27p
         igIL6E9l4L+/aLKYxmaP///lzIu9Zqz1g3/wE6cU83jGpdxq5kixEpxnK+hTuvRd6D
         KoLDpLPDCNSIGSmSBpQD+4m4p5essANZndQBCmB3f5ySBvnUyVh/63ndLohSJroQ/a
         bMb+lPS3CIYRQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     alsa-devel@alsa-project.org, linux-sh@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230925125646.3681807-1-geert+renesas@glider.be>
References: <20230925125646.3681807-1-geert+renesas@glider.be>
Subject: Re: [PATCH] ASoC: sh: dma-sh7760: Use %pad and %zu to format
 dma_addr_t and size_t
Message-Id: <169571390161.2496919.5867587395937945663.b4-ty@kernel.org>
Date:   Tue, 26 Sep 2023 09:38:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Mon, 25 Sep 2023 14:56:46 +0200, Geert Uytterhoeven wrote:
> sound/soc/sh/dma-sh7760.c: In function ‘camelot_prepare’:
> ./include/linux/kern_levels.h:5:25: warning: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘unsigned int’ [-Wformat=]
>     5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
> sound/soc/sh/dma-sh7760.c:198:9: note: in expansion of macro ‘pr_debug’
>   198 |         pr_debug("PCM data: addr 0x%08lx len %d\n",
>       |         ^~~~~~~~
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sh: dma-sh7760: Use %pad and %zu to format dma_addr_t and size_t
      commit: 1056063756d7bbd5e49532278448cd28ecb8f359

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


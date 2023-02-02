Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7683C61DA4
	for <linux-sh@archiver.kernel.org>; Thu,  2 Feb 2023 23:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjBBXRv (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbjBBXRu (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 2 Feb 2023 18:17:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087538243B;
        Thu,  2 Feb 2023 15:17:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C7C9B828B0;
        Thu,  2 Feb 2023 23:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12985C433D2;
        Thu,  2 Feb 2023 23:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675379864;
        bh=aPkq8NZ1lbmSPBLGMRFQ2aW/WOpxbRAoxbS/sDVifD8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jtcR4lAd8GaHEdV8KoG0hgzP+Zv9JQkkoVq3kozJkI8jdDpxh97U6wy7F1oyYmFmz
         qLaZWqUcfsDvG0pl7TPppY5LzKMa3KGbGEmzi9tLQcCvPrbO6v4ykBsX+0xbwBWy03
         FmrlqHymNDkojyeDSuIFG0ytineL7dTI5ZUTGPoHDxTYuoa6HzUeWjmA71AkPIiVvX
         AieznHIRhH2vJb+knRf3cJ7cj5vACBrr9/fG04jzzMO5Qd/u6bgk0HKUMZ0NTN+hLD
         zF7fO+FjyNUks0lF7Tndbr3dbLYSeBUWVxThbRd2a8Qff+oA/DaLo6zimAPEdBImmc
         yh0jn7gCtITdg==
Message-ID: <dd8ca920edbe54374b4bd4b82b65e9f6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b53e6b557b4240579933b3359dda335ff94ed5af.1675354849.git.geert+renesas@glider.be>
References: <b53e6b557b4240579933b3359dda335ff94ed5af.1675354849.git.geert+renesas@glider.be>
Subject: Re: [PATCH] sh: clk: Fix clk_enable() to return 0 on NULL clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-sh@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Date:   Thu, 02 Feb 2023 15:17:41 -0800
User-Agent: alot/0.10
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Quoting Geert Uytterhoeven (2023-02-02 08:20:55)
> On SH, devm_clk_get_optional_enabled() fails with -EINVAL if the clock
> is not found.  This happens because __devm_clk_get() assumes it can pass
> a NULL clock pointer (as returned by clk_get_optional()) to the init()
> function (clk_prepare_enable() in this case), while the SH
> implementation of clk_enable() considers that an error.
>=20
> Fix this by making the SH clk_enable() implementation return zero
> instead, like the Common Clock Framework does.
>=20
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

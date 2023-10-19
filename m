Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889E2CDB483
	for <linux-sh@archiver.kernel.org>; Thu, 19 Oct 2023 11:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345437AbjJSLzn (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 19 Oct 2023 07:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjJSLzl (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 19 Oct 2023 07:55:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027CDCF
        for <linux-sh@vger.kernel.org>; Thu, 19 Oct 2023 04:55:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4066C433C9;
        Thu, 19 Oct 2023 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697716539;
        bh=HN+vxwNMgGEWu7+aX5z91BtOzyVIQ/R6HW9XlzYFmS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3cii6dX/9ST66j/gtY1nE3sVFqO+8GwPiPoqN93QTCTdQO6xZo9GR1wfg3xeg4RX
         8EnyBg/yPk+wjJQMnzHvyY1O2l/eg8Pe0tVgjQzSlVovoJSgdHEdTOW/ko2H5dU+mr
         cBewP62V7PiXDuNeL4iI0LveqEzmyujwqRvFOCWHjRgVcwZdI3qrCM6+caAJ+JE3ag
         Ef8EjsHkSQbz7t1OTyCV66rY601PPfsUiONPK0CDzDisWPbvj/PIVnvbq0Y5oa2fjS
         zPBGpEcka1y5ruRitmsYIHL4Q6oEA/HkcEo0qDKg/sENObMu21HfQOnO1jOy73cUEW
         //CYrBg2On+ow==
Date:   Thu, 19 Oct 2023 12:55:34 +0100
From:   Lee Jones <lee@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de,
        deller@gmx.de, tzimmermann@suse.de, sam@ravnborg.org,
        robh@kernel.org, zhangxuezhi1@coolpad.com,
        u.kleine-koenig@pengutronix.de
Subject: Re: [RFC PATCH v3 20/35] drivers/mfd: sm501 add some properties.
Message-ID: <20231019115534.GB2424087@google.com>
References: <cover.1697199949.git.ysato@users.sourceforge.jp>
 <b1bedaea12693d256b2513f72bd39630a69d188a.1697199949.git.ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1bedaea12693d256b2513f72bd39630a69d188a.1697199949.git.ysato@users.sourceforge.jp>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Sat, 14 Oct 2023, Yoshinori Sato wrote:

> I am changing the target board of SuperH using SM501 to DeviceTree.
> This target uses platform_device to configure sm501 and sm501fb.
> In order to migrate to DeviceTree, it can now be set in properties.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/mfd/sm501.c           | 113 ++++++++++++++++++++++++++++++++++
>  drivers/video/fbdev/sm501fb.c |  92 +++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)

Wow!  This is a 20 year old driver.  I'm surprised to see it in use.

FYI, the driver itself seems to be in a bit of state.  It would not be
accepted in its current guise if submitted in the present.

When you submit your next revision, would you please add me to the
recipients list on the *whole set* please?

Not sure I can review this until the DT guys have rubber stamped the
binding.  Some of the proposed properties look like they'll need a
re-work; specifically 'smi,devices' which looks like a bitmap of the
devices to be enabled.

-- 
Lee Jones [李琼斯]

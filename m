Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D719CA5537
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjIMKnX (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjIMKnX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:43:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A939D19B3;
        Wed, 13 Sep 2023 03:43:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C766DC433C8;
        Wed, 13 Sep 2023 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694601796;
        bh=mgTU2OsXODY9FKisLi6oeiuKETeBV0zpQtqo9jl4dio=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nqa1wfAe0eNRIqQFK/76F96LWA+eEsdqM/lejKLLesMTjrvlogiGA6G+PR1EyPrev
         g8L26d5U/JSrFH16+z0jIYX5OTOaW/KPUmArxaj5y0hTc3rQC0pMDT69fpzMhlmdSU
         ZJGP6sdF6xLR0x5tytFI7OBOd98Udmw/T44dyx11u8sODJeOVG6VZLNGNOfjJjQOWp
         A6qNsh1q0k/SFjH7nSQdvJBTPg/5rweqPXUJnKflp7nHazxxoairdheyShGn+gxu2A
         CjIv5RWolL5BfOx6j9ZDZfVJSKP7zkLobYs/jPzMPwZpVCbqW1e0FB/eg6ryMkiy8a
         XIKZgvc+mcr9g==
Message-ID: <2edce62c-ae8d-e39c-9287-ff7ae05773d2@kernel.org>
Date:   Wed, 13 Sep 2023 12:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 10/30] drivers/clk: SH7750 / SH7751 CPG Driver
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de, linux-clk@vger.kernel.org
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <a9a3e6f0dfdd1c5d6970d2decffef3c07d93476e.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <a9a3e6f0dfdd1c5d6970d2decffef3c07d93476e.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

1. Commit msg did not improve.
2. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching. There is no "drivers" (except few
subsystems, but not this one).


Best regards,
Krzysztof


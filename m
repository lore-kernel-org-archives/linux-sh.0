Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37800CA5534
	for <linux-sh@archiver.kernel.org>; Wed, 13 Sep 2023 10:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjIMKod (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 13 Sep 2023 06:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjIMKod (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 13 Sep 2023 06:44:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A6919AC;
        Wed, 13 Sep 2023 03:44:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4444AC433C7;
        Wed, 13 Sep 2023 10:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694601868;
        bh=3zcLxmU5BUge9Celik9VIjjilgd97nwjS6PTHS3MhhM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sPv4bRO9Z4FNpviI4RKUfxxbxj3XHWDIWOqPxQu0SPeVRKwe+OpTgc/5xi9LekPQd
         5ujp6II1nhWZvfOBu/SxRjwHACgATnaqf9MI38DKolNHgQZELXkTRqL8YYv/4Xht/C
         /AsHYUyvhJgOzqHvoMAUAGMTo0CTT8kOJB3qhPRCiCMfjndW4/Yn8Hj3zBguerlh/K
         nYaSDoUrRYfsEzIeAqwFUn9rru5AXjc8rQ+0n9ctN5+MZw4lKcgyZbLXpowPLiSNbY
         zJmCvQUejarmU22uFAIeAR4Kuy+n3uzEmM3p3+kPHNZSy3J/DcZkwUd4VEKNK8vlWK
         GY0mgj2+xLGbA==
Message-ID: <d2e15144-a110-c2af-4035-a65486d268bc@kernel.org>
Date:   Wed, 13 Sep 2023 12:44:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2 13/30] Documentation/devicetree: Add
 renesas,sh7751-cpg binding document.
Content-Language: en-US
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     glaubitz@physik.fu-berlin.de, linux-clk@vger.kernel.org
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <66ed5e27cb600f3317d315c4fd60bd3e9eb09c17.1694596125.git.ysato@users.sourceforge.jp>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <66ed5e27cb600f3317d315c4fd60bd3e9eb09c17.1694596125.git.ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 13/09/2023 11:23, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

Same problems as before. Also:

1. Please use subject prefixes matching the subsystem. You can get them
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching.

2. Drop redundant "binding document." Drop full-stop from subject.
Subjects do not have full stops, unlike commit msg which here is missing.

3. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC. It might happen, that command when run on an
older kernel, gives you outdated entries. Therefore please be sure you
base your patches on recent Linux kernel.

You missed at least devicetree list (maybe more), so this won't be
tested by automated tooling. Performing review on untested code might be
a waste of time, thus I will skip this patch entirely till you follow
the process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


Best regards,
Krzysztof


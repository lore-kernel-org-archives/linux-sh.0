Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E7C3E8C5
	for <linux-sh@archiver.kernel.org>; Sun, 29 Nov 2020 20:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813CF20756
	for <linux-sh@archiver.kernel.org>; Sun, 29 Nov 2020 20:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="qPUAP1e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgK2Uah (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 29 Nov 2020 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgK2Uag (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 29 Nov 2020 15:30:36 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD10DC0613CF
        for <linux-sh@vger.kernel.org>; Sun, 29 Nov 2020 12:29:56 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id b6so9042652pfp.7
        for <linux-sh@vger.kernel.org>; Sun, 29 Nov 2020 12:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sgEOisx8j9cOgYZtAs+sdAiapLFFrQ3Vk6rUd8fKu+E=;
        b=qPUAP1e2Avb/FLxDoBlzIv/OdODLueNKQXl/ecpM3OW5lC32P9TYHkuiLKLLRQHmVV
         IDRcXqCESVN16d6KhT0/vFmntMhc3iG8Z2YSGMbcEZfa4E/04FwURZbZNqigpnm2u/Bx
         vIPVS4JDjt7dT19+4V4UNkAI5GqKR9gDlc4NPJbjbKx56ggwNic49qdtLAUi/UqSu1Ja
         FRNvXPuvpL7bcn4fs6YHs2FL0WkcXxh+uQCbFFDqmdSrsT1vuUpBDI9y6YVeX8rQBZ7n
         4Eei+oGPGJrzwRaCrlsks0HVssXDI8oyVltT69bBgzECJTbiy+TwKpC8iKGPBWeMBqF8
         EkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sgEOisx8j9cOgYZtAs+sdAiapLFFrQ3Vk6rUd8fKu+E=;
        b=QepUtSpmJrkBTqlB8uqxztz73pzT54/MjY7jk0XftOMXgnaCydg5um3TZ/4oubEm2F
         k+0OBShrozcLpnsq6iOrixyLQntKyYowBFrywNCuKj1wewNnN3fdMs0Tp8ljgCaCJV45
         LqRctcIDk2vzbnNTZ/J5EiNO80+n3zF0Sn8X+UPd/rPGTVrLMbqq0MfFuzE3KpyCyiN8
         hJn+Y2p70YMJUK910qIWhqmfAdi0zYIGPxyM5PwRETrbLFKd1Z9kJZuNo5wKT68GUzVC
         +5HID6JcwNf+L/VNXnEzZNkT8XpBpniBBwissYOGZ5k8960bGtQGQo9xtqFAzrqW98d5
         7lHA==
X-Gm-Message-State: AOAM5301wHxRz0Or8mLm8Xml0rJq6OlL5wnEA3Ie9uA9yD9se4d1cVJb
        VAkX2TJOGNaOhE1vRS4C6qVmI3efzXmQFA==
X-Google-Smtp-Source: ABdhPJwY/xttKcrgehJiIvmkzZ+HmLJov8/488C6jbJPAFd6A4vcL9kfl2JSNRVLnlY8S/CGm+R2fA==
X-Received: by 2002:a65:5a8d:: with SMTP id c13mr12801845pgt.265.1606681795586;
        Sun, 29 Nov 2020 12:29:55 -0800 (PST)
Received: from [192.168.8.125] (mo49-103-224-80.air.mopera.net. [49.103.224.80])
        by smtp.gmail.com with ESMTPSA id s15sm13571323pga.43.2020.11.29.12.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 12:29:54 -0800 (PST)
Subject: Re: Kernel crash when syncing to usb-storage
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
 <91ca51a8-5021-9b28-d404-fb7e227f2e51@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <01a41a3a-0262-0614-4843-9e4d8a2c35a0@landley.net>
Date:   Sun, 29 Nov 2020 14:41:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <91ca51a8-5021-9b28-d404-fb7e227f2e51@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/29/20 10:42 AM, John Paul Adrian Glaubitz wrote:
> On 11/17/20 10:39 PM, John Paul Adrian Glaubitz wrote:
>> Recently, I have started to see crashes when I try to sync a FAT filesystem
>> on a USB pen drive. The crash is reproducible and seems to have been introduced
>> in the 5.10 development cycle. I have not bisected the issue yet.
> 
> I tried bisecting this but I failed twice because git is chocking on the merge
> commits. Currently out of ideas but I'm pasting the git bisect logs in case
> anyone has got any idea.

Choking as in... doesn't compile?

> glaubitz@epyc:..glaubitz/linux-git> cat ~/sh4-bisect-5.10-regression.txt
> git bisect start
> # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
> git bisect good bbf5c979011a099af5dc76498918ed7df445635b
> # bad: [aae5ab854e38151e69f261dbf0e3b7e396403178] Merge tag 'riscv-for-linus-5.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
> git bisect bad aae5ab854e38151e69f261dbf0e3b7e396403178
> # bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
> git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
> # bad: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag 'devicetree-for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
> git bisect bad f888bdf9823c85fe945c4eb3ba353f749dec3856
> # bad: [57218d7f2e87069f73c7a841b6ed6c1cc7acf616] Merge tag 'regmap-v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
> git bisect bad 57218d7f2e87069f73c7a841b6ed6c1cc7acf616
> # bad: [39a5101f989e8d2be557136704d53990f9b402c8] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
> git bisect bad 39a5101f989e8d2be557136704d53990f9b402c8
> # bad: [ed016af52ee3035b4799ebd7d53f9ae59d5782c4] Merge tag 'locking-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad ed016af52ee3035b4799ebd7d53f9ae59d5782c4
> # bad: [f94ab231136c53ee26b1ddda76b29218018834ff] Merge tag 'x86_cleanups_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad f94ab231136c53ee26b1ddda76b29218018834ff
> # good: [baab853229ec1f291cec6a70ed61ce93159d0997] Merge branch 'for-next/mte' into for-next/core
> git bisect good baab853229ec1f291cec6a70ed61ce93159d0997
> # bad: [ca1b66922a702316734bcd5ea2100e5fb8f3caa3] Merge tag 'ras_updates_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
> git bisect bad ca1b66922a702316734bcd5ea2100e5fb8f3caa3
> # bad: [af9db1d6632b726a2351426ab8f34374f6f38690] Merge tag 'm68k-for-v5.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
> git bisect bad af9db1d6632b726a2351426ab8f34374f6f38690
> # bad: [6734e20e39207556e17d72b5c4950d8f3a4f2de2] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
> git bisect bad 6734e20e39207556e17d72b5c4950d8f3a4f2de2
> # good: [d433ab42fdc2c8a32e5df7d53833310f0ab9822c] arm64: random: Remove no longer needed prototypes
> git bisect good d433ab42fdc2c8a32e5df7d53833310f0ab9822c
> # bad: [55707d531af62bd87c1b7e8d66fd9798094f9b3b] tpm_tis: Add a check for invalid status
> git bisect bad 55707d531af62bd87c1b7e8d66fd9798094f9b3b
> # bad: [a4c3049784551f6622be7f9a0a2dc993d4ba3149] dt-bindings: Add SynQucer TPM MMIO as a trivial device
> git bisect bad a4c3049784551f6622be7f9a0a2dc993d4ba3149
> # bad: [d5ae56a4fe5178e289e763450362d87800f9dcac] tpm: tis: add support for MMIO TPM on SynQuacer
> git bisect bad d5ae56a4fe5178e289e763450362d87800f9dcac
> # first bad commit: [d5ae56a4fe5178e289e763450362d87800f9dcac] tpm: tis: add support for MMIO TPM on SynQuacer
> glaubitz@epyc:..glaubitz/linux-git>

Hmmm... the "bad" before your last "good" is not an ancestor of that good.

> glaubitz@epyc:..glaubitz/linux-git> cat ~/sh4-bisect-5.10-regression-2.txt
> git bisect start
> # good: [d433ab42fdc2c8a32e5df7d53833310f0ab9822c] arm64: random: Remove no longer needed prototypes
> git bisect good d433ab42fdc2c8a32e5df7d53833310f0ab9822c
> # bad: [55707d531af62bd87c1b7e8d66fd9798094f9b3b] tpm_tis: Add a check for invalid status
> git bisect bad 55707d531af62bd87c1b7e8d66fd9798094f9b3b
> # good: [f75aef392f869018f78cfedf3c320a6b3fcfda6b] Linux 5.9-rc3
> git bisect good f75aef392f869018f78cfedf3c320a6b3fcfda6b
> # bad: [6c7247f6258b2dba353c885a1b00d795a380cc85] Merge tag 'staging-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> git bisect bad 6c7247f6258b2dba353c885a1b00d795a380cc85
> # good: [d824e0809ce3c9e935f3aa37381cda7fd4184f12] Merge tag 'libata-5.9-2020-09-04' of git://git.kernel.dk/linux-block
> git bisect good d824e0809ce3c9e935f3aa37381cda7fd4184f12
> # good: [d67f2ec1f5fed849d9773cd783ea161df842bbae] Merge tag 'drm-fixes-2020-09-11' of git://anongit.freedesktop.org/drm/drm
> git bisect good d67f2ec1f5fed849d9773cd783ea161df842bbae
> # good: [b952e974300be3184049a125e7cba112fe659017] Merge tag 'for-linus' of git://github.com/openrisc/linux
> git bisect good b952e974300be3184049a125e7cba112fe659017
> # good: [2a1a4bee5ef277c7dc2906d9268db61478876288] Merge tag 'char-misc-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> git bisect good 2a1a4bee5ef277c7dc2906d9268db61478876288
> # bad: [54f82df2ba86e2a8e9cbf4036d192366e3905c89] iio:adc:ti-adc081c Fix alignment and data leak issues
> git bisect bad 54f82df2ba86e2a8e9cbf4036d192366e3905c89
> # bad: [95ad67577de4ea08eb8e441394e698aa4addcc0b] iio: accel: kxsd9: Fix alignment of local buffer.
> git bisect bad 95ad67577de4ea08eb8e441394e698aa4addcc0b
> # bad: [336306790b2bbf7ce837625fa3b24ba724d05838] iio: cros_ec: Set Gyroscope default frequency to 25Hz
> git bisect bad 336306790b2bbf7ce837625fa3b24ba724d05838
> # bad: [fea22e159d51c766ba70473f473a0ec914cc7e92] staging: wlan-ng: fix out of bounds read in prism2sta_probe_usb()
> git bisect bad fea22e159d51c766ba70473f473a0ec914cc7e92
> # bad: [b15b4da88be52e7455acc59318f6c97b8740b329] staging: greybus: audio: Uninitialized variable in gbaudio_remove_controls()
> git bisect bad b15b4da88be52e7455acc59318f6c97b8740b329
> # first bad commit: [b15b4da88be52e7455acc59318f6c97b8740b329] staging: greybus: audio: Uninitialized variable in gbaudio_remove_controls()
> glaubitz@epyc:..glaubitz/linux-git>

This implies it doesn't occur 100% of the time. You may need to run 3 tests each
time before declaring "good". (Good just says you didn't see it, not that it
isn't there. Race conditions, uninitialized variables, incompletely initialized
registers in hardware...)

Another thing I've sometimes done when git bisect gets confused by merges is:

  git log --no-merges v5.9..master | grep '^commit'

and then manually bisect through THAT (pick a commit in the middle to try, but
only trim "after this bad" from the list. You're specifically looking for the
oldest commit where the problem manifests, which can have runs of "good" after
it due to branches. But nothing after a bad you've found can matter, and you can
usually get to one where "git log" back from that earliest bad commit you
identified is a smallish number of commits until the next known/tested good in
the history.

(Every once in a while something IS introduced by a merge commit, but you can
use that technique to prove it in an understandable way, instead of the bisect
black box.)

I'd try this myself, except for the can't reproduce the failure to distinguish
good from bad part...

Rob

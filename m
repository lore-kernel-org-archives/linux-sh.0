Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317E4C3E8C5
	for <linux-sh@archiver.kernel.org>; Sun, 29 Nov 2020 22:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29B92078D
	for <linux-sh@archiver.kernel.org>; Sun, 29 Nov 2020 22:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgK2WI2 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 29 Nov 2020 17:08:28 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37965 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725950AbgK2WI2 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 29 Nov 2020 17:08:28 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kjUrB-001eKp-OX; Sun, 29 Nov 2020 23:07:45 +0100
Received: from p57bd9091.dip0.t-ipconnect.de ([87.189.144.145] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kjUrB-003zQc-8S; Sun, 29 Nov 2020 23:07:45 +0100
Subject: Re: Kernel crash when syncing to usb-storage
To:     Rob Landley <rob@landley.net>
References: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
 <91ca51a8-5021-9b28-d404-fb7e227f2e51@physik.fu-berlin.de>
 <01a41a3a-0262-0614-4843-9e4d8a2c35a0@landley.net>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <55c49a20-9352-ee71-4e52-bdd0941bb474@physik.fu-berlin.de>
Date:   Sun, 29 Nov 2020 23:07:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <01a41a3a-0262-0614-4843-9e4d8a2c35a0@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.144.145
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/29/20 9:41 PM, Rob Landley wrote:
> On 11/29/20 10:42 AM, John Paul Adrian Glaubitz wrote:
>> On 11/17/20 10:39 PM, John Paul Adrian Glaubitz wrote:
>>> Recently, I have started to see crashes when I try to sync a FAT filesystem
>>> on a USB pen drive. The crash is reproducible and seems to have been introduced
>>> in the 5.10 development cycle. I have not bisected the issue yet.
>>
>> I tried bisecting this but I failed twice because git is chocking on the merge
>> commits. Currently out of ideas but I'm pasting the git bisect logs in case
>> anyone has got any idea.
> 
> Choking as in... doesn't compile?

No, I simply can't finding the bad commit and the bisect ends in different bad
commits which are completely unrelated changes.

>> glaubitz@epyc:..glaubitz/linux-git> cat ~/sh4-bisect-5.10-regression.txt
>> git bisect start
>> # good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
>> git bisect good bbf5c979011a099af5dc76498918ed7df445635b
>> # bad: [aae5ab854e38151e69f261dbf0e3b7e396403178] Merge tag 'riscv-for-linus-5.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
>> git bisect bad aae5ab854e38151e69f261dbf0e3b7e396403178
>> # bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
>> git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
>> # bad: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag 'devicetree-for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
>> git bisect bad f888bdf9823c85fe945c4eb3ba353f749dec3856
>> # bad: [57218d7f2e87069f73c7a841b6ed6c1cc7acf616] Merge tag 'regmap-v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
>> git bisect bad 57218d7f2e87069f73c7a841b6ed6c1cc7acf616
>> # bad: [39a5101f989e8d2be557136704d53990f9b402c8] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
>> git bisect bad 39a5101f989e8d2be557136704d53990f9b402c8
>> # bad: [ed016af52ee3035b4799ebd7d53f9ae59d5782c4] Merge tag 'locking-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect bad ed016af52ee3035b4799ebd7d53f9ae59d5782c4
>> # bad: [f94ab231136c53ee26b1ddda76b29218018834ff] Merge tag 'x86_cleanups_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect bad f94ab231136c53ee26b1ddda76b29218018834ff
>> # good: [baab853229ec1f291cec6a70ed61ce93159d0997] Merge branch 'for-next/mte' into for-next/core
>> git bisect good baab853229ec1f291cec6a70ed61ce93159d0997
>> # bad: [ca1b66922a702316734bcd5ea2100e5fb8f3caa3] Merge tag 'ras_updates_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect bad ca1b66922a702316734bcd5ea2100e5fb8f3caa3
>> # bad: [af9db1d6632b726a2351426ab8f34374f6f38690] Merge tag 'm68k-for-v5.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
>> git bisect bad af9db1d6632b726a2351426ab8f34374f6f38690
>> # bad: [6734e20e39207556e17d72b5c4950d8f3a4f2de2] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
>> git bisect bad 6734e20e39207556e17d72b5c4950d8f3a4f2de2
>> # good: [d433ab42fdc2c8a32e5df7d53833310f0ab9822c] arm64: random: Remove no longer needed prototypes
>> git bisect good d433ab42fdc2c8a32e5df7d53833310f0ab9822c
>> # bad: [55707d531af62bd87c1b7e8d66fd9798094f9b3b] tpm_tis: Add a check for invalid status
>> git bisect bad 55707d531af62bd87c1b7e8d66fd9798094f9b3b
>> # bad: [a4c3049784551f6622be7f9a0a2dc993d4ba3149] dt-bindings: Add SynQucer TPM MMIO as a trivial device
>> git bisect bad a4c3049784551f6622be7f9a0a2dc993d4ba3149
>> # bad: [d5ae56a4fe5178e289e763450362d87800f9dcac] tpm: tis: add support for MMIO TPM on SynQuacer
>> git bisect bad d5ae56a4fe5178e289e763450362d87800f9dcac
>> # first bad commit: [d5ae56a4fe5178e289e763450362d87800f9dcac] tpm: tis: add support for MMIO TPM on SynQuacer
>> glaubitz@epyc:..glaubitz/linux-git>
> 
> Hmmm... the "bad" before your last "good" is not an ancestor of that good.

I might have messed up there. I will try again.

> This implies it doesn't occur 100% of the time. You may need to run 3 tests each
> time before declaring "good". (Good just says you didn't see it, not that it
> isn't there. Race conditions, uninitialized variables, incompletely initialized
> registers in hardware...)

No, it's 100% reproducible. The moment the kernel writes to USB, it crashes.

> Another thing I've sometimes done when git bisect gets confused by merges is:
> 
>   git log --no-merges v5.9..master | grep '^commit'
> 
> and then manually bisect through THAT (pick a commit in the middle to try, but
> only trim "after this bad" from the list. You're specifically looking for the
> oldest commit where the problem manifests, which can have runs of "good" after
> it due to branches. But nothing after a bad you've found can matter, and you can
> usually get to one where "git log" back from that earliest bad commit you
> identified is a smallish number of commits until the next known/tested good in
> the history.

Thanks. I will try the bisect between v5.9 and HEAD again. Your first comment has
convinced I might have mis-tagged one or two commits as bad/good.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


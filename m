Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A88AC3E8C5
	for <linux-sh@archiver.kernel.org>; Sun, 29 Nov 2020 16:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E5A20738
	for <linux-sh@archiver.kernel.org>; Sun, 29 Nov 2020 16:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgK2Qm4 (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sun, 29 Nov 2020 11:42:56 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37973 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgK2Qm4 (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sun, 29 Nov 2020 11:42:56 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          for linux-sh@vger.kernel.org with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kjPm9-000XPd-Ky; Sun, 29 Nov 2020 17:42:13 +0100
Received: from p57bd9091.dip0.t-ipconnect.de ([87.189.144.145] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          for linux-sh@vger.kernel.org with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kjPm9-003N1t-5C; Sun, 29 Nov 2020 17:42:13 +0100
Subject: Re: Kernel crash when syncing to usb-storage
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linux-sh list <linux-sh@vger.kernel.org>
References: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
Message-ID: <91ca51a8-5021-9b28-d404-fb7e227f2e51@physik.fu-berlin.de>
Date:   Sun, 29 Nov 2020 17:42:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <d89a074e-c0ed-5d8b-a58e-ce3d420f579e@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.144.145
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 11/17/20 10:39 PM, John Paul Adrian Glaubitz wrote:
> Recently, I have started to see crashes when I try to sync a FAT filesystem
> on a USB pen drive. The crash is reproducible and seems to have been introduced
> in the 5.10 development cycle. I have not bisected the issue yet.

I tried bisecting this but I failed twice because git is chocking on the merge
commits. Currently out of ideas but I'm pasting the git bisect logs in case
anyone has got any idea.

glaubitz@epyc:..glaubitz/linux-git> cat ~/sh4-bisect-5.10-regression.txt
git bisect start
# good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9
git bisect good bbf5c979011a099af5dc76498918ed7df445635b
# bad: [aae5ab854e38151e69f261dbf0e3b7e396403178] Merge tag 'riscv-for-linus-5.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
git bisect bad aae5ab854e38151e69f261dbf0e3b7e396403178
# bad: [4d0e9df5e43dba52d38b251e3b909df8fa1110be] lib, uaccess: add failure injection to usercopy functions
git bisect bad 4d0e9df5e43dba52d38b251e3b909df8fa1110be
# bad: [f888bdf9823c85fe945c4eb3ba353f749dec3856] Merge tag 'devicetree-for-5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
git bisect bad f888bdf9823c85fe945c4eb3ba353f749dec3856
# bad: [57218d7f2e87069f73c7a841b6ed6c1cc7acf616] Merge tag 'regmap-v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap
git bisect bad 57218d7f2e87069f73c7a841b6ed6c1cc7acf616
# bad: [39a5101f989e8d2be557136704d53990f9b402c8] Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 39a5101f989e8d2be557136704d53990f9b402c8
# bad: [ed016af52ee3035b4799ebd7d53f9ae59d5782c4] Merge tag 'locking-core-2020-10-12' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad ed016af52ee3035b4799ebd7d53f9ae59d5782c4
# bad: [f94ab231136c53ee26b1ddda76b29218018834ff] Merge tag 'x86_cleanups_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad f94ab231136c53ee26b1ddda76b29218018834ff
# good: [baab853229ec1f291cec6a70ed61ce93159d0997] Merge branch 'for-next/mte' into for-next/core
git bisect good baab853229ec1f291cec6a70ed61ce93159d0997
# bad: [ca1b66922a702316734bcd5ea2100e5fb8f3caa3] Merge tag 'ras_updates_for_v5.10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad ca1b66922a702316734bcd5ea2100e5fb8f3caa3
# bad: [af9db1d6632b726a2351426ab8f34374f6f38690] Merge tag 'm68k-for-v5.10-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k
git bisect bad af9db1d6632b726a2351426ab8f34374f6f38690
# bad: [6734e20e39207556e17d72b5c4950d8f3a4f2de2] Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 6734e20e39207556e17d72b5c4950d8f3a4f2de2
# good: [d433ab42fdc2c8a32e5df7d53833310f0ab9822c] arm64: random: Remove no longer needed prototypes
git bisect good d433ab42fdc2c8a32e5df7d53833310f0ab9822c
# bad: [55707d531af62bd87c1b7e8d66fd9798094f9b3b] tpm_tis: Add a check for invalid status
git bisect bad 55707d531af62bd87c1b7e8d66fd9798094f9b3b
# bad: [a4c3049784551f6622be7f9a0a2dc993d4ba3149] dt-bindings: Add SynQucer TPM MMIO as a trivial device
git bisect bad a4c3049784551f6622be7f9a0a2dc993d4ba3149
# bad: [d5ae56a4fe5178e289e763450362d87800f9dcac] tpm: tis: add support for MMIO TPM on SynQuacer
git bisect bad d5ae56a4fe5178e289e763450362d87800f9dcac
# first bad commit: [d5ae56a4fe5178e289e763450362d87800f9dcac] tpm: tis: add support for MMIO TPM on SynQuacer
glaubitz@epyc:..glaubitz/linux-git>

glaubitz@epyc:..glaubitz/linux-git> cat ~/sh4-bisect-5.10-regression-2.txt
git bisect start
# good: [d433ab42fdc2c8a32e5df7d53833310f0ab9822c] arm64: random: Remove no longer needed prototypes
git bisect good d433ab42fdc2c8a32e5df7d53833310f0ab9822c
# bad: [55707d531af62bd87c1b7e8d66fd9798094f9b3b] tpm_tis: Add a check for invalid status
git bisect bad 55707d531af62bd87c1b7e8d66fd9798094f9b3b
# good: [f75aef392f869018f78cfedf3c320a6b3fcfda6b] Linux 5.9-rc3
git bisect good f75aef392f869018f78cfedf3c320a6b3fcfda6b
# bad: [6c7247f6258b2dba353c885a1b00d795a380cc85] Merge tag 'staging-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad 6c7247f6258b2dba353c885a1b00d795a380cc85
# good: [d824e0809ce3c9e935f3aa37381cda7fd4184f12] Merge tag 'libata-5.9-2020-09-04' of git://git.kernel.dk/linux-block
git bisect good d824e0809ce3c9e935f3aa37381cda7fd4184f12
# good: [d67f2ec1f5fed849d9773cd783ea161df842bbae] Merge tag 'drm-fixes-2020-09-11' of git://anongit.freedesktop.org/drm/drm
git bisect good d67f2ec1f5fed849d9773cd783ea161df842bbae
# good: [b952e974300be3184049a125e7cba112fe659017] Merge tag 'for-linus' of git://github.com/openrisc/linux
git bisect good b952e974300be3184049a125e7cba112fe659017
# good: [2a1a4bee5ef277c7dc2906d9268db61478876288] Merge tag 'char-misc-5.9-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
git bisect good 2a1a4bee5ef277c7dc2906d9268db61478876288
# bad: [54f82df2ba86e2a8e9cbf4036d192366e3905c89] iio:adc:ti-adc081c Fix alignment and data leak issues
git bisect bad 54f82df2ba86e2a8e9cbf4036d192366e3905c89
# bad: [95ad67577de4ea08eb8e441394e698aa4addcc0b] iio: accel: kxsd9: Fix alignment of local buffer.
git bisect bad 95ad67577de4ea08eb8e441394e698aa4addcc0b
# bad: [336306790b2bbf7ce837625fa3b24ba724d05838] iio: cros_ec: Set Gyroscope default frequency to 25Hz
git bisect bad 336306790b2bbf7ce837625fa3b24ba724d05838
# bad: [fea22e159d51c766ba70473f473a0ec914cc7e92] staging: wlan-ng: fix out of bounds read in prism2sta_probe_usb()
git bisect bad fea22e159d51c766ba70473f473a0ec914cc7e92
# bad: [b15b4da88be52e7455acc59318f6c97b8740b329] staging: greybus: audio: Uninitialized variable in gbaudio_remove_controls()
git bisect bad b15b4da88be52e7455acc59318f6c97b8740b329
# first bad commit: [b15b4da88be52e7455acc59318f6c97b8740b329] staging: greybus: audio: Uninitialized variable in gbaudio_remove_controls()
glaubitz@epyc:..glaubitz/linux-git>

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C3DC4361B
	for <linux-sh@archiver.kernel.org>; Fri, 18 Dec 2020 06:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175A123405
	for <linux-sh@archiver.kernel.org>; Fri, 18 Dec 2020 06:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbgLRG3k (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 18 Dec 2020 01:29:40 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:46139 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732785AbgLRG3k (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 18 Dec 2020 01:29:40 -0500
Received: by mail-ej1-f41.google.com with SMTP id j22so1536927eja.13;
        Thu, 17 Dec 2020 22:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p6sm2ullPipX+R/2HJtHxedMHLdzpauKOUOn9DVVdT8=;
        b=dJG99sQ7OL1ymqsTTsfMkHutNGV39lxr7fRVn85akTw7VHGJQIeWfk30VR1W9tsHp2
         15V/ekI0DLgm2L07y4IbQi0KiQ3NNBURlwUovJ8prj48LtnwJHSUvINb3cQktog4xzeq
         tKBajXfr7mrXrLI+cuZTacOfk1dufFFiiqzH9m4wf1CLMHxUn93C4+rtE3g3BX56TZR6
         cxZcwLw0P36bXS0yLaJBk493cweXuSudd8KZJMNNdVm/pPdMB5IhMRH1tnkBF1s0hWzc
         viD1Mp4huErlfs+QxZq9Lrq2XIIfINdMoO19HQRloYGek/74o5oPvKcqDv7v56XiY23w
         G/Xg==
X-Gm-Message-State: AOAM531FDhn/ZVqaK5AABPG7OFRWof06ZSzvMaYaBGSZZQ5vNmJ4/BI4
        wAI1wWGJkTudptEo95aMHeyco4qtXuGfLQ==
X-Google-Smtp-Source: ABdhPJy8KzXwbeQ2Z7Fm533YgLBAeDCIsXDcMF6eUW8TwtokjArP5irJekuzQETsVnVHbz3pAjpKhQ==
X-Received: by 2002:a17:907:d28:: with SMTP id gn40mr2461175ejc.33.1608272938017;
        Thu, 17 Dec 2020 22:28:58 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::ee2? ([2a0b:e7c0:0:107::ee2])
        by smtp.gmail.com with ESMTPSA id ch30sm25195262edb.8.2020.12.17.22.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 22:28:57 -0800 (PST)
Subject: Re: drivers/tty/vt/keyboard.c:2037:13: sparse: sparse: incorrect type
 in initializer (different address spaces)
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>
References: <202012162048.l1ovj8ga-lkp@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <877c5461-aa67-3d19-b353-ff902742a6ce@kernel.org>
Date:   Fri, 18 Dec 2020 07:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <202012162048.l1ovj8ga-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 16. 12. 20, 13:07, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d01e7f10dae29eba0f9ada82b65d24e035d5b2f9
> commit: 07edff9265204e15c9fc8d07cc69e38c4c484e15 vt: keyboard, reorder user buffer handling in vt_do_kdgkb_ioctl
> date:   6 weeks ago
> config: sh-randconfig-s032-20201216 (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # apt-get install sparse
>          # sparse version: v0.6.3-184-g1b896707-dirty
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=07edff9265204e15c9fc8d07cc69e38c4c484e15
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 07edff9265204e15c9fc8d07cc69e38c4c484e15
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
>     drivers/tty/vt/keyboard.c:1745:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
>     drivers/tty/vt/keyboard.c:1745:21: sparse:     expected unsigned int const *__gu_addr
>     drivers/tty/vt/keyboard.c:1745:21: sparse:     got unsigned int [noderef] __user *
>     drivers/tty/vt/keyboard.c:1745:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     

Guys,

any idea why __gu_addr in superH's __get_user_check is not marked as __user?

thanks,
-- 
js
suse labs

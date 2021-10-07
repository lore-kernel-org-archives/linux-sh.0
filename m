Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FD6C433EF
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 02:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4430D61215
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 02:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhJGC1J (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 6 Oct 2021 22:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJGC1I (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 6 Oct 2021 22:27:08 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66A6C061746;
        Wed,  6 Oct 2021 19:25:15 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j15so2923760plh.7;
        Wed, 06 Oct 2021 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wdvJk6D1ViEBYH6uB0AwglzPFWNo7cbOO7fkxMbJ9dA=;
        b=Sp/MggvYZ1fkKseKOIqheZEqgIYO9U7l3Fb+F7r4AF1HJvKza55doAM4VFHekfLjFx
         l0h9QKBGfCRkc0EqNboiOVTNmHzg/SEEuLqwArpOJayKxQme+kLkxEIGqZgvnMWmieNx
         fhuC+ZFrD2D0fjMPYFbqmZAg8gVdJN6nAW585b1RLttDiggeBCq69kYRXGKHA2qSZytw
         hSaCB+BvsDGvSowzyJ3w/Myei9Krute/Mf+n+VyS3y75NZoqIH2HR+hkZeD1eiqFJV9a
         +rouVDBNrFLQuldI1V/ceTpSLwESV/R60I9q1ajynvnJIpy9PEOAXakMQE5+aA6KEYjv
         CNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wdvJk6D1ViEBYH6uB0AwglzPFWNo7cbOO7fkxMbJ9dA=;
        b=TZ37vfO6R3gET+dkdYrf05rwjO8kMxaQzmf0S1NBy7jpGMksdjXHG/fA0Qr9T+aFfm
         /S9JTYVMU/yJJG3HlyNj81Nme/m6Sjt0Q1WjHrbFcE1o70VOeAPXHjhRkfOP2XI2O2ui
         oO431bmZti/GcRSS4gGT6Q07buJc+W/PtTsi76ix7xz4x9nfE/xW+usdyi3cIkz2kWxl
         mx/De84jAhB9gjkJweQYvbra6PE/mJuz3NdfCY3ZLPRv8EWEbMUOXg2O2WSILlU35lTM
         6p6i0yMtSU6bJmMnvyik9+TBPIkv63OPLagq9zDvIqsHztZpa+4e/KX3Cb9kaVkQiprN
         5GSg==
X-Gm-Message-State: AOAM5318p+uruklQ1o52FqVem66cO+lMNT0dbZQSqkCyO3w661J+n7cB
        yElePYAZs6Ip6denRNjaAUw=
X-Google-Smtp-Source: ABdhPJwHRb5SJb8sNMUH9CwZYyScBHBUSvA5u2yjHWxgkKCOzGkTQ5PtC45GQtM+mqCrbUx1dMutLQ==
X-Received: by 2002:a17:90a:8b8d:: with SMTP id z13mr2492694pjn.214.1633573515375;
        Wed, 06 Oct 2021 19:25:15 -0700 (PDT)
Received: from [10.230.29.137] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k14sm22015549pgg.92.2021.10.06.19.25.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 19:25:14 -0700 (PDT)
Message-ID: <ad0c1e14-62f9-0b9c-0b84-d31a213d53de@gmail.com>
Date:   Wed, 6 Oct 2021 19:24:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 03/12] ARM: broadcom: Use of_get_cpu_hwid()
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, openrisc@lists.librecores.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, devicetree@vger.kernel.org
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-4-robh@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20211006164332.1981454-4-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org



On 10/6/2021 9:43 AM, Rob Herring wrote:
> Replace open coded parsing of CPU nodes 'reg' property with
> of_get_cpu_hwid().
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

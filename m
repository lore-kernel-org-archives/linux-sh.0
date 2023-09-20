Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB2CE79D0
	for <linux-sh@archiver.kernel.org>; Wed, 20 Sep 2023 11:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbjITLxB (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 20 Sep 2023 07:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjITLxA (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 20 Sep 2023 07:53:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EDD92
        for <linux-sh@vger.kernel.org>; Wed, 20 Sep 2023 04:52:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A433C433CA;
        Wed, 20 Sep 2023 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695210775;
        bh=wqx3qGroxWeaWIZjkEb9g0eG6bCqe90t9kXAgyljG5Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IDfi7+YArUfZK4PTYqOxVZ9qbUWPQJD+j0kOLMYyfVV7ud+HJH1kjBQqv0Kpo3AEi
         jeTGX1g6QnbV05slpRJt/LHJtDtdZ1F52TPFwDyE6urxN5whCkFlh/8R5EIUP55gao
         qYrFGCnZM60qLv/aMvEZBu3wtHSr8nhIO/YsJks59zrYRbc2w9ilbFVIvMcb3CvOta
         UHtjA01QjyMUArD9k0n+VJHrDDAbKKSAGOL6UDe734AR2xl9w901YSOregVyrL3Y4L
         GUJtg3llL0jfyqmx+1M2PSV8zb2WyVxv8Q34wg3pQ70zA6dSx6DelSYpUYay3c3mE/
         Kplslz63iBJTA==
Message-ID: <8aab4112-4d2b-f145-b1c2-aa1f626f6914@kernel.org>
Date:   Wed, 20 Sep 2023 13:52:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v2 24/30] include/dt-bindings: Add SH7750 CPG header.
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, glaubitz@physik.fu-berlin.de
References: <cover.1694596125.git.ysato@users.sourceforge.jp>
 <7b5122f6252cf4ce563b2fab2ac61bd794876619.1694596125.git.ysato@users.sourceforge.jp>
 <84014955-92e0-bfd3-f4d3-0bfbf9f0dac5@kernel.org>
 <CAMuHMdUyGKO0q+RGJCcJj=uoOiEw91RBOLUtdCUWOds6tjsB3Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <CAMuHMdUyGKO0q+RGJCcJj=uoOiEw91RBOLUtdCUWOds6tjsB3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 19/09/2023 14:43, Geert Uytterhoeven wrote:
> Hi Krzysztof,
> 
> On Wed, Sep 13, 2023 at 12:49 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On 13/09/2023 11:23, Yoshinori Sato wrote:
>>> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
>>
>>>  include/dt-bindings/clock/sh7750.h | 13 +++++++++++++
>>
>> Missing vendor prefix.
> 
> None of the clock binding definitions for Renesas SoCs use a
> vendor prefix. The same is true for various other vendors.

So how about start using them for new bindings. :)

Best regards,
Krzysztof


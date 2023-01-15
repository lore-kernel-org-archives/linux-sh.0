Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05886C46467
	for <linux-sh@archiver.kernel.org>; Sun, 15 Jan 2023 00:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjAOANu (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 14 Jan 2023 19:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAOANs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 14 Jan 2023 19:13:48 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8159E9EEB;
        Sat, 14 Jan 2023 16:13:47 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pGqec-003SxP-Tn; Sun, 15 Jan 2023 01:13:42 +0100
Received: from dynamic-077-013-081-069.77.13.pool.telefonica.de ([77.13.81.69] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pGqec-0005pS-KW; Sun, 15 Jan 2023 01:13:42 +0100
Message-ID: <762307d9-1312-47cd-37e3-8d2fbcd7c6dc@physik.fu-berlin.de>
Date:   Sun, 15 Jan 2023 01:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4] sh: avoid using IRQ0 on SH3/4
To:     Rob Landley <rob@landley.net>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <961f3b42-1522-79d5-7012-1533b568696f@omp.ru>
 <09EB6264-E85C-487C-B706-6411BB18DDDF@physik.fu-berlin.de>
 <15573018-32df-b67f-fc37-44da0ed7afde@landley.net>
Content-Language: en-US
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <15573018-32df-b67f-fc37-44da0ed7afde@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 77.13.81.69
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/15/23 00:45, Rob Landley wrote:
>> I’m seriously considering adopting the architecture.
>>
>> Not sure whether Linus would grant that though.
> 
> I'll happily endorse you for maintainer if that would help.

Let me sleep over it for 1-2 days. I need to really make sure I understand the responsibility.

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


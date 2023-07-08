Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F97EB64DA
	for <linux-sh@archiver.kernel.org>; Sat,  8 Jul 2023 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjGHV6i (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Sat, 8 Jul 2023 17:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGHV6i (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Sat, 8 Jul 2023 17:58:38 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6247DE4A;
        Sat,  8 Jul 2023 14:58:36 -0700 (PDT)
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
X-GND-Sasl: contact@artur-rojek.eu
Received: by mail.gandi.net (Postfix) with ESMTPA id 97CD4240002;
        Sat,  8 Jul 2023 21:58:30 +0000 (UTC)
MIME-Version: 1.0
Date:   Sat, 08 Jul 2023 23:58:30 +0200
From:   Artur Rojek <contact@artur-rojek.eu>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] sh updates for v6.5
In-Reply-To: <62d9d61e7d085840161c06f08b7aebfd734663fa.camel@physik.fu-berlin.de>
References: <9a6b730fc6c8e70ff034e2e3665478ec31858c29.camel@physik.fu-berlin.de>
 <ZKba4SLzjjhHgOEs@infradead.org>
 <5c612d0b293082352df6640ac951918bfa458181.camel@physik.fu-berlin.de>
 <45f9efa9-9341-e7e4-fbe4-ec7689c714aa@omp.ru>
 <62d9d61e7d085840161c06f08b7aebfd734663fa.camel@physik.fu-berlin.de>
Message-ID: <efaf034aaea3a5f7459b3c9081dc0665@artur-rojek.eu>
X-Sender: contact@artur-rojek.eu
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 2023-07-08 23:49, John Paul Adrian Glaubitz wrote:
> Hi!
> 
> On Sun, 2023-07-09 at 00:25 +0300, Sergey Shtylyov wrote:
>> > However, since I am still new to kernel development, it will certainly take
>> > me a little more time until we're there. However, there is some interest
>> > in the community such as the J-Core people and Artur Rojek, so there are people
>> > who are willing to help me.
>> 
>>    Maybe we could start using the #linux-sh channel (again?) -- it's 
>> there, on
>> Libera.chat, with couple persons hanging around... :-)
> 
> Most SuperH/J-Core people meet in #jcore on libera these days.
> 
> Adrian
I am not sure if they welcome generic SuperH chat there, but I'm lurking
in both channels already.

Cheers,
Artur

Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46098C77B75
	for <linux-sh@archiver.kernel.org>; Tue, 18 Apr 2023 07:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjDRH2o (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 18 Apr 2023 03:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDRH2n (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 18 Apr 2023 03:28:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613BE3C0D
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:28:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d2e1a72fcca58-63b70f0b320so1590407b3a.1
        for <linux-sh@vger.kernel.org>; Tue, 18 Apr 2023 00:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20221208.gappssmtp.com; s=20221208; t=1681802922; x=1684394922;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fNBzLutKyffvOunSk9ntqq+fP7CaSqPwDdmYbAR5VM=;
        b=R+A3GC0Jb+S7Z1AmRcYWBVbIlHYrj/2eaNRSf6zCkWOyZkRAVPAguo9JOWr3LDnWw9
         LVKsFYmRQXuZIZlwEI+wznUsK90H91m9zIsnyckiCMWU1BFHi7HBefvZsI8YNaeozLHI
         F5c4O5Vvedr0sNi2Rcqp0Sk7WLc94JR+sDFkiJdkKIzKCj/5IPdog6PnStelILrc0Aqi
         1RpCp6V871kHV/0kRo33xdYfw9Ai/VfeRXXcoEMhSARMrMvvwwc0fBEUpMCkRog7xp3Y
         S3kphJzrzQBTtvJ7qVdGlgjQsG/Xpfhccw/ZZIlzDsMYC+oBiLTJQZFMreqrgah+iHP0
         uHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681802922; x=1684394922;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2fNBzLutKyffvOunSk9ntqq+fP7CaSqPwDdmYbAR5VM=;
        b=dv3DxZTTscScstu8ErSe8xOvYRCObcPdHRwfIgBh9BKr4rtORQvuI0JbPUwYG7Q9CA
         iTIDHF/Ucmh4NmlZwthNJIfCJjWks+/Dv0W/T8K2wZIyISRS0DxjJupJLvO5DSzAhY2V
         oMzvmQWYqxJUwZH8ZOnQMRLOaVDo176BjsVd/40kFOEH1Guel84u4BQ9II5BS/Hbc1Kq
         xyZ7/I+yURTsKHnFh/phMFVzB4QegtBEIpPnmMS830EkwLyR5whYIvIW7RGjpt/VuLpH
         vtfxOO306DBBYaj3OimLpm36zKYnREWRNSPLkvMrKTyMWtJBCHVW+GJixO4rweZtkxdP
         fpuw==
X-Gm-Message-State: AAQBX9eomL1gYQEg1JLx0wKrC6H3YSVHVlNj3QXlwwKniJRXTiOn0qu9
        NaaLs2jlbuAL9yR5kD4MaEqFTUPSXwlPb0PRqFxvTeJC
X-Google-Smtp-Source: AKy350a9pr2A/07gg1EwKuPCyBm0Ba+vepR1NYCRL7Lr2+L8KsqHnQ7tGXmKIUFSgpM+ayN18OjBRA==
X-Received: by 2002:a17:902:f351:b0:1a6:3def:6007 with SMTP id q17-20020a170902f35100b001a63def6007mr1183317ple.7.1681802921852;
        Tue, 18 Apr 2023 00:28:41 -0700 (PDT)
Received: from [192.168.33.147] (124-110-25-102.east.xps.vectant.ne.jp. [124.110.25.102])
        by smtp.gmail.com with ESMTPSA id p3-20020a170902b08300b001a2806ae2f7sm8914745plr.83.2023.04.18.00.28.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:28:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------1CAitbmmkjaEDU7fWezLLapi"
Message-ID: <61ba31cf-f60b-9026-2123-0fc3debf204a@landley.net>
Date:   Tue, 18 Apr 2023 02:43:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] Fix J-core aic warning spam
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>
References: <ec905cf9-09de-a5d1-b8ee-0d874db4c301@landley.net>
 <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
From:   Rob Landley <rob@landley.net>
In-Reply-To: <45c6426d762dbbe27830182ce751aa3d8210602a.camel@physik.fu-berlin.de>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------1CAitbmmkjaEDU7fWezLLapi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/23 01:13, John Paul Adrian Glaubitz wrote:
> Hi Rob!
> 
> On Mon, 2023-04-17 at 23:23 -0500, Rob Landley wrote:
>> From: Rich Felker <dalias@libc.org>
>> Signed-off-by: Rob Landley <rob@landley.net>
>> 
>> Silence noisy boot messages (warning and stack dump for each IRQ) when booting
>> on J2 SOC.
>>
>> ---
>>  drivers/irqchip/irq-jcore-aic.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>> 
>> diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
>> index 5f47d8ee4ae3..730252cb7b08 100644
>> --- a/drivers/irqchip/irq-jcore-aic.c
>> +++ b/drivers/irqchip/irq-jcore-aic.c
>> @@ -68,6 +68,7 @@ static int __init aic_irq_of_init(struct device_node *node,
>>  	unsigned min_irq = JCORE_AIC2_MIN_HWIRQ;
>>  	unsigned dom_sz = JCORE_AIC_MAX_HWIRQ+1;
>>  	struct irq_domain *domain;
>> +	int rc;
>> 
>>  	pr_info("Initializing J-Core AIC\n");
>> 
>> @@ -100,6 +101,11 @@ static int __init aic_irq_of_init(struct device_node *node,
>>  	jcore_aic.irq_unmask = noop;
>>  	jcore_aic.name = "AIC";
>> 
>> +	rc = irq_alloc_descs(min_irq, min_irq, dom_sz - min_irq,
>> +			     of_node_to_nid(node));
>> +	if (rc < 0)
>> +		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
>> +			min_irq);
>>  	domain = irq_domain_add_legacy(node, dom_sz - min_irq, min_irq, min_irq,
>>  				       &jcore_aic_irqdomain_ops,
>>  				       &jcore_aic);
> 
> This more looks like it's adding a missing call to irc_alloc_descs() rather than
> silencing kernel messages. The latter would be a brushing over of an error while
> the former would fix the actual problem, wouldn't it?
> 
> So, I think the patch title might be misleading.

Rich never bothered to explain what he was doing:

http://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=beb1f3ae8ad60f851c5920c89ad0386fbf8c3473

At a quick glance it looks like the right fix to me (thus not a hack).

The lack of explanation is more pronounced in some of his other patches:

http://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=9b22e72e623edfb57046cf61edfa0762f0e8bc13

What actual problem is that trying to address? No idea. I don't seem to have hit
it, whatever it is, so didn't try to submit that anywhere.

These three:

http://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=4c7333b0fb9e
http://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=53ac9fc75ae0
http://git.musl-libc.org/cgit/linux-sh/commit/?h=v5.16%2bj2&id=262e1e5884da

Can _probably_ go upstream as is, but after my last round of such I still
haven't replied to Andrew Morton's

  https://lkml.iu.edu/hypermail/linux/kernel/2302.2/08040.html

Because

  https://landley.net/notes.html#22-02-2023
  https://landley.net/notes.html#24-02-2023

I've got another one since [attached] but the last time I pushed a one line
"removal of leftover debris in a header" obvious cleanup patch was
https://lkml.iu.edu/hypermail/linux/kernel/1603.2/00054.html and multiplying the
amount of explanation I had to do _then_ with 7 more years of continuing kernel
community ossification ala
https://web.archive.org/web/20200629223507/https://www.zdnet.com/article/linus-torvalds-looks-at-the-future-of-linux-kernel-developers-and-development/#:~:text=ages
and I expect getting that in to require an hour-long video presentation with
diagrams, and I am SO tired.

> Adrian

Rob
--------------1CAitbmmkjaEDU7fWezLLapi
Content-Type: text/x-patch; charset=UTF-8; name="0006-ncp-cleanup.patch"
Content-Disposition: attachment; filename="0006-ncp-cleanup.patch"
Content-Transfer-Encoding: base64

RnJvbTogUm9iIExhbmRsZXkgPHJvYkBsYW5kbGV5Lm5ldD4KU3ViamVjdDogW1BBVENIXSBS
ZW1vdmUgc3RhbGUgTkNQIGVudHJ5IChsZWZ0b3ZlciBmcm9tIGJkMzI4OTVjNzUwYikKRGF0
ZTogVHVlLCAxNyBBcHIgMjAyMyAwNzoyOTowOSBfKzA5MDAKCkNvbW1pdCAxYmI4MTU1MDgw
YzYgbW92ZWQgbmNwZnMgKE5vdmVsbCBuZXR3YXJlKSBpbnRvIGRyaXZlcnMvc3RhZ2luZwph
bmQgY29tbWl0IGJkMzI4OTVjNzUwYiBkZWxldGVkIGl0LiBCdXQgdGhleSBsZWZ0IGl0IGlu
IHRoZSBoZWFkZXIuLi4KCi0tLQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L21h
Z2ljLmggYi9pbmNsdWRlL3VhcGkvbGludXgvbWFnaWMuaAppbmRleCA2MzI1ZDFkMGU5MGYu
LjkxZDUyYTdlOTc3MCAxMDA2NDQKLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L21hZ2ljLmgK
KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L21hZ2ljLmgKQEAgLTQ2LDcgKzQ2LDYgQEAKIAog
I2RlZmluZSBNU0RPU19TVVBFUl9NQUdJQwkweDRkNDQJCS8qIE1EICovCiAjZGVmaW5lIEVY
RkFUX1NVUEVSX01BR0lDCTB4MjAxMUJBQjAKLSNkZWZpbmUgTkNQX1NVUEVSX01BR0lDCQkw
eDU2NGMJCS8qIEd1ZXNzLCB3aGF0IDB4NTY0YyBpcyA6LSkgKi8KICNkZWZpbmUgTkZTX1NV
UEVSX01BR0lDCQkweDY5NjkKICNkZWZpbmUgT0NGUzJfU1VQRVJfTUFHSUMJMHg3NDYxNjM2
ZgogI2RlZmluZSBPUEVOUFJPTV9TVVBFUl9NQUdJQwkweDlmYTEK

--------------1CAitbmmkjaEDU7fWezLLapi--

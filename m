Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62056C88CB6
	for <linux-sh@archiver.kernel.org>; Mon, 12 Jun 2023 16:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjFLQFM (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 12 Jun 2023 12:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFLQFL (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 12 Jun 2023 12:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297FBCF
        for <linux-sh@vger.kernel.org>; Mon, 12 Jun 2023 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686585866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uuCdplsPmJlzp+kH6QUrWWOm1LK9xg7d6ONJhnkdacI=;
        b=SRuj9uobVSzwZXP/Efxh7eb8p3Nh/gQ0oQImpt6eS/Npp6XMUAe3arqeMBL3Rbxdtp7vlq
        eU3lNcNIt1TVC5nBzxfTCHy1veC7sOwJnywUxAptOaoJ/D/jlUuWSmy2PdPIqRUr6+78bS
        2r0MjvmjQ4WG/6Qa9viNJRumZbvrnUc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-TC6KJfQRM6yJaV2lxqOzHg-1; Mon, 12 Jun 2023 12:04:21 -0400
X-MC-Unique: TC6KJfQRM6yJaV2lxqOzHg-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e55b42af1so2621811f8f.3
        for <linux-sh@vger.kernel.org>; Mon, 12 Jun 2023 09:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686585859; x=1689177859;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uuCdplsPmJlzp+kH6QUrWWOm1LK9xg7d6ONJhnkdacI=;
        b=Dek8nTROqBMKz7Z/TYt9G4msdZH9FjZ6f7e6ILZDAc+xfe3pDcLi2LkG0Cd/N32HDg
         pK52tANvMAWn4j5n+XBaj/al39ZwJbRbCRqOwHpEctSsTS50m8TPozrNqn/U8pJPcZ2N
         5FxiJj6ngo2vctlR5GEvrtfqdBqoRB7dYCeuhG/Ne/5bIcWPteS1hlU8sN69yPrrmudA
         ZR86o4g6MyHXInB8p9+qD1ad5H0kYIWlVp55nJ+pEFwdnvFMJCdKXrQYnIznmr5ESjm/
         64gcxevWeM+xRNYU0AQiRO82/eVK2GVZITG2Jc70B1NIi4vKVA2tkGdu8K23cm6H1AtL
         rK/A==
X-Gm-Message-State: AC+VfDwgbugPV2ombTCB8wcfRUaG85HmMcEJLto9U16Nk+Hm8/r5HzgD
        nwa1R5rIIvuWlg4IrhXmRTFUGByo+v0LFj9thxtuiTXu9FnC4vThC2zh1GEeLazuuvn2+qfy4E6
        y3ndeVJE/30s+IDer064=
X-Received: by 2002:adf:e984:0:b0:30a:bf2b:e020 with SMTP id h4-20020adfe984000000b0030abf2be020mr5819469wrm.45.1686585859687;
        Mon, 12 Jun 2023 09:04:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4owFNKmEWmuPb++u0T0aPDLLPsp/xgXSi0mOTbIfVKTyTKs1oJaK7lKDIf+8APpdspTz1ouQ==
X-Received: by 2002:adf:e984:0:b0:30a:bf2b:e020 with SMTP id h4-20020adfe984000000b0030abf2be020mr5819445wrm.45.1686585859272;
        Mon, 12 Jun 2023 09:04:19 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d5281000000b0030aded83385sm12896655wrv.27.2023.06.12.09.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:04:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/38] fbdev: Make userspace interfaces optional
In-Reply-To: <20230612155601.GC1243864@ravnborg.org>
References: <20230612141352.29939-1-tzimmermann@suse.de>
 <20230612155601.GC1243864@ravnborg.org>
Date:   Mon, 12 Jun 2023 18:04:17 +0200
Message-ID: <87jzw83bwe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

Hello Sam,

> Hi Thomas,
>
> Nice series, quite some preparations.
>
> On Mon, Jun 12, 2023 at 04:07:38PM +0200, Thomas Zimmermann wrote:

[...]

>>   fbdev/smscufx: Detect registered fb_info from refcount
> I did not try to understand the code, so others must review.
>

No worries, I already reviewed that one.

>>   fbdev/ep93xx-fb: Alloc DMA memory from hardware device
>>   fbdev/sh7760fb: Alloc DMA memory from hardware device
> This smells like bug-fixes, and I do not see what impact the change has.
> So again, someone else needs to provide review here.
>

And same for these.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


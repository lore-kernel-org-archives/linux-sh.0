Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0FC77B7A
	for <linux-sh@archiver.kernel.org>; Wed,  7 Jun 2023 09:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbjFGJOi (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjFGJOT (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 7 Jun 2023 05:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ED71BFD
        for <linux-sh@vger.kernel.org>; Wed,  7 Jun 2023 02:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3BIYD3PXMtQvTPGQV01/1k0Hmx/7PJYivm+5X8kP8U=;
        b=O+IETPrpEKa5dZUBQt2NtWpk9csmzf3XlIbfvYXhRQyGDov4ThNqiSRuLbAQFf0DO92KaE
        Wvmnuxky8x4QhIc1CqB9mYrxaRADznaMPy/OMvpyhO6GTGyxl4waEC6HpZILJfIGVzs0z2
        DJKr+KE6MwDS9vbpvjJ3or6EsnSdvPw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-4hgs-ZhYPs2ttH55R88_kA-1; Wed, 07 Jun 2023 05:12:20 -0400
X-MC-Unique: 4hgs-ZhYPs2ttH55R88_kA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30ade645c59so3222947f8f.2
        for <linux-sh@vger.kernel.org>; Wed, 07 Jun 2023 02:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129139; x=1688721139;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3BIYD3PXMtQvTPGQV01/1k0Hmx/7PJYivm+5X8kP8U=;
        b=iC/pcSouE6zTwdkGQbf8tV1EzN+18LojPEy/MHxOWb94UX+P7hh9XNHJVKLb4FlxPZ
         wV4JyLuKGxJ7EBzP1vTFb+vm0kmvdhkWLPPX0UqbAHutfIB+OU9cqAxmB6Uc6jhfgvoQ
         7iDoqeszXJgGlY5QT4gASMsaQDZ1Bn4rTNfze67mu/DziS0FBbMM4LH9ey1TPMI2Pgse
         SGouWHPxZeyh1SBKAARj7KgulwCq2nw0liYzG/AquHNdJLxin0p4Xl69dNowK7RUE/0t
         jLpKAPGic10lfnQElOW9hUwz4AsY0YGMeHGQqyWZ6mNKAr/TA3IFS39C1GK+dZhwyGxf
         JgrQ==
X-Gm-Message-State: AC+VfDzGt2Nr5A2N3rg+mJtTfUykVFRZBT+KC+1CWqmqkVXoRRhD1ZI0
        B9FC5ZsOZePjFDiHqNdW9L3hYD/eH/xqaq7Fd3/jTaIVer0jCpodWQLKHCz9gA22QQat8j1j5JL
        KBT3cxY7w/ZWMM5aMh/o=
X-Received: by 2002:a5d:55c6:0:b0:30e:38d3:cc4f with SMTP id i6-20020a5d55c6000000b0030e38d3cc4fmr3742550wrw.36.1686129139399;
        Wed, 07 Jun 2023 02:12:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wzUZfsA9VSizf9bxaqukgTVAwDp5W+57tfKmlffItPyQVvcHhSQ5E8wYACr5/gCv7xQF2rA==
X-Received: by 2002:a5d:55c6:0:b0:30e:38d3:cc4f with SMTP id i6-20020a5d55c6000000b0030e38d3cc4fmr3742525wrw.36.1686129139085;
        Wed, 07 Jun 2023 02:12:19 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f60101074dsm1447712wmc.33.2023.06.07.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:12:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 21/30] fbdev/sm501fb: Output message with fb_err()
In-Reply-To: <20230605144812.15241-22-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-22-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:12:18 +0200
Message-ID: <87o7lreivh.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix case were dev_err() is being called with struct fb_info.dev.
> Use fb_err() instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


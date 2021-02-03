Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203C7C433DB
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 23:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D8164E50
	for <linux-sh@archiver.kernel.org>; Wed,  3 Feb 2021 23:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbhBCXzK (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Wed, 3 Feb 2021 18:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233915AbhBCXzF (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Wed, 3 Feb 2021 18:55:05 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390BC061573;
        Wed,  3 Feb 2021 15:54:25 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z32so1149919qtd.8;
        Wed, 03 Feb 2021 15:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUI1E35qY/dHj3kcH37Zi8kcJp7vpT/9jcqiIwQAQvE=;
        b=TxEh/JreknrjRSNDom2j5/kMNVU7wh21VYavcbJvG0BD/dn7T/528rdhp15EIkOETH
         4QaBU7AfwVIW+eQmj+nOjqt7x8oolTX9mOyLbaI8bKU2lvo5+G+XRqscQ52/RirtpwUi
         +prCYIWAZH4wQPEgxPqPqv9zJbQslJ15LbZ0Gott3tcWmr38VctPv9w+U7hlC/SM3BPQ
         yir0lDZYd1Pmx/c59UQxvJAmVJ9GiqY3LpNLib3i2QOx3fii0WJ6HK7EnNXRAVRIH8xA
         odq8UPI8BXOXfyLMsaEECd1K5b+egPSXNPkGE5fSfwG2g9YtiG2VxtWUP2FWfd7uePF0
         rd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OUI1E35qY/dHj3kcH37Zi8kcJp7vpT/9jcqiIwQAQvE=;
        b=G7Xo08TcwS/z5zqN8n8nAOZztdSpDvSx94A5O3aKzpnEdIj3ZFDZlCRm5bL3GPrRkk
         BONKYd5GKh8R9OhX1tTD00cYg8hN9loer9Rslyjcb3rqB75xKgVT0LrYsrgrESdf1fy0
         8IjBfgAU/CdUSVklRTWia5QzXGTaLPTD3hbFLDcAVJeL5NgoTTws9GneLsJTHwKpozso
         IOAxX0AdBeGruRVO7NvSPeMLAvlM0fD8/WrpoT2jNZfIZT2aD1J7MMKeBdPfrB9rrvae
         yK7vDObuehwxoKDQiQE5nyFRmWL/8PNGmYITaLgNSzPEIaXiiDVnx1sghku3fN+b0DIm
         2MHw==
X-Gm-Message-State: AOAM530RdL1tHis2NgbL6KrgcVhBmVoe7fw1rXla1QUFbTP7Ic6IN4hn
        bXVk8SFApfHA9He2p49K2Zc=
X-Google-Smtp-Source: ABdhPJwmC6TaVPyOk1l55Ge1hcsD88Zrat52GUmn3fp+Ua/83f8TjE4XRr4p5uLzR5CO6D5y3dBlbg==
X-Received: by 2002:aed:212d:: with SMTP id 42mr4825134qtc.106.1612396464784;
        Wed, 03 Feb 2021 15:54:24 -0800 (PST)
Received: from Gentoo ([138.199.13.179])
        by smtp.gmail.com with ESMTPSA id o5sm3375672qko.85.2021.02.03.15.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 15:54:23 -0800 (PST)
Date:   Thu, 4 Feb 2021 05:24:14 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch: sh: kernel: Change to correct spelling archtecture
 to architecture in the file relocate_kernel.S
Message-ID: <YBs3pgKHxqMqH8sf@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210203152521.16776-1-unixbhaskar@gmail.com>
 <31ad117d-b025-2214-cccb-deeaee6036be@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sUL2F4YP//m70vi0"
Content-Disposition: inline
In-Reply-To: <31ad117d-b025-2214-cccb-deeaee6036be@infradead.org>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org


--sUL2F4YP//m70vi0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 09:58 Wed 03 Feb 2021, Randy Dunlap wrote:
>On 2/3/21 7:25 AM, Bhaskar Chowdhury wrote:
>
>Normally a patch description is required <here>.
>
>If the patch committer wants to take it as is, the typo
>fix LGTM.
>

I am so sorry..will fix this ...thank you Randy

>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  arch/sh/kernel/relocate_kernel.S | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/sh/kernel/relocate_kernel.S b/arch/sh/kernel/relocate_kernel.S
>> index d9bf2b727b42..deda2f60a8f2 100644
>> --- a/arch/sh/kernel/relocate_kernel.S
>> +++ b/arch/sh/kernel/relocate_kernel.S
>> @@ -3,7 +3,7 @@
>>   * relocate_kernel.S - put the kernel image in place to boot
>>   * 2005.9.17 kogiidena@eggplant.ddo.jp
>>   *
>> - * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
>> + * LANDISK/sh4 is supported. Maybe, SH architecture works well.
>>   *
>>   * 2009-03-18 Magnus Damm - Added Kexec Jump support
>>   */
>> --
>> 2.26.2
>
>--
>~Randy
>

--sUL2F4YP//m70vi0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAbN6UACgkQsjqdtxFL
KRWqxQgAlvfgVshKcHUWP1D4isG7NUbTKOpSPEOt6ZoKhPmVijuq/3Vqi37cbYVK
qqsFJkF7GcsTLFrok86JZeYsiGv8TWAPaU1HG8OUhb5o9IIxFxH1S+nwJj8VY1kO
QznLrzi9tRlX4KEYelwgGji9OeI3XCSF0BxShhrmbsB6kd99tP7bqmhVBa6ZfRK+
VbYg/SiAU3jMDKt4VOQxvOLdKXYP1kQNhy2SVBkIFmAOUH/1TrxEDZMlD80RfwJF
tm2MBC4Aj7RMHZAiUyKl937snhMakB2aGMeNZLPq8MYtetgpsnV3M+RQ0GN/Iff6
mWP2U2hWqJPz6YeDPcE4iRh/NvP2cw==
=ZeJX
-----END PGP SIGNATURE-----

--sUL2F4YP//m70vi0--

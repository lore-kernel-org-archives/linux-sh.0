Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338B9C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 13:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjKNNDs (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 08:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjKNNDs (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 08:03:48 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3750B1A5
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 05:03:45 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A4EBB5C0120;
        Tue, 14 Nov 2023 08:03:44 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 14 Nov 2023 08:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699967024; x=1700053424; bh=XY
        ofTtJcIEtLaW9z4GwUAD0Dmlpab98WSTsaNJokd4U=; b=aK54R5ddv8STsHZIwc
        HcnQk6b1OA69u+w+GAZc9pldje8RgAdmK2pEerDRu2IIyefuJj1hx6z87SB2My9+
        Fu8k05CgPRM6ANl+88QaoNViE8ebPflC2TVTrPSz/aQLAesl5br7ZqACQ5jJdtaQ
        9EKZ/qw6NOM7BZcWVG/4MjGPznihOlA8G6Y7Pth0hwFLPkuLcohyBRG9NVvNdc8p
        iJ5d0rN4IBbSlkiYKx7YfxE8zKjqxttwuPI/KYSS/ZCTxAr/bbkTCytcOG1VOy4Q
        km6lJuPuVCJVxOaQSOAvMN3i3AVbOkzBXE55L0P8OvZ4ghRAAsC3c//280dhrEGj
        XHGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1699967024; x=1700053424; bh=XYofTtJcIEtLa
        W9z4GwUAD0Dmlpab98WSTsaNJokd4U=; b=XPc+f8fz/K3qA0y1WmLEI2i9zNE0w
        T5y/71eqJBY304d7YWd3UFds1FLag9n9sfIecAcU3whj2o9udd+vvF1VquF4otru
        l8siU5R5ftG/5B2lQC51bE9sm81RO4+frnz5FQZRroqv82+unA7PvLgxQL6dCsRW
        2sHZtauR24zzaS4eAA8AUeklNNEJxTCEt44/S+lX3GBCyifmFqBKkIKQZ9fCU7gb
        91DG7KHfmwm9k/r5uryYFjnqrkr/Tr/pNFjRaB+W4NJ1NxTTjvnfg33gUGTmnBPk
        5N38bFvl/fLa7mVeH3i6Jt+sLSLsZIht/s3KMpP4Z3DDApQMmk7nY5/ag==
X-ME-Sender: <xms:L3BTZZGf8fgUyLxnEtP-RN3HjG61jtAw6YcKx9fRu72uxIr2Rb8fhw>
    <xme:L3BTZeVS3zNGVSH8OfzZnXQmc0oHwaAxYikTiMBIBZEHAXQeoHWEs0UogW45EMTf9
    4ikJLcVyLCUi8p6FVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:L3BTZbJhDLOprGCChgYKnu8_nNIt7y_-LJmaMXi1CjCr0GJs4wueKw>
    <xmx:L3BTZfHwBg2sh1SRs_Bk29XAIEbNvS6NkRLU9_MzDc0M2_VlbWxxZA>
    <xmx:L3BTZfXg3CDmp_6bYQe5RG6OT8di2ZK51FF3ekhop6Mxzjl97vZbVQ>
    <xmx:MHBTZVzCsXuRRbRgjzC9sw7NganyFkQNtP-qVtWM1qIXsncyLXsIsw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 916B7B60089; Tue, 14 Nov 2023 08:03:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <9a972cac-2eef-44cb-a100-387b3d7a5816@app.fastmail.com>
In-Reply-To: <65b5ddcbecfa05088b3889d0815588012dc816da.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <65b5ddcbecfa05088b3889d0815588012dc816da.1699856600.git.ysato@users.sourceforge.jp>
Date:   Tue, 14 Nov 2023 08:03:22 -0500
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Baoquan He" <bhe@redhat.com>, "Guenter Roeck" <linux@roeck-us.net>
Subject: Re: [PATCH v4 10/37] sh: Common PCI framework support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Nov 14, 2023, at 03:00, Yoshinori Sato wrote:
> When CONFIG_OF=y, a common PCI framework is used.
> The new driver also needs to reference PCI headers, so move the
> necessary header files to a public location rather than a private one.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/include/asm/io.h                      | 40 +++++++++++++------
>  .../sh/{drivers/pci => include/asm}/pci-sh4.h |  7 ++--
>  .../{drivers/pci => include/asm}/pci-sh7751.h |  0
>  .../{drivers/pci => include/asm}/pci-sh7780.h |  0
>  arch/sh/include/asm/pci.h                     |  4 ++

I think ideally the PCI host driver should be moved to
drivers/pci/controller, but I'm not sure if that solves
your problem here. There should normally be no need to
put driver specific headers into a global location.
 
>  #define IO_SPACE_LIMIT 0xffffffff

The IO_SPACE_LIMIT is wrong here, as most of the address space
is not actually reserved for port I/O. Usually you want just
64KB here, but you can also make this PIO_MASK I think.

> +#ifdef __KERNEL__
> +#define PCI_IOBASE	((void __iomem *)0xfe240000UL)
> +
> +#define HAVE_ARCH_PIO_SIZE
> +#define PIO_OFFSET	0xfe240000UL
> +#define PIO_MASK	0x3ffffUL
> +#define PIO_RESERVED	0x40000UL
> +#endif /* __KERNEL__ */

As far as I understand the generic iomap code, this does
not work because PIO_OFFSET has to be smaller than
PIO_RESERVED. Once you remove the GENERIC_IOMAP hack, it
should no longer matter.

      Arnd

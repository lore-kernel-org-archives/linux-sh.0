Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B3C4332F
	for <linux-sh@archiver.kernel.org>; Tue, 14 Nov 2023 12:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjKNMrY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Tue, 14 Nov 2023 07:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKNMrX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Tue, 14 Nov 2023 07:47:23 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3D7192
        for <linux-sh@vger.kernel.org>; Tue, 14 Nov 2023 04:47:20 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id E9F825C017C;
        Tue, 14 Nov 2023 07:47:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 14 Nov 2023 07:47:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1699966036; x=1700052436; bh=6w
        tcOsWzQ7i4ccAHpUfiGQ23X+R4YM5jWXIXijIB6E4=; b=yIYfOYFX8TbP3ffF3e
        /1oFKqCMM3Tvz2Wgv8H+IcZr3+WpOEjPNwOYw823gtLt56bFS2mjnwiqxiF5FV9Q
        imRJ/HJhOx0o3CXl6GaTV2aDIbDR/woKFBqH03KkgeFubdeam013lQ48GH7/vwCg
        uQggMW5nJUCcQ9e+dDGT3P8UaVIprJ54DDp5e+2dgRNKSAhTX3SsWF/fzlf/Mx1d
        aIgABAollTIJCzQs7kdnB8CuQNDxmZnYAzQB5BfpuG9a7LDWDAzhnXcO6kYcynaq
        Nb6hizACj0+G41z1IEJ1foj2wQ3511xCQC4P+sY4pJrtra+kPOPO2H6u8FZa8+Wg
        CV6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1699966036; x=1700052436; bh=6wtcOsWzQ7i4c
        cAHpUfiGQ23X+R4YM5jWXIXijIB6E4=; b=Sm1rGa5DnQTG7xmZ4uBvNXYVVR36x
        BtwB/GqCPB2QbtNRDaQtzsbpHiQo/x04lky69/wJH41RbKufj4rHxHpZ0Uo1Zo/1
        D78KWlP1LRL6OJiefryQiaK/4sI+VgJaAwWyWAwuUNmHFprsz7DpVMuMw/AkWFwP
        IJm2qKvf20x5koCdIHSqF8TYHoX7cWNyngbpMCnGOzLiW9WQGeTXOOxvKxex7szK
        DBX3N9vTDZJUsi/W5ItkP2Idadl6la5ijdxD4Z+T0A85vfC1Gx1valkAmFIAYXKx
        iX8TFffKcdCrgwWIQBBpCQIQFG56CGoO7ZM4gG+Fxuex3gtAEh1cRRjqA==
X-ME-Sender: <xms:VGxTZQVdCiVlGCJN2rld7YI1MtweXPm88CPgPkqjjiS8ACVJ4q440A>
    <xme:VGxTZUk1jnMZxLJH2kv9HwET8SjLTQ-gd654omW2pkawpbsj6OspxKg4cZ7YVMRVB
    -bPNrNTcumyu6pSuGU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:VGxTZUaeGFx-ILRCQnfrd1XV5AVeRPfD13KskV2SCK5IddThcd2now>
    <xmx:VGxTZfWzGTbvi-cfyC-llIASaHi1EH8b4_acqiBh2IOQKEjsIBrYTQ>
    <xmx:VGxTZamBv7jfndGRAmqsNAAJuzjUSG0cSe5gzUuTPGEvFOIi393p9w>
    <xmx:VGxTZcgO4D9zGgiOoNvbmMLMBTqT8C9str9nPRmIFMKsPbnNdBrF7g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 44046B60089; Tue, 14 Nov 2023 07:47:16 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <daaa8b9e-9af5-410f-bce9-95f275c3e56a@app.fastmail.com>
In-Reply-To: <2e3530590d72257ac5cb657e4f4d4da3ec7d03e7.1699856600.git.ysato@users.sourceforge.jp>
References: <cover.1699856600.git.ysato@users.sourceforge.jp>
 <2e3530590d72257ac5cb657e4f4d4da3ec7d03e7.1699856600.git.ysato@users.sourceforge.jp>
Date:   Tue, 14 Nov 2023 07:46:54 -0500
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Cc:     "Rich Felker" <dalias@libc.org>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Randy Dunlap" <rdunlap@infradead.org>
Subject: Re: [PATCH v4 02/37] sh: Kconfig unified OF supported targets.
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Nov 14, 2023, at 02:59, Yoshinori Sato wrote:
> -	help
> -	  Select this option to include drivers core components of the
> -	  J-Core SoC, including interrupt controllers and timers.
> +	select GENERIC_IOMAP
> +	select GENERIC_IRQ_CHIP
> +	select SYS_SUPPORTS_PCI
> +	select GENERIC_PCI_IOMAP if PCI

I have not looked again, but as far as I remember, you should
be able to remove the 'select GENERIC_IOMAP' now that my patches
got merged, and just get the simpler and more efficient default
from asm-generic/ioremap.h.

You'll still need GENERIC_PCI_IOMAP, but that has no downsides.

     Arnd

Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE2CC433F5
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E621A61152
	for <linux-sh@archiver.kernel.org>; Thu,  7 Oct 2021 07:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhJGHzB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-sh@archiver.kernel.org>);
        Thu, 7 Oct 2021 03:55:01 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:49647 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232533AbhJGHzB (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Thu, 7 Oct 2021 03:55:01 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-38-fz1CuUWYNx6QMVBcOLTHFg-1; Thu, 07 Oct 2021 08:53:02 +0100
X-MC-Unique: fz1CuUWYNx6QMVBcOLTHFg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Thu, 7 Oct 2021 08:53:01 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Thu, 7 Oct 2021 08:53:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Stafford Horne <shorne@gmail.com>
CC:     Rich Felker <dalias@libc.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>, Guo Ren <guoren@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "Will Deacon" <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        James Morse <james.morse@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>, Ray Jui <rjui@broadcom.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        Borislav Petkov <bp@alien8.de>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <sbranden@broadcom.com>,
        Yoshinori Sato <ysato@users.osdn.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul Mackerras" <paulus@samba.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
Thread-Topic: [PATCH 06/12] openrisc: Use of_get_cpu_hwid()
Thread-Index: AQHXuvrQ2rKkD2ly1kazB6yB6/HdHavHKFTA
Date:   Thu, 7 Oct 2021 07:53:01 +0000
Message-ID: <c81b9c01650e487785b02f6562791556@AcuMS.aculab.com>
References: <20211006164332.1981454-1-robh@kernel.org>
 <20211006164332.1981454-7-robh@kernel.org> <YV4KkAC2p9D4yCnH@antec>
 <20211006212728.GM10333@gate.crashing.org>
In-Reply-To: <20211006212728.GM10333@gate.crashing.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

From: Segher Boessenkool
> Sent: 06 October 2021 22:27
> 
> On Thu, Oct 07, 2021 at 05:44:00AM +0900, Stafford Horne wrote:
> > You have defined of_get_cpu_hwid to return u64, will this create compiler
> > warnings when since we are storing a u64 into a u32?
> >
> > It seems only if we make with W=3.
> 
> Yes.  This is done by -Wconversion, "Warn for implicit conversions that
> may alter a value."
> 
> > I thought we usually warned on this.

The microsoft compiler does - best to turn all those warnings off.

> This warning is not in -Wall or -Wextra either, it suffers too much from
> false positives.  It is very natural to just ignore the high bits of
> modulo types (which is what "unsigned" types *are*).  Or the bits that
> "fall off" on a conversion.  The C standard makes this required
> behaviour, it is useful, and it is the only convenient way of getting
> this!

I've also seen a compiler convert:
	struct->char_member = (char)(int_val & 0xff);
into:
	reg = int_val;
	reg &= 0xff; // for the & 0xff
	reg &= 0xff; // for the cast
	struct->char_member = low_8bits(reg);

You really don't want the extra noise.

I'll bet that (char)int_val is actually an arithmetic expression.
So its type will be 'int'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)


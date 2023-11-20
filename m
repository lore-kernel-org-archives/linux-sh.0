Return-Path: <linux-sh-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A57C197A0
	for <linux-sh@archiver.kernel.org>; Mon, 20 Nov 2023 18:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjKTSQI (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 20 Nov 2023 13:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjKTSQH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 20 Nov 2023 13:16:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D1BC
        for <linux-sh@vger.kernel.org>; Mon, 20 Nov 2023 10:16:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E554C433C8;
        Mon, 20 Nov 2023 18:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700504163;
        bh=JZkT7XSKth3smWxYN2XZaH+Wmhd2XRvAegz7wBiv1+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EhSvRWScvSo54wyp8cGwMjEqRU6cV1J/NDQL/nUoXtdktqsr4UX+/6cdZR/Qw/cJl
         7SPjo/Tfy9IlEvs0bWpNwQLfuT7/jDPNSX2KQRreuQnJv2GPSaZmRvHA3IPyneL8hb
         qJVpcCvQG+DchdIQKyeWXV02NSVzW+QOA6xF5ZDew5xdpcDSoQUA8MN6gT58L2GTlD
         N3LFqsjZWn73bVul38jPeU+2uXXufmeDbftp0LctfuvI+C1e94qT/f5XzGu+p5LYY0
         Rm7nAYLmbPllgqB4ginhGSmqv3xJJ9Ka4JRpmNLu+WEfwWC72g9lhr0FcSBzxj939g
         NXAjzDdvqp50Q==
Date:   Mon, 20 Nov 2023 12:16:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     linux-sh@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH v4 12/37] pci: pci-sh7751: Add SH7751 PCI driver
Message-ID: <20231120181600.GA205977@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c0f0810c778e4f515bb9d8582b501d77e2bf1a.1699856600.git.ysato@users.sourceforge.jp>
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Nov 14, 2023 at 05:00:03PM +0900, Yoshinori Sato wrote:
> Renesas SH7751 CPU Internal PCI Controller driver.

I sent comments on this that seem to have been mostly ignored:

  https://lore.kernel.org/r/20231016172742.GA1215127@bhelgaas

After this series, we have both:

  arch/sh/drivers/pci/pci-sh7751.c
  drivers/pci/controller/pci-sh7751.c

They don't *look* very similar, so maybe we need both.  But I don't
know what the difference is.

Also git am complains when applying this series (also mentioned in the
previous email above):

  Applying: sh: passing FDT address to kernel startup.
  .git/rebase-apply/patch:25: trailing whitespace.

  warning: 1 line adds whitespace errors.
  Applying: irqchip: SH7751 IRL external encoder with enable gate.
  .git/rebase-apply/patch:33: new blank line at EOF.
  +
  warning: 1 line adds whitespace errors.

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  drivers/pci/controller/Kconfig      |   9 +
>  drivers/pci/controller/Makefile     |   1 +
>  drivers/pci/controller/pci-sh7751.c | 293 ++++++++++++++++++++++++++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-sh7751.c

Bjorn

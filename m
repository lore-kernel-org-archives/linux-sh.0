Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACDA395D8C;
	Mon,  2 Mar 2026 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446368; cv=none; b=ngzOcrI598cmdQ/cifO2Cc6rq5ncMUPrL8+Ld95F+AHPpj8oCFGjG3ajZEIHg1D3DKMvcotbu653OZ8CqiP4mKK3/O4duhuUml/8kneaUP25V/7VYS1ba/Q/nKflH4nsyIdRS2Rjkrx2tDmYraLLfhXWm5GzXSSgYNMDMeTOmPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446368; c=relaxed/simple;
	bh=IpjrEFyehLT0TkRIrcHD2AoKqZumVIp1mwIT13gst3Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=IXKZLIpsmscTpYtrLzigIlfcr9tp2brkDLymCY6AnFGMipwj3v7VWyyIMkkI0HI2Uu17FFRKxhEcjfoZwRaFuE/K705K/LAsTfdGO2kASv9wY1FOE2bAtH93RGRZGy+GSQU8tuEyCsJmtONfbqCvXxLNSiHpCNvAd+O/LeOGJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmpAxEBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmpAxEBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F11C2BC87;
	Mon,  2 Mar 2026 10:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772446368;
	bh=IpjrEFyehLT0TkRIrcHD2AoKqZumVIp1mwIT13gst3Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=RmpAxEBGItszJNn6JGBimENj9S+2Qn+RBZDA2YHTAV8OA7rkeZ97F+C1UXno2nBlc
	 vK1NKNe3w86X2iiFv8ixqYmd3wkT7KclNB8QpHZim0RNbjeoQkl9kR/hXjrI3lv+Kg
	 XSY1K1sVa8DuXpFkKSUj7zKhO8b3LYKS8CO1sbegzrOxAejxeeObeOjhH1fhXSxqrq
	 Zj8oQxrhN5uUBmCNuw6Fr1h7mhRoOhnwuUJ01hBXkH9kf4JihMT7kgG6Rvq0qWe+a/
	 7F4NzbI6mPHVgOTjVcJPbZPjpTH0yNmeqR0BN1jy28vMmT3nILsw4wfdyuvO6oLrhK
	 7QCJmBqyJ+AQw==
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Mar 2026 11:12:43 +0100
Message-Id: <DGS7SQHM3V5U.2DNQV68AMSITF@kernel.org>
Subject: Re: [PATCH 0/3] driver core: generalize driver_override
 infrastructure
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <ysato@users.sourceforge.jp>, <dalias@libc.org>,
 <glaubitz@physik.fu-berlin.de>, <abelvesa@kernel.org>, <srini@kernel.org>,
 <s.nawrocki@samsung.com>, <nuno.sa@analog.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-hwmon@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-sound@vger.kernel.org>,
 <linux-sh@vger.kernel.org>, "Wang Jiayue" <akaieurus@gmail.com>
To: "Gui-Dong Han" <hanguidong02@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260302002729.19438-1-dakr@kernel.org>
 <CALbr=LYYUH_yQL1PO7mXzK6Oubt0LvKb0714iZCx_eEXScVdyQ@mail.gmail.com>
In-Reply-To: <CALbr=LYYUH_yQL1PO7mXzK6Oubt0LvKb0714iZCx_eEXScVdyQ@mail.gmail.com>

On Mon Mar 2, 2026 at 10:41 AM CET, Gui-Dong Han wrote:
>> Danilo Krummrich (3):
>>   driver core: generalize driver_override in struct device
>>   hwmon: axi-fan: don't use driver_override as IRQ name
>>   driver core: platform: use generic driver_override infrastructure
>
> Hi Danilo,
>
> It looks like some usages of platform_device->driver_override were
> missed. I found them here:
> - drivers/bus/simple-pm-bus.c
> - drivers/clk/imx/clk-scu.c
> - drivers/slimbus/qcom-ngd-ctrl.c
> - sound/soc/samsung/i2s.c

They should all be covered by patch 3, no?

> The good news is these can be easily updated to use the new APIs. This
> is required to avoid breaking the build, since the field is removed
> from struct platform_device. The previous build likely passed because
> these weren't enabled. I will use allyesconfig for testing going
> forward.
>
> I scanned for similar cases and most fit the new APIs perfectly. One
> exception is drivers/xen/xen-pciback/pci_stub.c. It does
> strcmp(dev->driver_override, PCISTUB_DRIVER_NAME) instead of using
> drv->name. We might want to change device_match_driver_override() to
> take a const char * instead to handle this.

xen_pcibk_pci_driver should use the exact same define, so we can just conve=
rt
this to:

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/p=
ci_stub.c
index e4b27aecbf0591..301207b4a30dac 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -609,9 +609,9 @@ static int pcistub_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)

 	match =3D pcistub_match(dev);

-	if ((dev->driver_override &&
-	     !strcmp(dev->driver_override, PCISTUB_DRIVER_NAME)) ||
-	    match) {
+	if (device_match_driver_override(&dev->dev,
+					 &xen_pcibk_pci_driver.driver) > 0 ||
+					 match) {

 		if (dev->hdr_type !=3D PCI_HEADER_TYPE_NORMAL
 		    && dev->hdr_type !=3D PCI_HEADER_TYPE_BRIDGE) {

I.e. no separate API needed.

> Besides axi-fan, I didn't find any other drivers that need to read
> driver_override. This is great, as it means we hopefully won't need to
> expose a read API at all.

Great, thanks for checking.

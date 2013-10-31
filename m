From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 31 Oct 2013 16:29:45 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <52728579.4000700@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/31/2013 08:12 PM, Ulrich Hecht wrote:
> On Thu, Oct 31, 2013 at 12:43 PM, Valentine
> <valentine.barshak@cogentembedded.com> wrote:
>> Please, let me know if you see better options.
>
> How about disregarding the whole PCI aspect? I mean, yes, those are
> PCI busses, but they are internal, with a fixed set of devices
> attached, and as far as I can tell there are no other PCI busses in
> the system. So how about treating the USB host controllers as platform
> devices the way it's done in the vendor kernel, saving us the trouble
> of pulling in the entire PCI subsystem without any tangible benefit?

There's also a PCIe bus available on the SoC. It is not yet supported,
but we'll eventually need the entire PCI subsystem, which is not that huge as it may seem, btw.

Besides, the internal PCI driver has already been submitted to the PCI mailing list
and applied to Bjorn's tree.

I don't see how treating the PCI devices as platform devices is better than
adjusting the initialization order of the USB phy.

>
> CU
> Uli
>

Thanks,
Val.

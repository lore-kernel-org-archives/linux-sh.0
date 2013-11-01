From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 01 Nov 2013 15:26:51 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <5273C83B.3020502@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/01/2013 06:32 PM, Greg KH wrote:
> On Fri, Nov 01, 2013 at 05:59:40PM +0400, Valentine wrote:
>> I'm not sure how this problem should be addressed using USB HCD PCI deferred probing.
>> However, at the same time I see that six usb phy drivers use subsys_initcall and one
>> uses postcore_initcall to adjust the initialization order.
>
> Then they are all wrong and should be fixed.  Again, this is _why_ we
> created the deferred probing logic, and it should be used for this type
> of thing, as trying to juggle init call levels is madness and you will
> loose in the end (think multi-system kernel images, how is that going to
> work?)

I'm sorry, I don't see how moving driver registration from
device_initcall to postcore_initcall alone breaks multi-system kernel image.

>
> thanks,
>
> greg k-h
>

Thanks,
Val.

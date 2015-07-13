From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2015 16:51:30 +0000
Subject: Re: [PATCH/RFC] usb: gadget: udc: core: Fix argument of dma_map_single for IOMMU
Message-Id: <CAMuHMdX80Ztr+ypaFGc9bbODNx3RgY7wVM4RESjL_z-oeMvRdw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436778605-5576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1436778605-5576-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Greg,

On Mon, Jul 13, 2015 at 6:19 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Jul 13, 2015 at 06:10:05PM +0900, Yoshihiro Shimoda wrote:
>> The dma_map_single and dma_unmap_single should set "gadget->dev.parent"
>> instead of "&gadget->dev" in the first argument because the parent has
>> a udc controller's device pointer.
>> Otherwise, iommu functions are not called in ARM environment.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  This patch is based on the Felipe's usb.git / testing/next branch.
>>  commit id = 298623983e74d935fc241d0eb1d0740cf4c32599
>
> Why send something that has already been accepted into Felipe's tree?

That commit ID does not refer to Shimoda-san's patch, but to the HEAD of
Felipe's testing/next branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

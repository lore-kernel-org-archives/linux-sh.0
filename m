From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2016 10:09:47 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document SoC specific bindings
Message-Id: <CAMuHMdXVBSjTb_-7o4rDh_S+i64QKEr-5KUnSfd3Nqt1D1TE2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
	<20151116035533.GC25173@localhost>
In-Reply-To: <20151116035533.GC25173@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Vinod,

On Mon, Nov 16, 2015 at 4:55 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Nov 12, 2015 at 10:53:59AM +0900, Simon Horman wrote:
>> In general Renesas hardware is not documented to the extent where the
>> relationship between IP blocks on different SoCs can be assumed although
>> they may appear to operate the same way. Furthermore the documentation
>> typically does not specify a version for individual IP blocks. For these
>> reasons a convention of using the SoC name in place of a version and
>> providing SoC-specific compat strings has been adopted.
>>
>> Although not universally liked this convention is used in the bindings for
>> most drivers for Renesas hardware. The purpose of this patch is to
>> update the Renesas R-Car DMA Controller driver to follow this convention.
>
> Applied, thanks

This patch (and this patch only) has disappeared from your next branch between
January 6 and 7, and thus wasn't included in your pull request for v4.5.

Was there a specific reason for that, or was it just an oversight?

Note that the added compatible values in in use (in arm-soc/for-next).

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

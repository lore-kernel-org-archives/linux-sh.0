From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Apr 2010 07:03:08 +0000
Subject: Re: [PATCH] sh-sci: Extend sh-sci driver with early console V2
Message-Id: <20100426070308.GE11770@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091214102442.13038.43809.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Apr 25, 2010 at 09:30:09PM +0900, Shin-ichiro KAWASAKI wrote:
> Hi, Magnus-san, and Alex-san,
> 
> Thank you very much for your guides.
> Setting "CONFIG_SERIAL_SH_SCI_NR_UARTS=2" solved my problem fully.
> I find no qemu crash, and happy to see login prompt again.
> 
> I tried out these two option with real R2D+ boards and recent sh-2.6 git.
>   CONFIG_SERIAL_SH_SCI_NR_UARTS=1  ... no serial output
>   CONFIG_SERIAL_SH_SCI_NR_UARTS=2  ... kernel boot log printed in serial 
>   output
> 
> I hope the patch applied soon :)
> 
It's queued for 2.6.34 now, thanks for testing.

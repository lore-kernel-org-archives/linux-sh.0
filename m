From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Oct 2015 13:10:37 +0000
Subject: Re: [PATCH 0/2] dmaengine: usb-dmac: Runtime PM Related Fixes
Message-Id: <CAMuHMdVGq19174R=+D_hrzj-XPY8PaKvif3nB=sDq62KCuM5Xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443684138-32252-1-git-send-email-geert+renesas@glider.be>
	<20151007140124.GC3320@vkoul-mobl.iind.intel.com>
In-Reply-To: <20151007140124.GC3320@vkoul-mobl.iind.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Vinod,

On Wed, Oct 7, 2015 at 4:01 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Oct 01, 2015 at 09:22:16AM +0200, Geert Uytterhoeven wrote:
>>       Hi Vinod, Shimoda-san,
>>
>> This series fixes a crash and an imbalance in the usb-dmac driver.
>
> Sorry this fails for me, what was this generated against

Strange, this series still applies cleanly on top of slave-dma/next and
linus/master.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 07 Jan 2014 21:52:14 +0000
Subject: Re: [PATCH 0/4] thermal: rcar: Add missing clock handling
Message-Id: <52CC770E.1000004@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 01/07/2014 10:57 PM, Geert Uytterhoeven wrote:
>      Hi all,

Hi Geert,

>
> This patch series fixes a problem when the thermal-rcar device is
> instantiated from the device tree on the r8a7791-based Koelsch development
> board. The driver fails during initialization with:

I think explicitly acquiring the clocks should not be needed.
Could you please try the patches from the following series instead?

http://marc.info/?l=linux-sh&m8823255807611&w=2

Thanks,
Val.

>
>      rcar_thermal e61f0000.thermal: thermal sensor was broken
>
> This does not happen when using legacy platform devices.
>
> This series was tested using Koelsch reference (DT) and non-reference
> (legacy) kernel configurations. It was not tested on r8a7790/Lager
> (which is very similar).
>
>      [1/4] ARM: shmobile: r8a7791: Add thermal clock in device tree
>      [2/4] ARM: shmobile: r8a7790: Add thermal clock in device tree
>      [3/4] thermal: rcar: Add missing clock handling
>      [4/4] thermal: rcar: Spelling s/delaye/delay/g
>

> Thanks for your comments!
>
> Gr{oetje,eeting}s,
>
> 						Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


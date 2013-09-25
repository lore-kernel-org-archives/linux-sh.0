From: Chris Ball <cjb@laptop.org>
Date: Wed, 25 Sep 2013 00:59:22 +0000
Subject: Re: [PATCH] sh: ecovec: fixup compile error on sdhi
Message-Id: <86pprxd8d1.fsf@void.printf.net>
List-Id: <linux-sh.vger.kernel.org>
References: <87li2mr4dw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li2mr4dw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Wed, Sep 25 2013, Simon Horman wrote:
> [ Cc Chris Ball ]
>
> On Tue, Sep 24, 2013 at 01:49:19AM -0700, Kuninori Morimoto wrote:
>> afa2c9407f8908e2269b243773cbb0997c553804
>> (sh: ecovec24: Use MMC/SDHI CD and RO GPIO)
>> added .tmio_flags = TMIO_MMC_USE_GPIO_CD
>> on sh_mobile_sdhi_info, but it needs
>> <linux/mfd/tmio.h> header.
>> This patch adds it
>> 
>> Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>> Simon, Paul, Magnus
>> 
>>        This patch is for SH, but Paul can pick up it ?
>>        Or Simon can ? I'm not sure...
>
> I don't believe Paul is actively working on this code at this time.
> While I am happy to pick this up I don't have an obvious
> avenue to push it upstream.
>
> Chris has previously taken MMCIF/SDHI related patches to this file
> (and only this file) through his tree. Chris, would you consider
> taking this one once it has been reviewed?

Looks like I (via mmc-next) am responsible for merging the commit
that broke it, so I'm happy to merge the fix with an ACK.  Thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>

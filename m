From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Date: Tue, 10 Nov 2015 05:15:13 +0000
Subject: Re: [PATCH 0/2] thermal: rcar_thermal: tidyup rebind issue
Message-Id: <56417D61.80407@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, cm-hiep@jinso.co.jp

Hi,

I have tested rcar_thermal funstion on stable linux v4.3.
It is good with this patchs.

Tested-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>

Best regards
Nguyen Viet Dung

On 2015年11月10日 11:11, Kuninori Morimoto wrote:
> Hi Zhang, Eduardo
> Cc: Dung, Hiep
>
> rcar_thermal doesn't work after unbind/re-bind today.
> These patches are cosmetic, and tidyup it
>
> Kuninori Morimoto (2):
>        thermal: rcar_thermal: remove redundant operation
>        thermal: rcar_thermal: use pm_runtime_put_sync()
>
>   drivers/thermal/rcar_thermal.c | 49 +++++++++++++++++++++----------------------------
>   1 file changed, 21 insertions(+), 28 deletions(-)
>
>
> Best regards
> ---
> Kuninori Morimoto
>


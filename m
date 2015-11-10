From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Date: Tue, 10 Nov 2015 02:27:08 +0000
Subject: Re: [PATCH 0/2] thermal: rcar_thermal: tidyup rebind issue
Message-Id: <564155FC.3030900@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com>
 <87fv0elibh.wl%kuninori.morimoto.gx@renesas.com>
 <87bnb2lhzv.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnb2lhzv.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, cm-hiep@jinso.co.jp

Dear Mr Morimoto

we go to test rcar_thermal funstion with this patchs.
If result is good I will send Tested-by nv-dung

best regard
Nguyen Viet Dung

On 2015年11月10日 11:18, Kuninori Morimoto wrote:
> Hi
>
> Actually, these issue are reported by Dung Hiep,
> but I didn't add their name on these patches.
> Thus, Dung, Hiep, can you please send Tested-by for these ?
>
>> rcar_thermal doesn't work after unbind/re-bind today.
>> These patches are cosmetic, and tidyup it
>>
>> Kuninori Morimoto (2):
>>        thermal: rcar_thermal: remove redundant operation
>>        thermal: rcar_thermal: use pm_runtime_put_sync()
>>
>>   drivers/thermal/rcar_thermal.c | 49 +++++++++++++++++++++----------------------------
>>   1 file changed, 21 insertions(+), 28 deletions(-)
>>
>>
>> Best regards
>> ---
>> Kuninori Morimoto

